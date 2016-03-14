
# Copyright (C) 2006 Junjiro Okajima
# Copyright (C) 2006 Tomas Matejicek, slax.org
#
# LICENSE follows the described one in lzma.txt.

# $Id: sqlzma.mk,v 1.20 2007/01/07 15:12:48 jro Exp $

Sqlzma=$(PKG_BUILD_DIR)

include makefile.gcc
ifdef KDir
include kmod.mk
endif

ifdef UseDebugFlags
DebugFlags = -O0 -g -UNDEBUG
endif
CFLAGS += -DNDEBUG ${DebugFlags}
Tgt = libunlzma.a libunlzma_r.a

all: ${Tgt}

%_r.c: %.c
	ln $< $@
# -pthread
%_r.o: CFLAGS += -D_REENTRANT -include pthread.h

uncomp.o uncomp_r.o: CFLAGS += -I${Sqlzma}
uncomp.o: uncomp.c

libunlzma.a: uncomp.o LzmaDecode.o
	${AR} cr $@ $^
libunlzma_r.a: uncomp_r.o LzmaDecode_r.o
	${AR} cr $@ $^

clean: clean_sqlzma
clean_sqlzma:
	$(RM) ${Tgt} uncomp.o uncomp_r.o LzmaDecode_r.o *~

# Local variables: ;
# compile-command: (concat "make Sqlzma=../../../../.. -f " (file-name-nondirectory (buffer-file-name)));
# End: ;