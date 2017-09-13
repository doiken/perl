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

MODULE = Sum    PACKAGE = Sum

PROTOTYPES: DISABLE

void
sum(...)
PPCODE:
{
    if (items != 2) {
        croak("Invalid argument count: %d", items);
    }
    SV *a = ST(0);
    SV *b = ST(1);

    IV ret = SvIV(a) + SvIV(b);

    XPUSHs(sv_2mortal(newSViv(ret)));
    XSRETURN(1);
}


