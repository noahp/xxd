[![Coverage Status](https://coveralls.io/repos/github/noahp/xxd/badge.svg?branch=master)](https://coveralls.io/github/noahp/xxd?branch=master)
[![Build Status](https://travis-ci.com/noahp/xxd.svg?branch=master)](https://travis-ci.com/noahp/xxd)

# 👻 xxd
Stunt / code golf, got out of hand.

# usage
Copy `xxd.c` + `xxd.h` into your project, or copy the contents of `xxd.c`.

# build standalone
Use docker..
## docker quickstart
On ubuntu as easy as:
```bash
# install docker
sudo apt install docker.io
# add your user to the 'docker' group to avoid needing sudo
sudo usermod -aG docker $USER
newgrp docker
# log out and back in so usermod takes effect
```

## run
You can run exactly what CI does by doing:
```bash
./tests.sh
```

## run more
If you want to run the steps manually-
```bash
docker build -t xxd-test .

# on build, the image copies the current working dir into /tmp/xxd-test for CI
# to use, so note that your changes won't be propogated without rebuilding.
# --cap-add SYS_PTRACE is for address sanitizer
docker run --cap-add SYS_PTRACE xxd-test

# you can optionally just bind mount the current dir if you're making mods:
docker run --cap-add SYS_PTRACE -v "$(pwd):/tmp/xxd-test" xxd-test
# that will write build output into the cwd though so be aware.
```
