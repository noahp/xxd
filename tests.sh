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

# run full build, including lcov coverage upload
docker run -e "COVERALLS_UPLOAD=$COVERALLS_UPLOAD" \
    -e "CODECOV_UPLOAD=$CODECOV_UPLOAD" \
    -e "TRAVIS_JOB_ID=$TRAVIS_JOB_ID" \
    --security-opt seccomp:unconfined xxd-test bash -c \
    "cd /tmp/xxd-test && \
     XXD_COVERAGE=1 LCOV=lcov make && \
     if [[ -n \$COVERALLS_UPLOAD ]]; \
     then \
     (coveralls -n -i ./ -e example.c -l coverage_filtered.info); \
     fi && \
     if [[ -n \$CODECOV_UPLOAD ]]; \
     then \
     (curl -s https://codecov.io/bash | bash -s - -X gcov -d -f coverage_filtered.info); \
     fi"
