#!/usr/bin/env bash

# set -euo pipefail

main() {
    if [[ "${EUID}" -ne 0 ]]; then
        echo "This script must be run with root privileges. Use 'sudo'." >&2
        exit 1
    fi

    local user_name="${SUDO_USER:-root}"
    local user_home
    user_home=$(getent passwd "${user_name}" | cut -d: -f6)
    readonly user_name user_home

    local dotfiles_dir
    dotfiles_dir=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
    readonly dotfiles_dir

    local py_ver="3.13"
    readonly py_ver

    setup_system "${py_ver}"
    setup_dotfiles "${dotfiles_dir}" "${user_home}"
    install_dev_tools "${user_name}" "${user_home}" "${py_ver}"
    install_miniconda "${user_name}" "${user_home}"
    cleanup_system

    echo "Setup complete. Restart your shell or run 'source ${user_home}/.bashrc' to apply changes."
}

setup_system() {
    local py_ver=$1
    export DEBIAN_FRONTEND=noninteractive

    echo 'tzdata tzdata/Areas select Etc' | debconf-set-selections
    echo 'tzdata tzdata/Zones/Etc select UTC' | debconf-set-selections

    apt-get update -y
    apt-get install -y --no-install-recommends software-properties-common
    add-apt-repository -y ppa:deadsnakes/ppa
    apt-get update -y

    apt-get install -y --no-install-recommends \
        build-essential curl git sudo zip p7zip-full vim tmux wget tzdata \
        ripgrep universal-ctags silversearcher-ag fd-find pylint net-tools \
        exuberant-ctags cscope \
        "python${py_ver}" "python${py_ver}-dev" "python3-setuptools" "python${py_ver}-venv"
}

setup_dotfiles() {
    local dotfiles_dir=$1
    local user_home=$2

    local files_to_link=(
        .bashrc .bash_aliases .gdbinit .gitconfig .gitignore_global
        .pythonrc .tmux.conf .tmux.reset.conf .vimrc
    )

    echo "Linking dotfiles to ${user_home}..."
    for file in "${files_to_link[@]}"; do
        ln -snf "${dotfiles_dir}/${file}" "${user_home}/${file}"
    done
}

install_dev_tools() {
    local user_name=$1
    local user_home=$2
    local py_ver=$3

    mkdir -p "${user_home}/.local/bin"
    ln -snf "$(which fdfind)" "${user_home}/.local/bin/fd"

    run_as_user "${user_name}" "${user_home}" "curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim"

    echo "Installing Vim plugins..."
    run_as_user "${user_name}" "${user_home}" "vim +PlugInstall +qall"

    run_as_user "${user_name}" "${user_home}" "curl -sS https://bootstrap.pypa.io/get-pip.py | python${py_ver}"

    if [[ ! -d "${user_home}/.fzf" ]]; then
        run_as_user "${user_name}" "${user_home}" "git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf && ~/.fzf/install --all"
    fi

    if [[ ! -d "${user_home}/.tmux/plugins/tpm" ]]; then
        run_as_user "${user_name}" "${user_home}" "git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm && ~/.tmux/plugins/tpm/bin/install_plugins"
    fi
}

install_miniconda() {
    local user_name=$1
    local user_home=$2
    local miniconda_path="${user_home}/miniconda3"

    if [[ -d "${miniconda_path}" ]]; then
        echo "Miniconda already installed."
        return
    fi

    local installer_path="/tmp/miniconda.sh"
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O "${installer_path}"
    run_as_user "${user_name}" "${user_home}" "bash ${installer_path} -b -u -p ${miniconda_path}"
    rm -f "${installer_path}"

    # Ensure ownership is correct, especially in sudo case
    chown -R "${user_name}:${user_name}" "${miniconda_path}"
}

run_as_user() {
    local user=$1
    local home=$2
    local cmd=$3
    sudo -u "${user}" bash -c "export HOME=${home}; ${cmd}"
}

cleanup_system() {
    apt-get autoremove -y --purge
    apt-get clean
    rm -rf /var/lib/apt/lists/*
}

main "$@"
