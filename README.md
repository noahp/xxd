[![Build Status](https://travis-ci.com/noahp/xxd.svg?branch=master)](https://travis-ci.com/noahp/xxd)
[![codecov](https://codecov.io/gh/noahp/xxd/branch/master/graph/badge.svg)](https://codecov.io/gh/noahp/xxd)

# 👻 xxd

Stunt / code golf, got out of hand.

## usage

Copy `xxd.c` + `xxd.h` into your project, or copy the contents of `xxd.c`.

## build standalone

Use docker..

### docker quickstart

On ubuntu as easy as:

```bash
# install docker
sudo apt install docker.io
# add your user to the 'docker' group to avoid needing sudo
sudo usermod -aG docker $USER
newgrp docker
# log out and back in so usermod takes effect
```

### run

You can run exactly what CI does by doing:

```bash
./tests.sh
```

That will build the docker image, and run the tests.

### run more

If you want to run the steps manually-

```bash
docker build -t xxd-test .

# --cap-add SYS_PTRACE is for address sanitizer
docker run --cap-add SYS_PTRACE xxd-test
```
