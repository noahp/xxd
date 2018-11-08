#include <ctype.h>
#include <inttypes.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

// print xxd yo
void xxd(const void *buf, size_t len, size_t xxd_width) {
  for (size_t addr = 0; addr < len; addr += xxd_width) {
    uint8_t *linedata = (uint8_t *)buf + addr;
    const size_t linelen =
        (addr + xxd_width < len) ? (xxd_width) : (len - addr);

    char outbuf[strlen("xxxx ") * xxd_width / 2 + xxd_width];
    outbuf[0] = '\0';
    char asciibuf[xxd_width * 2 + 1];

    // load hex format
    for (size_t i = 0; i < xxd_width; i++) {
      if ((i & 1) == 0) {
        strcat(outbuf, " ");
      }
      if (i < linelen) {
        char val[3];
        snprintf(val, sizeof(val), "%02" PRIx8, linedata[i]);
        strcat(outbuf, val);
        sprintf(&asciibuf[i], "%c", isprint(linedata[i]) ? linedata[i] : '.');
      } else {
        // space pad
        strcat(outbuf, "  ");
      }
    }

    // place address
    printf("%08" PRIx32
           ":"
           "%s  %s\n",
           (uint32_t)addr, outbuf, asciibuf);
  }
}
