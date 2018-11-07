#include <ctype.h>
#include <inttypes.h>
#include <stdint.h>
#include <stdio.h>
#include <string.h>

// print xxd yo
void xxd(const void *buf, size_t len, size_t xxd_width) {
  for (size_t addr = 0; addr < len; addr += xxd_width) {
    uint8_t *linedata = (uint8_t*)buf + addr;
    size_t linelen = (addr + xxd_width < len) ? (xxd_width) : (len - addr);

    char
        outbuf[sizeof("00000000:") + (sizeof("xxxx ") - 1) * xxd_width + xxd_width];
    memset(outbuf, 0, sizeof(outbuf));
    char asciibuf[xxd_width * 2 + 1];
    memset(asciibuf, 0, sizeof(asciibuf));

    // place address
    sprintf(outbuf, "%08" PRIx32 ":", (uint32_t)addr);

    // load hex format
    size_t i = 0;
    for (; i < xxd_width; i++) {
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

    printf("%s  %s\n", outbuf, asciibuf);
  }
}
