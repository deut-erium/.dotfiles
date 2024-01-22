add-apt-repository -y ppa:deadsnakes/ppa
sudo add-apt-repository ppa:jonathonf/vim

apt-get -y update && apt-get -y upgrade && \
      apt-get install -y build-essential \
      curl \
      git \
      sudo \
      zip \
      p7zip-full \
      vim \
      tmux \
      python3.12 python3.12-distutils libpython3.12-dev

export DEBIAN_FRONTEND=noninteractive; \
    export DEBCONF_NONINTERACTIVE_SEEN=true; \
    echo 'tzdata tzdata/Areas select Etc' | debconf-set-selections; \
    echo 'tzdata tzdata/Zones/Etc select UTC' | debconf-set-selections; \
    apt-get update -qqy \
 && apt-get install -qqy --no-install-recommends \
        tzdata \
 && apt-get clean \
# && rm -rf /var/lib/apt/lists/*

apt-get install -y software-properties-common

# cp -r .bashrc .bash_aliases .gdbinit .gitconfig .gitignore_global .pythonrc .tmux.conf .tmux.reset.conf peda

curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

curl -sS https://bootstrap.pypa.io/get-pip.py | python3.12

apt install -y \
    ripgrep \
    universal-ctags \
    silversearcher-ag \
    fd-find \
    pylint \
    net-tools \
    cscope

ln -s $(which fdfind) ~/.local/bin/fd

git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install --all

