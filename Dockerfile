FROM ubuntu:cosmic

# Switch to ppa mirrors to speed up apt
RUN sed -i -e 's/deb http:\/\/archive.ubuntu.com\/ubuntu\//deb mirror:\/\/mirrors.ubuntu.com\/mirrors.txt/' /etc/apt/sources.list

RUN apt-get update && apt-get install -y \
  build-essential \
  cppcheck \
  clang-7 \
  clang-tidy-7 \
  clang-tools-7 \
  curl \
  gcc \
  git \
  lcov \
  pkg-config \
  python \
  python-pip \
  xxd

RUN pip install cpp-coveralls
