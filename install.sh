apt-get -y update && apt-get -y upgrade && \
      apt-get install -y build-essential \
      curl \
      git \
      sudo \
      zip \
      p7zip-full \
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
apt-get install -y python3.10 python3.10-distutils libpython3.10-dev

curl -sS https://bootstrap.pypa.io/get-pip.py | python3.10

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
    net-tools \
    radare2 \
    exif \
    cython \
    swig \
    cmake \
    pandoc \
    pylint

apt install -y \
    fzf \
    ripgrep \
    universal-ctags \
    silversearcher-ag \
    fd-find \
    pygmentize

apt-get install -y pandoc \
    texlive-latex-base \
    texlive-latex-extra \
    texlive-xetex

apt-get install -y docker \
      docker-compose \
      # default-jre \
      # default-jdk \
      # maven \
      # gradle \
      # firefox \
      # firefox-geckodriver \
      # libgtk-3-dev \
      # libgtk2.0-dev \
      # freeglut3-dev \
      # ffmpeg \
      # timidity \



        

python3.10 -m pip install tqdm \
      z3-solver \
      sympy \
      pwntools \
      pycryptodome \
      beautifulsoup4 \
      factordb-python \
      grequests \
      numpy \
      pandas \
      pillow \
      matplotlib \
      scipy \
      sklearn \
      virtualenv \
      autopep8

# python3.10 -m pip install \
#     nltk \
#     youtube-dl \
#     pygame \
#     tkinter \
#     python-tk \
#     PySimpleGUI \
#     tensorflow \
#     torch \
#     torchvision \
#     faker \
#     # wslwinreg \ 
#     bitarray \
#     scikit-opt \
#     protobuf \
#     hvplot \
#     bokeh \
#     selenium \
#     holoviews \
#     django


pypy3 -m pip install \
    tqdm \
    z3-solver \
    sympy \
    pycryptodome \
    numpy \
    pillow \
    pysmt \
    python-sat

# pysmt-install --msat --confirm-agreement
# pysmt-install --cvc4 --confirm-agreement
# pysmt-install --yices --confirm-agreement
# pysmt-install --btor --confirm-agreement
# pysmt-install --picosat --confirm-agreement
# pysmt-install --bdd --confirm-agreement
# docker pull hyperreality/cryptohack
# docker pull razaborg/rsactftool
# docker pull cyrilbouvier/cado-nfs.py`

# pushd .dotfiles
# cp -r .bashrc .gdbinit .vimrc .inputrc .tmux.conf install.sh peda ~
# popd 

# git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim 
# vim +PluginInstall +qall


# sagemath stuff
# apt-get install -y bc binutils bzip2 ca-certificates cliquer curl eclib-tools fflas-ffpack flintqs g++ g++ gcc gcc gfan gfortran glpk-utils gmp-ecm lcalc libatomic-ops-dev libboost-dev libbraiding-dev libbrial-dev libbrial-groebner-dev libbz2-dev libcdd-dev libcdd-tools libcliquer-dev libcurl4-openssl-dev libec-dev libecm-dev libffi-dev libflint-arb-dev libflint-dev libfreetype6-dev libgc-dev libgd-dev libgf2x-dev libgiac-dev libgivaro-dev libglpk-dev libgmp-dev libgsl-dev libhomfly-dev libiml-dev liblfunction-dev liblrcalc-dev liblzma-dev libm4rie-dev libmpc-dev libmpfi-dev libmpfr-dev libncurses5-dev libntl-dev libopenblas-dev libpari-dev libpcre3-dev libplanarity-dev libppl-dev libpython3-dev libreadline-dev librw-dev libsqlite3-dev libssl-dev libsuitesparse-dev libsymmetrica2-dev libz-dev libzmq3-dev libzn-poly-dev m4 make nauty openssl palp pari-doc pari-elldata pari-galdata pari-galpol pari-gp2c pari-seadata patch perl pkg-config planarity ppl-dev python3 python3 python3-distutils r-base-dev r-cran-lattice sqlite3 sympow tachyon tar xcas xz-utils yasm

# wget https://www.mirrorservice.org/sites/www.sagemath.org/src/sage-9.4.tar.gz 
# tar -xvf sage-9.4.tar.gz
# cd sage-9.4/
# MAKE='make -j15' make
# ./configure && make
# ln -s $(pwd)/sage /usr/bin/sage
