//
// xxd header
//
#include <stddef.h>

/// Print a buffer in an xxd-like form
/// inbuf[in] - buffer to print
/// inlen[in] - number of bytes of buffer to print
/// xxd_len[in] - number of bytes per line of output
void xxd(char *inbuf, size_t inlen, size_t xxd_len);
