#!/usr/bin/env bash
set -ex

# All the steps run by CI. Should work locally too!
docker build -t xxd-test .

# run scan-build
docker run -v"$(pwd):/mnt/workspace" xxd-test bash -c \
    "cp -r /mnt/workspace /tmp/xxd-test && cd /tmp/xxd-test && \
     DISABLE_LIBASAN=y CC=clang-7 scan-build-7 --status-bugs make"

# run default build command
docker run -v"$(pwd):/mnt/workspace" --cap-add SYS_PTRACE xxd-test bash -c \
    "cp -r /mnt/workspace /tmp/xxd-test && cd /tmp/xxd-test && \
     make -j6"

# run cppcheck
docker run -v"$(pwd):/mnt/workspace" xxd-test bash -c \
    "cp -r /mnt/workspace /tmp/xxd-test && cd /tmp/xxd-test && \
     cppcheck --error-exitcode=1 --enable=style \$(find . -name '*.c' -type f)"

# run clang-tidy
docker run -v"$(pwd):/mnt/workspace" xxd-test bash -c \
    "cp -r /mnt/workspace /tmp/xxd-test && cd /tmp/xxd-test && \
     clang-tidy-7 -checks='*' \$(find . -name '*.c' -type f)"

# run full build, including lcov coverage upload
# need to propagate a lot of travis env variables through...
# --env-file is another option
docker run \
    -e COVERALLS_UPLOAD \
    -e CODECOV_UPLOAD \
    -e CI \
    -e TRAVIS \
    -e TRAVIS_PULL_REQUEST_SHA \
    -e TRAVIS_COMMIT \
    -e TRAVIS_JOB_NUMBER \
    -e TRAVIS_PULL_REQUEST \
    -e TRAVIS_JOB_ID \
    -e TRAVIS_REPO_SLUG \
    -e TRAVIS_OS_NAME \
    -e TRAVIS_TAG \
    -e TRAVIS_BRANCH \
    --security-opt seccomp:unconfined \
    -v"$(pwd):/mnt/workspace" xxd-test bash -c \
    "cp -r /mnt/workspace /tmp/xxd-test && cd /tmp/xxd-test && \
     XXD_COVERAGE=1 LCOV=lcov make && \
     if [[ -n \$COVERALLS_UPLOAD ]]; \
     then \
     (coveralls -n -i ./ -e example.c -l coverage_filtered.info); \
     fi && \
     if [[ -n \$CODECOV_UPLOAD ]]; \
     then \
     (curl -s https://codecov.io/bash | bash -s - -X gcov -f coverage_filtered.info); \
     fi"
