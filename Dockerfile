FROM ubuntu:cosmic

RUN apt-get update && apt-get install -y \
  binutils-dev \
  build-essential \
  clang-7 \
  clang-tools-7 \
  cmake \
  curl \
  g++ \
  gcc \
  git \
  libcurl4-openssl-dev \
  libdw-dev \
  libiberty-dev \
  python \
  wget \
  xxd \
  zlib1g-dev

# get kcov
RUN bash -c "cd /tmp && \
  wget https://github.com/SimonKagstrom/kcov/archive/v36.tar.gz && \
  tar xzf v*.tar.gz && \
  cd kcov-* && \
  mkdir build && \
  cd build && \
  cmake ../ && \
  make -j6 && \
  make install"

COPY . /tmp/xxd-test

CMD bash -c "cd /tmp/xxd-test && make -j6"
