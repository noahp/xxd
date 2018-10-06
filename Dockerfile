FROM alpine:edge

RUN apk update
RUN apk add --no-cache gcc=8.2.0-r0 musl-dev bash make strace

COPY . /tmp/xxd-test

CMD bash -c "cd /tmp/xxd-test && make"
