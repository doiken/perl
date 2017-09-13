#ifdef __cplusplus
extern "C" {
#endif

#define PERL_NO_GET_CONTEXT /* we want efficiency */
#include <EXTERN.h>
#include <perl.h>
#include <XSUB.h>

#ifdef __cplusplus
} /* extern "C" */
#endif

#define NEED_newSVpvn_flags
#include "ppport.h"

MODULE = Hello    PACKAGE = Hello

PROTOTYPES: DISABLE

void
hello()
CODE:
{
    PerlIO_printf(PerlIO_stdout(), "Hello, world!\n");
    XSRETURN(0);
}
