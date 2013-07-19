## Process this file with automake to produce Makefile.in -*-Makefile-*-

##m4-files-begin
EXTRA_DIST = README Makefile.am.in \
a2_psutils.m4 \
atexit.m4 \
c-bs-a.m4 \
ccstdc.m4 \
cond.m4 \
depend.m4 \
depout.m4 \
error.m4 \
file.m4 \
fp_echo.m4 \
fullpath.m4 \
gccwarn.m4 \
gettext.m4 \
header.m4 \
init.m4 \
inttypes_h.m4 \
lcmessage.m4 \
lex.m4 \
libpaper.m4 \
libtool.m4 \
lispdir.m4 \
lpr.m4 \
malloc.m4 \
missing.m4 \
obstack.m4 \
perl.m4 \
progtest.m4 \
protos.m4 \
realloc.m4 \
rename.m4 \
sanity.m4 \
strcasecmp.m4 \
strftim.m4 \
termios.m4 \
tterm.m4 \
uintmax_t.m4 \
ulonglong.m4 \
winsz.m4 \
xstrtoumax.m4
##m4-files-end

Makefile.am: Makefile.am.in
	rm -f $@ $@t
	sed -n '1,/^##m4-files-begin/p' $< > $@t
	( (echo EXTRA_DIST = README Makefile.am.in | tr '\012' @); \
	  (echo *.m4|tr ' ' @) ) \
	  |sed 's/@$$/%/;s/@/ \\@/g' |tr @% '\012\012' \
	  >> $@t
	sed -n '/^##m4-files-end/,$$p' $< >> $@t
	chmod a-w $@t
	mv $@t $@
