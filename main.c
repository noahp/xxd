//
// Small main test app.
//
#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include "xxd.h"

int main(int argc, char **argv) {
  if (argc > 1) {
    size_t xxd_len = 16;
    if (argc > 2) {
      xxd_len = strtoul(argv[2], NULL, 0);
    }
    FILE *fp = fopen(argv[1], "rb");
    assert("whoops, can't open first arg for reading" && fp);

    char *buf = malloc(100000);
    assert("whoops, can't allocate" && buf);
    memset(buf, 0, 100000);

    size_t readcnt = fread(buf, 1, 100000, fp);

    xxd(buf, readcnt, xxd_len);

    free(buf);
  }
  return 0;
}
