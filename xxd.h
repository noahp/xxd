//
// xxd header
//
#include <stddef.h>

/// Print a buffer in an xxd-like form
/// buf[in] - buffer to print
/// len[in] - number of bytes of buffer to print
/// xxd_width[in] - number of bytes per line of output
void xxd(const void *buf, size_t len, size_t xxd_width);
