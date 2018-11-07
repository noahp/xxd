
CFLAGS += -std=c99 -Wall -Wextra -Wpedantic -Werror -g

ifeq ($(DISABLE_LIBASAN),)
  CFLAGS += -fsanitize=address -fsanitize=undefined -fstack-usage -static-libasan
endif

.PHONY: all
all: xxd test

.PHONY: test
test: xxd
	bash -c "diff -du <(xxd xxd.c) <(./xxd xxd.c)"

xxd: test.c xxd.c
	$(CC) $(CFLAGS) $^ -o $@

# just use git clean tbh
.PHONY: clean
clean:
	rm -f *.o *.su xxd
