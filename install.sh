apt-get -y update && apt-get -y upgrade && \
      apt-get install -y build-essential \
      curl \
      git \
      sudo \
      zip \
      p7zip \
      vim

add-apt-repository ppa:deadsnakes/ppa
apt-get install -y python3.9 python3-pip
sudo apt-get install -y docker \
      docker-compose \
      tmux \
      default-jre \
      default-jdk \
      maven \
      gradle 

apt-get install -y libgmp3-dev libmpfr-dev libmpc-dev

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

# docker pull hyperreality/cryptohack
# docker pull razaborg/rsactftool
# cyrilbouvier/cado-nfs.py`
