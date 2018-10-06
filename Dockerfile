FROM ubuntu:cosmic

RUN apt-get update
RUN apt-get install -y \
  binutils-dev \
  build-essential \
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

CMD bash -c \
  "cd /tmp/xxd-test && \
  make -j6 && \
  make clean && \
  DISABLE_LIBASAN=y make xxd -j6 && \
  kcov --coveralls-id=$TRAVIS_JOB_ID kcov-output --include-path=/tmp/xxd-test/xxd.c ./xxd xxd.c"
