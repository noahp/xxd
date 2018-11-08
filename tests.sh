#!/usr/bin/env bash
set -ex

# All the steps run by CI. Should work locally too!
docker build -t xxd-test .

# run scan-build
docker run xxd-test bash -c \
    "cd /tmp/xxd-test && \
     DISABLE_LIBASAN=y CC=clang-7 scan-build-7 --status-bugs make"

# run default build command
docker run --cap-add SYS_PTRACE xxd-test

# run full build, including kcov coverage upload
docker run --cap-add SYS_PTRACE -e "TRAVIS_JOB_ID=$TRAVIS_JOB_ID" \
    --security-opt seccomp:unconfined xxd-test bash -c \
    "cd /tmp/xxd-test && \
     DISABLE_LIBASAN=y make xxd && \
     kcov --coveralls-id=$TRAVIS_JOB_ID kcov-output --include-path=/tmp/xxd-test/xxd.c ./xxd xxd.c"
