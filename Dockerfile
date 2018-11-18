#FROM ubuntu:cosmic

# alpine:3.4 is the latest version that supports py cffi
# pip install cpp-coveralls requires it
FROM alpine:3.4
RUN apk add --no-cache \
    bash \
    clang \
    clang-analyzer \
    build-base \
    git \
    libffi-dev \
    openssl-dev \
    perl \
    python \
    python-dev \
    py-pip


#RUN apt-get update && apt-get install -y \
#  build-essential \
#  clang-7 \
#  clang-tools-7 \
#  curl \
#  gcc \
#  git \
#  lcov \
#  python \
#  python-pip \
#  xxd

RUN pip install cpp-coveralls

COPY . /tmp/xxd-test

CMD bash -c "cd /tmp/xxd-test && make -j6"
