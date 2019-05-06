
CFLAGS += -std=c99 -Wall -Wextra -Wpedantic -Werror -g

# right now ASAN is only supported on gcc
ifeq ($(DISABLE_LIBASAN),)
  CFLAGS += -fsanitize=address -fsanitize=undefined -fstack-usage -static-libasan
endif

ifeq ($(XXD_COVERAGE),1)
CFLAGS += --coverage

# Set LCOV if available
LCOV ?=
endif

# colored output ^_^ https://gist.github.com/chrisopedia/8754917
textviolet=$(shell echo "\033[1;95m")
textgreen=$(shell echo "\033[1;92m")
textend=$(shell echo "\033[0m")
define greentext
    @echo "$(textgreen)$(1)$(textend)"
endef
define violettext
    @echo "$(textviolet)$(1)$(textend)"
endef

.PHONY: all
all: xxd test

# run against a few test inputs
# using order-only to separate the test input files. since it's a .PHONY rule it
# always runs anyway
.PHONY: test
test: xxd | testinput/* xxd.c README.md
	$(call violettext,Running tests...)
	echo -n $| | xargs -t -d " " -I % bash -c "diff -du <(xxd %) <(./xxd %)"
	echo -n $| | xargs -t -d " " -I % bash -c "diff -du <(xxd -c 8 %) <(./xxd % 8)"
	echo -n $| | xargs -t -d " " -I % bash -c "diff -du <(xxd -c 0 %) <(./xxd % 0)"
	$(call greentext,All tests passed!)
ifeq ($(XXD_COVERAGE),1)
ifdef LCOV
	@echo "+++ Running fastcov..."
	@"./fastcov/fastcov.py" --gcov gcov-9 --exclude /usr/include --branch-coverage --lcov -o coverage.info
	@genhtml --branch-coverage coverage.info --output-directory coverage
	@echo "See file://$(abspath coverage)/index.html for lcov results"
endif
endif

xxd: main.c xxd.c
	$(call violettext,Building...)
	$(CC) $(CFLAGS) $^ -o $@
	$(call greentext,Success!)

# just use git clean tbh
.PHONY: clean
clean:
	$(call violettext,Cleaning...)
	rm -f *.o *.su xxd
	$(call greentext,Done)
