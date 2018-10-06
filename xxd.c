#include <ctype.h>
#include <inttypes.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

// print xxd yo
void xxd(char *inbuf, size_t inlen, size_t xxd_len) {
  for (size_t addr = 0; addr < inlen; addr += xxd_len) {
    char *buf = inbuf + addr;
    size_t len = (addr < inlen - xxd_len) ? (xxd_len) : (inlen - addr);

    char
        outbuf[sizeof("00000000:") + (sizeof("xxxx ") - 1) * xxd_len + xxd_len];
    memset(outbuf, 0, sizeof(outbuf));
    char asciibuf[xxd_len * 2 + 1];
    memset(asciibuf, 0, sizeof(asciibuf));

    // place address
    sprintf(outbuf, "%08" PRIx32 ":", (uint32_t)addr);

    // load hex format
    size_t i = 0;
    for (; i < xxd_len; i++) {
      if ((i & 1) == 0) {
        strcat(outbuf, " ");
      }
      if (i < len) {
        char val[3];
        sprintf(val, "%02x", buf[i]);
        strcat(outbuf, val);
        sprintf(&asciibuf[i], "%c", isprint(buf[i]) ? buf[i] : '.');
      } else {
        // space pad
        strcat(outbuf, "  ");
      }
    }

    printf("%s  %s\n", outbuf, asciibuf);
  }
}
