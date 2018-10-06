
CFLAGS += -std=c99 -Wall -Wextra -Wpedantic -fsanitize=address -fsanitize=undefined -fstack-usage

.PHONY: all
all: xxd test

test: xxd
	bash -c "diff -du <(xxd xxd.c) <(./xxd xxd.c)"

xxd: main.c xxd.c
	$(CC) $(CFLAGS) $^ -o $@

# just use git clean tbh
clean:
	rm -f *.o *.su xxd
