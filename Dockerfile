FROM ubuntu:disco

# Switch to ppa mirrors to speed up apt
RUN sed -i -e 's/deb http:\/\/archive.ubuntu.com\/ubuntu\//deb mirror:\/\/mirrors.ubuntu.com\/mirrors.txt/' /etc/apt/sources.list

RUN apt-get update && apt-get install -y \
  build-essential \
  cppcheck \
  clang-8 \
  clang-tidy-8 \
  clang-tools-8 \
  curl \
  gcc-9 \
  git \
  lcov \
  pkg-config \
  python \
  python-pip \
  valgrind \
  xxd

ENV CC gcc-9

RUN pip install cpp-coveralls
