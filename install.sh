apt-get -y update && apt-get -y upgrade && \
      apt-get install -y build-essential \
      curl \
      git \
      sudo \
      zip \
      p7zip \
      vim \
      tmux

export DEBIAN_FRONTEND=noninteractive; \
    export DEBCONF_NONINTERACTIVE_SEEN=true; \
    echo 'tzdata tzdata/Areas select Etc' | debconf-set-selections; \
    echo 'tzdata tzdata/Zones/Etc select UTC' | debconf-set-selections; \
    apt-get update -qqy \
 && apt-get install -qqy --no-install-recommends \
        tzdata \
 && apt-get clean \
# && rm -rf /var/lib/apt/lists/*

apt install -y software-properties-common
apt-get install -y software-properties-common

add-apt-repository -y ppa:deadsnakes/ppa ppa:pypy/ppa
apt-get install -y python3.9 python3-pip

apt-get install -y \
    libgmp3-dev \
    libmpfr-dev \
    libmpc-dev \
    pypy3 \
    gdb \
    # sagemath-common \
    # sagemath \
    nmap \
    binwalk \
    nasm \
    fasm \
    radare2 \
    exif




sudo apt-get install -y docker \
      docker-compose \
      default-jre \
      default-jdk \
      maven \
      gradle 


pip3 install tqdm \
      z3-solver \
      gmpy2 \
      sympy \
      pwntools \
      pycryptodome \
      fastecdsa \
      beautifulsoup4 \
      factordb-python \
      grequests \
      numpy \
      pandas \
      pillow \
      matplotlib \
      scipy \
      sklearn \
      autopep8

pypy3 -m pip install \
    tqdm \
    z3-solver \
    sympy \
    pycryptodome \
    numpy \
    pillow \
    pysmt 

# docker pull hyperreality/cryptohack
# docker pull razaborg/rsactftool
# cyrilbouvier/cado-nfs.py`

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim && vim +PluginInstall +qall
# cython swig cmake

