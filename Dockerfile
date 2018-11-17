FROM ubuntu:cosmic

RUN apt-get update && apt-get install -y \
  build-essential \
  clang-7 \
  clang-tools-7 \
  curl \
  gcc \
  git \
  lcov \
  python \
  python-pip \
  xxd

RUN pip install cpp-coveralls

COPY . /tmp/xxd-test

CMD bash -c "cd /tmp/xxd-test && make -j6"
