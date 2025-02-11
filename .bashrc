# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

HISTCONTROL=ignoredups:erasedups

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000000
HISTFILESIZE=1000000

# save history of multiple bash shells
shopt -s histappend
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND" 

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        # We have color support; assume it's compliant with Ecma-48
        # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
        # a case would tend to support setf rather than setaf.)
        color_prompt=yes
    else
        color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] $(date +%T) \$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u:\w\ $(date +%T) $ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi
shopt -s expand_aliases

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# ctf-tools: gem install
export PATH=$PATH:/bin
export PATH=$PATH:/usr/local/cuda/bin
rmd () {
          pandoc -t plain $1 | less
  }
rmd1 () {
          mdv $1
  }
rmd2 () {
          pandoc $1 | w3m -T text/html
  }
rmd3 () {
          mdless $1
  }
rmd4 () {
          grip -b $1
  }

alias ccat='pygmentize -g'

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PROMPT_DIRTRIM=2
alias apep="autopep8 --in-place --aggressive --aggressive"
alias vimtricks="vim ~/.dotfiles/cheatsheet"
alias pwdd="echo '\"'$(pwd)'\"' | clip.exe"
pwdc (){
    path=`wslpath -w "$(pwd)"`
    echo '"'$path'"' | clip.exe
}
alias yt-audio="youtube-dl -f bestaudio --extract-audio --audio-format mp3 --audio-quality 320"
alias py3="python3.12"
alias pp="python3.12 -m pip"
alias fd="fdfind"
alias so="source ~/.bashrc"


alias so="source ~/.bashrc"
mid2mp3 () {
    # ffmpeg -i "$1" -vn -ab 128k -ar 44100 -y "${1%.mid}.mp3";
    timidity "$1" -Ow -o - | ffmpeg -i - -acodec libmp3lame -ab 320k "${1%.mid}.mp3"
}

if grep -q microsoft /proc/version; then
    cmd() {
      CMD=$1
      shift;
      ARGS=$@
      WIN_PWD=`wslpath -w "$(pwd)"`
      cmd.exe /c "pushd ${WIN_PWD} && ${CMD} ${ARGS}"
    }

    VSWHERE_PATH="/mnt/c/Program Files (x86)/Microsoft Visual Studio/Installer/vswhere.exe"
    VS_INSTALL_DIR=$("${VSWHERE_PATH}" -latest -property installationPath)
    VCVARS_BAT="${VS_INSTALL_DIR}\VC\Auxiliary\Build\vcvars64.bat"
    VC_DEVENV="${VS_INSTALL_DIR}\Common7\IDE\devenv.exe"
    cmd_vc() {
        cmd.exe /V /C @ "${VCVARS_BAT}" "&&" "$@"
    }
    cmd_devenv() {
        cmd.exe /v /c @ "${VC_DEVENV}" "&&" "$@"
    }
fi

md2pdf() {
    pandoc $1 -o $2 --highlight-style=tango \
        --pdf-engine=xelatex \
        --listings -H ~/.dotfiles/templates/listings-setup.tex \
        -H ~/.dotfiles/templates/math-setup.tex
}

vdf() {
    vimdiff ~/$1 ~/.dotfiles/$1
}

gcq() {
    cppcheck --enable=all --std=c99 --suppress=missingIncludeSystem $1
    gcc -Wall -Wextra -Wpedantic -ggdb -fno-sanitize=all -fno-omit-frame-pointer -static-liblsan -lrt $1 -o ${1%%.*}
}

mux() {
    pgrep -vx tmux > /dev/null && \
    tmux new -d -s delete-me && \
    tmux run-shell ~/.tmux/plugins/tmux-resurrect/scripts/restore.sh && \
    tmux kill-session -t delete-me && \
    tmux attach || tmux attach
}


print_tree_with_content() {
    local dir="$1"
    local prefix="$2"

    # List all files and directories in the current directory
    for entry in "$dir"/*; do
        if [ -d "$entry" ]; then
            # If it's a directory, print the directory name and recurse
            echo "${prefix}$(basename "$entry")/"
            print_tree_with_content "$entry" "$prefix  "
        elif [ -f "$entry" ]; then
            # If it's a file, determine if it's binary or text
            file_type=$(file --mime-type -b "$entry")
            
            echo "${prefix}- $(basename "$entry") :"
            
            if [[ "$file_type" == text/* ]]; then
                # If it's a text file, print its content
                sed 's/^/'"$prefix"'  /' "$entry"  # Indent file content
            else
                # If it's a binary file, produce a hexdump
                hexdump -C "$entry" | sed 's/^/'"$prefix"'  /'  # Indent hexdump output
            fi
        fi
    done
}

spawn_tmux_panes() {
    local command="$1"
    shift
    local args=("$@")

    # Iterate over each argument and create a new split window
    for arg in "${args[@]}"; do
        tmux split-window "$command $arg; bash"
    done

    # arrange the panes in a tiled layout
    tmux select-layout tiled
}

# spawn_tmux_panes "echo" "arg1" "arg2" "arg3" ..

gdf() {
    git difftool $1^..$1
}


[ -f ~/.fzf.bash ] && source ~/.fzf.bash 
# fzf ctrl-r and alt-c behavior
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi
export FZF_DEFAULT_OPTS="--history=$HOME/.fzf_history"
export FZF_DEFAULT_COMMAND="fdfind --type f --hidden --follow --exclude={**.git/*,**.svn/*,**/build/*,**/tmp/*}"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND – type d"
export JEKYLL_ENV=deployment
export PYTHONSTARTUP=~/.dotfiles/.pythonrc
export PYTHON_HISTORY_FILE=~/.dotfiles/.python_history
export EDITOR="vim"
export HF_HUB_ENABLE_HF_TRANSFER=1
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
