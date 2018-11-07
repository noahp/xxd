
CFLAGS += -std=c99 -Wall -Wextra -Wpedantic -Werror -g

ifeq ($(DISABLE_LIBASAN),)
  CFLAGS += -fsanitize=address -fsanitize=undefined -fstack-usage -static-libasan
endif

.PHONY: all
all: xxd test

# run against a few test inputs
# using order-only to separate the test input files. since it's a .PHONY rule it
# always runs anyway
.PHONY: test
test: xxd | testinput/* xxd.c README.md
	echo $| | xargs -d " " -I % bash -c "diff -du <(xxd %) <(./xxd %)"

xxd: main.c xxd.c
	$(CC) $(CFLAGS) $^ -o $@

# just use git clean tbh
.PHONY: clean
clean:
	rm -f *.o *.su xxd
