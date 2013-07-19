dnl                                                        -*- Autoconf -*-
dnl Testing delegations for a2ps: a recent version of psutils
dnl
dnl Usage: a2_PSUTILS(major, minor)
dnl
dnl If psutils version MAJOR, patch level MINOR is available
dnl     SUBST(PSUTILS) to <nothing>
dnl else
dnl     SUBST(PSUTILS) to `#'
dnl Akim.Demaille@inf.enst.fr

# serial 2

AC_DEFUN(a2_PSUTILS,
[ad_CHECK_PROG(psselect)
ad_CHECK_PROG(psnup)
if test "$COM_psselect" = "#"; then
  COM_PSUTILS="#"
else
  # There is one.  Check version > MAJOR.MINOR
  ac_prog_psselect_banner=`psselect -v 2>&1 | sed 1q`
  ac_prog_psselect_release=`set -- $ac_prog_psselect_banner && echo $[3]`
  ac_prog_psselect_patch=`set -- $ac_prog_psselect_banner && echo $[5]`
  test ${ac_prog_psselect_release}0 -lt $1[0] && COM_PSUTILS="#"
  test ${ac_prog_psselect_patch}0 -lt $2[0] && COM_PSUTILS="#"
fi
if test "$COM_PSUTILS" = "#"; then
  AC_MSG_WARN([===========================================================])
  AC_MSG_WARN([a2ps works much better with the psutils.  Available at])
  AC_MSG_WARN([  http://www.dcs.ed.ac.uk/home/ajcd/psutils/])
  AC_MSG_WARN([You *really* should install them *before* installing a2ps.])
  AC_MSG_WARN([===========================================================])
fi
AC_SUBST(COM_PSUTILS)])
## --------------------------------------------------------- ##
##  Check if atexit is available, and replace if necessary   ##
##                           demaille@inf.enst.fr            ##
## --------------------------------------------------------- ##
dnl
dnl acconfig.h should contains these two lines
dnl /* Define to rpl_exit if the replacement function should be used.  */
dnl #undef exit
dnl and atexit.c should be available

# serial 2

AC_DEFUN(ad_FUNC_ATEXIT,
  [AC_CHECK_FUNCS(atexit)
   if test $ac_cv_func_atexit = no; then
     AC_CHECK_FUNCS(on_exit)
     LIBOBJS="$LIBOBJS atexit.o"
     if test $ac_cv_func_on_exit = no; then
       AC_DEFINE_UNQUOTED(exit, rpl_exit,
			  [Define to rpl_exit if the replacement function should be used])
     fi
   fi])
#serial 1

dnl From Paul Eggert.

AC_DEFUN(AC_C_BACKSLASH_A,
[
  AC_CACHE_CHECK([whether backslash-a works in strings], ac_cv_c_backslash_a,
   [AC_TRY_COMPILE([],
     [
#if '\a' == 'a'
      syntax error;
#endif
      char buf['\a' == 'a' ? -1 : 1];
      buf[0] = '\a';
      return buf[0] != "\a"[0];
     ],
     ac_cv_c_backslash_a=yes,
     ac_cv_c_backslash_a=no)])
  if test $ac_cv_c_backslash_a = yes; then
    AC_DEFINE(HAVE_C_BACKSLASH_A, 1,
      [Define if backslash-a works in C strings.])
  fi
])

AC_DEFUN(jm_PREREQ_QUOTEARG,
[
  AC_CHECK_FUNCS(isascii mbrtowc)
  AC_CHECK_HEADERS(limits.h stdlib.h string.h wchar.h)
  AC_HEADER_STDC
  AC_C_BACKSLASH_A
  AM_C_PROTOTYPES
])
## ----------------------------------------- ##
## ANSIfy the C compiler whenever possible.  ##
## From Franc,ois Pinard                     ##
## ----------------------------------------- ##

# serial 1

# @defmac AC_PROG_CC_STDC
# @maindex PROG_CC_STDC
# @ovindex CC
# If the C compiler in not in ANSI C mode by default, try to add an option
# to output variable @code{CC} to make it so.  This macro tries various
# options that select ANSI C on some system or another.  It considers the
# compiler to be in ANSI C mode if it handles function prototypes correctly.
#
# If you use this macro, you should check after calling it whether the C
# compiler has been set to accept ANSI C; if not, the shell variable
# @code{am_cv_prog_cc_stdc} is set to @samp{no}.  If you wrote your source
# code in ANSI C, you can make an un-ANSIfied copy of it by using the
# program @code{ansi2knr}, which comes with Ghostscript.
# @end defmac

AC_DEFUN(AM_PROG_CC_STDC,
[AC_REQUIRE([AC_PROG_CC])
AC_BEFORE([$0], [AC_C_INLINE])
AC_BEFORE([$0], [AC_C_CONST])
dnl Force this before AC_PROG_CPP.  Some cpp's, eg on HPUX, require
dnl a magic option to avoid problems with ANSI preprocessor commands
dnl like #elif.
dnl FIXME: can't do this because then AC_AIX won't work due to a
dnl circular dependency.
dnl AC_BEFORE([$0], [AC_PROG_CPP])
AC_MSG_CHECKING(for ${CC-cc} option to accept ANSI C)
AC_CACHE_VAL(am_cv_prog_cc_stdc,
[am_cv_prog_cc_stdc=no
ac_save_CC="$CC"
# Don't try gcc -ansi; that turns off useful extensions and
# breaks some systems' header files.
# AIX			-qlanglvl=ansi
# Ultrix and OSF/1	-std1
# HP-UX 10.20 and later	-Ae
# HP-UX older versions	-Aa -D_HPUX_SOURCE
# SVR4			-Xc -D__EXTENSIONS__
for ac_arg in "" -qlanglvl=ansi -std1 -Ae "-Aa -D_HPUX_SOURCE" "-Xc -D__EXTENSIONS__"
do
  CC="$ac_save_CC $ac_arg"
  AC_TRY_COMPILE(
[#include <stdarg.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
/* Most of the following tests are stolen from RCS 5.7's src/conf.sh.  */
struct buf { int x; };
FILE * (*rcsopen) (struct buf *, struct stat *, int);
static char *e (p, i)
     char **p;
     int i;
{
  return p[i];
}
static char *f (char * (*g) (char **, int), char **p, ...)
{
  char *s;
  va_list v;
  va_start (v,p);
  s = g (p, va_arg (v,int));
  va_end (v);
  return s;
}
int test (int i, double x);
struct s1 {int (*f) (int a);};
struct s2 {int (*f) (double a);};
int pairnames (int, char **, FILE *(*)(struct buf *, struct stat *, int), int, int);
int argc;
char **argv;
], [
return f (e, argv, 0) != argv[0]  ||  f (e, argv, 1) != argv[1];
],
[am_cv_prog_cc_stdc="$ac_arg"; break])
done
CC="$ac_save_CC"
])
if test -z "$am_cv_prog_cc_stdc"; then
  AC_MSG_RESULT([none needed])
else
  AC_MSG_RESULT($am_cv_prog_cc_stdc)
fi
case "x$am_cv_prog_cc_stdc" in
  x|xno) ;;
  *) CC="$CC $am_cv_prog_cc_stdc" ;;
esac
])
# Define a conditional.

AC_DEFUN(AM_CONDITIONAL,
[AC_SUBST($1_TRUE)
AC_SUBST($1_FALSE)
if $2; then
  $1_TRUE=
  $1_FALSE='#'
else
  $1_TRUE='#'
  $1_FALSE=
fi])
dnl See how the compiler implements dependency checking.
dnl Usage:
dnl AM_DEPENDENCIES(NAME)
dnl NAME is "CC", "CXX" or "OBJC".

dnl We try a few techniques and use that to set a single cache variable.

AC_DEFUN(AM_DEPENDENCIES,[
AC_REQUIRE([AM_SET_DEPDIR])
AC_REQUIRE([AM_OUTPUT_DEPENDENCY_COMMANDS])
ifelse([$1],CC,[
AC_REQUIRE([AC_PROG_CC])
AC_REQUIRE([AC_PROG_CPP])
depcc="$CC"
depcpp="$CPP"],[$1],CXX,[
AC_REQUIRE([AC_PROG_CXX])
AC_REQUIRE([AC_PROG_CXXCPP])
depcc="$CXX"
depcpp="$CXXCPP"],[$1],OBJC,[
am_cv_OBJC_dependencies_compiler_type=gcc],[
AC_REQUIRE([AC_PROG_][$1])
depcc="$[$1]"
depcpp=""])
AC_MSG_CHECKING([dependency style of $depcc])
AC_CACHE_VAL(am_cv_[$1]_dependencies_compiler_type,[
if test -z "$AMDEP"; then
  echo '#include "conftest.h"' > conftest.c
  echo 'int i;' > conftest.h

  am_cv_[$1]_dependencies_compiler_type=none
  for depmode in `sed -n 's/^#*\([a-zA-Z0-9]*\))$/\1/p' < "$am_depcomp"`; do
    case "$depmode" in
    nosideeffect)
      # after this tag, mechanisms are not by side-effect, so they'll
      # only be used when explicitly requested
      if test "x$enable_dependency_tracking" = xyes; then
	continue
      else
	break
      fi
      ;;
    none) break ;;
    esac
    if depmode="$depmode" \
       source=conftest.c object=conftest.o \
       depfile=conftest.Po tmpdepfile=conftest.TPo \
       $SHELL $am_depcomp $depcc -c conftest.c 2>/dev/null &&
       grep conftest.h conftest.Po > /dev/null 2>&1; then
      am_cv_[$1]_dependencies_compiler_type="$depmode"
      break
    fi
  done

  rm -f conftest.*
else
  am_cv_[$1]_dependencies_compiler_type=none
fi
])
AC_MSG_RESULT($am_cv_[$1]_dependencies_compiler_type)
[$1]DEPMODE="depmode=$am_cv_[$1]_dependencies_compiler_type"
AC_SUBST([$1]DEPMODE)
])

dnl Choose a directory name for dependency files.
dnl This macro is AC_REQUIREd in AM_DEPENDENCIES

AC_DEFUN(AM_SET_DEPDIR,[
if test -d .deps || mkdir .deps 2> /dev/null || test -d .deps; then
  DEPDIR=.deps
else
  DEPDIR=_deps
fi
AC_SUBST(DEPDIR)
])

AC_DEFUN(AM_DEP_TRACK,[
AC_ARG_ENABLE(dependency-tracking,
[  --disable-dependency-tracking Speeds up one-time builds
  --enable-dependency-tracking  Do not reject slow dependency extractors])
if test "x$enable_dependency_tracking" = xno; then
  AMDEP="#"
else
  am_depcomp="$ac_aux_dir/depcomp"
  if test ! -f "$am_depcomp"; then
    AMDEP="#"
  else
    AMDEP=
  fi
fi
AC_SUBST(AMDEP)
if test -z "$AMDEP"; then
  AMDEPBACKSLASH='\'
else
  AMDEPBACKSLASH=
fi
pushdef([subst], defn([AC_SUBST]))
subst(AMDEPBACKSLASH)
popdef([subst])
])
dnl Generate code to set up dependency tracking.
dnl This macro should only be invoked once -- use via AC_REQUIRE.
dnl Usage:
dnl AM_OUTPUT_DEPENDENCY_COMMANDS

dnl
dnl This code is only required when automatic dependency tracking
dnl is enabled.  FIXME.  This creates each `.P' file that we will
dnl need in order to bootstrap the dependency handling code.
AC_DEFUN(AM_OUTPUT_DEPENDENCY_COMMANDS,[
AC_OUTPUT_COMMANDS([
test x"$AMDEP" != x"" ||
for mf in $CONFIG_FILES; do
  case "$mf" in
  Makefile) dirpart=.;;
  */Makefile) dirpart=`echo "$mf" | sed -e 's|/[^/]*$||'`;;
  *) continue;;
  esac
  grep '^DEP_FILES *= *[^ #]' < "$mf" > /dev/null || continue
  # Extract the definition of DEP_FILES from the Makefile without
  # running `make'.
  DEPDIR=`sed -n -e '/^DEPDIR = / s///p' < "$mf"`
  test -z "$DEPDIR" && continue
  # When using ansi2knr, U may be empty or an underscore; expand it
  U=`sed -n -e '/^U = / s///p' < "$mf"`
  test -d "$dirpart/$DEPDIR" || mkdir "$dirpart/$DEPDIR"
  # We invoke sed twice because it is the simplest approach to
  # changing $(DEPDIR) to its actual value in the expansion.
  for file in `sed -n -e '
    /^DEP_FILES = .*\\\\$/ {
      s/^DEP_FILES = //
      :loop
	s/\\\\$//
	p
	n
	/\\\\$/ b loop
      p
    }
    /^DEP_FILES = / s/^DEP_FILES = //p' < "$mf" | \
       sed -e 's/\$(DEPDIR)/'"$DEPDIR"'/g' -e 's/\$U/'"$U"'/g'`; do
    test -f "$dirpart/$file" && continue
    echo "creating $dirpart/$file"
    echo '# dummy' > "$dirpart/$file"
  done
done
], [AMDEP="$AMDEP"])])
dnl From Jim Meyering.  Use this if you use the GNU error.[ch].
dnl FIXME: Migrate into libit

AC_DEFUN(AM_FUNC_ERROR_AT_LINE,
[AC_CACHE_CHECK([for error_at_line], am_cv_lib_error_at_line,
 [AC_TRY_LINK([],[error_at_line(0, 0, "", 0, "");],
              am_cv_lib_error_at_line=yes,
	      am_cv_lib_error_at_line=no)])
 if test $am_cv_lib_error_at_line = no; then
   LIBOBJS="$LIBOBJS error.$ac_objext"
 fi
 AC_SUBST(LIBOBJS)dnl
])
## --------------------------------------------------------- ##
## Find where is `file' and what is the option for it to     ##
## follow the links. If no way, use a plain `file'           ##
##                           demaille@inf.enst.fr            ##
## --------------------------------------------------------- ##

# serial 4

dnl This is a test to know what is the correct way to get
dnl file following the links
dnl I hope it is robust, but I'm a novice :) Akim Demaille
AC_DEFUN(ad_PROG_FILE_LINK,
  [AC_PATH_PROG(file_prog, file)dnl
   AC_MSG_CHECKING(for the option for file to follow the links)
   AC_CACHE_VAL(ac_cv_prog_file_link_option,[
     touch conftestfile
     ln -s conftestfile conftestfile1
     for file_opt in '' ' -L'
     do
       res=`eval $file_prog $file_opt conftestfile1 2>&-` || res=symbolic
       case $res in
	  *symbolic*) ;;
	  *) ac_cv_prog_file_link_option=$file_opt ; break    ;;
       esac
     done
     rm conftestfile conftestfile1
     if test "X$ac_cv_prog_file_link_option" = X; then
        ac_cv_prog_file_link_option="no";
     fi])dnl
   # If no flag were found, default to `file' with no options
   case "X$ac_cv_prog_file_link_option" in
     X)   AC_MSG_RESULT(none required) ;
          FILE_LINK=${file_prog} ;;
     Xno) AC_MSG_RESULT(no way);
          FILE_LINK=${file_prog} ;;
     *)   AC_MSG_RESULT($ac_cv_prog_file_link_option);
          FILE_LINK=${file_prog}${ac_cv_prog_file_link_option} ;;
   esac])
# Once this macro is called, you may output with no echo in a Makefile or
# script using:  echo @ECHO_N@ "STRING_TO_OUTPUT@ECHO_C@".

AC_DEFUN(fp_PROG_ECHO,
[AC_MSG_CHECKING(how to suppress newlines using echo)
AC_CACHE_VAL(fp_cv_prog_echo_nonl,
[if (echo "testing\c"; echo 1,2,3) | grep c >/dev/null; then
  if (echo -n testing; echo 1,2,3) | sed s/-n/xn/ | grep xn >/dev/null; then
    fp_cv_prog_echo_nonl=no
  else
    fp_cv_prog_echo_nonl=option
  fi
else
  fp_cv_prog_echo_nonl=escape
fi
])
AC_MSG_RESULT($fp_cv_prog_echo_nonl)
test $fp_cv_prog_echo_nonl = no \
  && echo 2>&1 "WARNING: \`echo' not powerful enough for \`make check'"
case $fp_cv_prog_echo_nonl in
  no) ECHO_N= ECHO_C= ;;
  option) ECHO_N=-n ECHO_C= ;;
  escape) ECHO_N= ECHO_C='\c' ;;
esac
AC_SUBST(ECHO_N)dnl
AC_SUBST(ECHO_C)dnl
])
# -*- Autoconf -*-

# Check for the existence of a program, resolving it either to the
# full name or short name.

# This is ugly work, don't use it.

# serial 1

dnl
AC_DEFUN(ad_ENABLE_PATHS,
[AC_MSG_CHECKING(whether paths should be hardcoded)
AC_ARG_ENABLE(paths,
              [  --enable-paths          hard code the path of the tools])
test "$enable_paths" = "yes" || enable_paths=no
AC_MSG_RESULT($enable_paths)])

dnl ad_CHECK_PROG(PROGRAM[, COMMENT ON FAILURE])
dnl defines $COM_PROGRAM to `#' if PROGRAM is not available, to `' otherwise
dnl and defines $PROGRAM to PROGRAM if paths should not be hardcoded,
dnl and to the path to PROGRAM otherwise.
AC_DEFUN(ad_CHECK_PROG,
[if test "$enable_paths" = "no"; then
  AC_CHECK_PROG(COM_$1, $1, yes, no)
  $1="$1";
  if test "[$]COM_$1" = "yes"; then
    COM_$1="";
  else
    COM_$1="#";
  fi
else
  AC_PATH_PROG($1, $1, [#])
  if test "$1" = "#"; then #  not found
    $1="$1" # let the name of the program as path
    COM_$1="#"
  else
    COM_$1=""
  fi
fi
ifval([$2],
[if test "[$]COM_$1" = "#"; then
  AC_MSG_WARN([============================================================
$2])
  AC_MSG_WARN([============================================================])
fi])
AC_SUBST($1)
AC_SUBST(COM_$1)])

dnl ad_CHECK_PROG(PROGRAM[, COMMENT ON FAILURE])
dnl defines $COM_PROGRAM to `#' if PROGRAM is not available, to `' otherwise
dnl and defines $PROGRAM to PROGRAM if paths should not be hardcoded,
dnl and to the path to PROGRAM otherwise.
AC_DEFUN([ad_CHECK_PROGS],
[m4_foreach([AC_PROG], [$1], [ad_CHECK_PROG(AC_PROG, $2)])])
dnl Check if the compiler supports useful warning options.  There's a few that
dnl we don't use, simply because they're too noisy:
dnl
dnl     -Wconversion (useful in older versions of gcc, but not in gcc 2.7.x)
dnl     -Wredundant-decls (system headers make this too noisy)
dnl     -Wtraditional (combines too many unrelated messages, only a few useful)
dnl     -Wcast-qual because with char * cp; const char * ccp;
dnl                 cp = (char *) ccp;
dnl                 is the only portable way to do cp = ccp;
dnl     -pedantic
dnl

#serial 3
AC_DEFUN([ad_GCC_WARNINGS],
[AC_ARG_ENABLE(warnings,
     	       [  --enable-warnings       enable compiler warnings])
 if test "$enable_warnings" = "yes"; then
   CF_GCC_WARNINGS
 fi])

AC_DEFUN([CF_GCC_WARNINGS],
[if test -n "$GCC"; then
  AC_CACHE_CHECK([for gcc warning options], ac_cv_prog_gcc_warn_flags,
  [changequote(,)dnl
  cat > conftest.$ac_ext <<EOF
#line __oline__ "configure"
int main(int argc, char *argv[]) { return argv[argc-1] == 0; }
EOF
  changequote([,])dnl
  cf_save_CFLAGS="$CFLAGS"
  ac_cv_prog_gcc_warn_flags="-W -Wall"
  for cf_opt in \
   Wbad-function-cast \
   Wcast-align \
   Wmissing-declarations \
   Wmissing-prototypes \
   Wnested-externs \
   Wpointer-arith \
   Wshadow \
   Wstrict-prototypes \
   Wwrite-strings
  do
    CFLAGS="$cf_save_CFLAGS $ac_cv_prog_gcc_warn_flags -$cf_opt"
    if AC_TRY_EVAL(ac_compile); then
      test -n "$verbose" && AC_MSG_RESULT(... -$cf_opt)
	ac_cv_prog_gcc_warn_flags="$ac_cv_prog_gcc_warn_flags -$cf_opt"
	test "$cf_opt" = Wcast-qual && ac_cv_prog_gcc_warn_flags="$ac_cv_prog_gcc_warn_flags -DXTSTRINGDEFINES"
    fi
  done
  rm -f conftest*
  CFLAGS="$cf_save_CFLAGS"])
fi
EXTRA_CFLAGS="${ac_cv_prog_gcc_warn_flags}"
AC_SUBST(EXTRA_CFLAGS)
])dnl
# Macro to add for using GNU gettext.
# Ulrich Drepper <drepper@cygnus.com>, 1995.
#
# This file can be copied and used freely without restrictions.  It can
# be used in projects which are not available under the GNU Public License
# but which still want to provide support for the GNU gettext functionality.
# Please note that the actual code is *not* freely available.

# serial 108

AC_PREREQ(2.13)               dnl Minimum Autoconf version required.

AC_DEFUN(AM_WITH_NLS,
  [AC_MSG_CHECKING([whether NLS is requested])
    dnl Default is enabled NLS
    AC_ARG_ENABLE(nls,
      [  --disable-nls           do not use Native Language Support],
      USE_NLS=$enableval, USE_NLS=yes)
    AC_MSG_RESULT($USE_NLS)
    AC_SUBST(USE_NLS)

    USE_INCLUDED_LIBINTL=no

    dnl If we use NLS figure out what method
    if test "$USE_NLS" = "yes"; then
      AC_DEFINE(ENABLE_NLS, 1, [Define to 1 if NLS is requested.])
      AC_MSG_CHECKING([whether included gettext is requested])
      AC_ARG_WITH(included-gettext,
        [  --with-included-gettext use the GNU gettext library included here],
        nls_cv_force_use_gnu_gettext=$withval,
        nls_cv_force_use_gnu_gettext=no)
      AC_MSG_RESULT($nls_cv_force_use_gnu_gettext)

      nls_cv_use_gnu_gettext="$nls_cv_force_use_gnu_gettext"
      if test "$nls_cv_force_use_gnu_gettext" != "yes"; then
        dnl User does not insist on using GNU NLS library.  Figure out what
        dnl to use.  If gettext or catgets are available (in this order) we
        dnl use this.  Else we have to fall back to GNU NLS library.
	dnl catgets is only used if permitted by option --with-catgets.
	nls_cv_header_intl=
	nls_cv_header_libgt=
	CATOBJEXT=NONE

	AC_CHECK_HEADER(libintl.h,
	  [AC_CACHE_CHECK([for gettext in libc], gt_cv_func_gettext_libc,
	    [AC_TRY_LINK([#include <libintl.h>], [return (int) gettext ("")],
	       gt_cv_func_gettext_libc=yes, gt_cv_func_gettext_libc=no)])

	   if test "$gt_cv_func_gettext_libc" != "yes"; then
	     AC_CHECK_LIB(intl, bindtextdomain,
	       [AC_CHECK_LIB(intl, gettext)])
	   fi

	   if test "$gt_cv_func_gettext_libc" = "yes" \
	      || test "$ac_cv_lib_intl_gettext" = "yes"; then
	      AC_DEFINE(HAVE_GETTEXT, 1,
	  [Define to 1 if you have gettext and don't want to use GNU gettext.])
	      AM_PATH_PROG_WITH_TEST(MSGFMT, msgfmt,
		[test -z "`$ac_dir/$ac_word -h 2>&1 | grep 'dv '`"], no)dnl
	      if test "$MSGFMT" != "no"; then
		AC_CHECK_FUNCS(dcgettext)
		AC_PATH_PROG(GMSGFMT, gmsgfmt, $MSGFMT)
		AM_PATH_PROG_WITH_TEST(XGETTEXT, xgettext,
		  [test -z "`$ac_dir/$ac_word -h 2>&1 | grep '(HELP)'`"], :)
		AC_TRY_LINK(, [extern int _nl_msg_cat_cntr;
			       return _nl_msg_cat_cntr],
		  [CATOBJEXT=.gmo
		   DATADIRNAME=share],
		  [CATOBJEXT=.mo
		   DATADIRNAME=lib])
		INSTOBJEXT=.mo
	      fi
	    fi
	])

        if test "$CATOBJEXT" = "NONE"; then
	  AC_MSG_CHECKING([whether catgets can be used])
	  AC_ARG_WITH(catgets,
	    [  --with-catgets          use catgets functions if available],
	    nls_cv_use_catgets=$withval, nls_cv_use_catgets=no)
	  AC_MSG_RESULT($nls_cv_use_catgets)

	  if test "$nls_cv_use_catgets" = "yes"; then
	    dnl No gettext in C library.  Try catgets next.
	    AC_CHECK_LIB(i, main)
	    AC_CHECK_FUNC(catgets,
	      [AC_DEFINE(HAVE_CATGETS, 1,
			 [Define as 1 if you have catgets and don't want to use GNU gettext.])
	       INTLOBJS="\$(CATOBJS)"
	       AC_PATH_PROG(GENCAT, gencat, no)dnl
	       if test "$GENCAT" != "no"; then
		 AC_PATH_PROG(GMSGFMT, gmsgfmt, no)
		 if test "$GMSGFMT" = "no"; then
		   AM_PATH_PROG_WITH_TEST(GMSGFMT, msgfmt,
		    [test -z "`$ac_dir/$ac_word -h 2>&1 | grep 'dv '`"], no)
		 fi
		 AM_PATH_PROG_WITH_TEST(XGETTEXT, xgettext,
		   [test -z "`$ac_dir/$ac_word -h 2>&1 | grep '(HELP)'`"], :)
		 USE_INCLUDED_LIBINTL=yes
		 CATOBJEXT=.cat
		 INSTOBJEXT=.cat
		 DATADIRNAME=lib
		 INTLDEPS='$(top_builddir)/intl/libintl.a'
		 INTLLIBS=$INTLDEPS
		 LIBS=`echo $LIBS | sed -e 's/-lintl//'`
		 nls_cv_header_intl=intl/libintl.h
		 nls_cv_header_libgt=intl/libgettext.h
	       fi])
	  fi
        fi

        if test "$CATOBJEXT" = "NONE"; then
	  dnl Neither gettext nor catgets in included in the C library.
	  dnl Fall back on GNU gettext library.
	  nls_cv_use_gnu_gettext=yes
        fi
      fi

      if test "$nls_cv_use_gnu_gettext" = "yes"; then
        dnl Mark actions used to generate GNU NLS library.
        INTLOBJS="\$(GETTOBJS)"
        AM_PATH_PROG_WITH_TEST(MSGFMT, msgfmt,
	  [test -z "`$ac_dir/$ac_word -h 2>&1 | grep 'dv '`"], msgfmt)
        AC_PATH_PROG(GMSGFMT, gmsgfmt, $MSGFMT)
        AM_PATH_PROG_WITH_TEST(XGETTEXT, xgettext,
	  [test -z "`$ac_dir/$ac_word -h 2>&1 | grep '(HELP)'`"], :)
        AC_SUBST(MSGFMT)
	USE_INCLUDED_LIBINTL=yes
        CATOBJEXT=.gmo
        INSTOBJEXT=.mo
        DATADIRNAME=share
	INTLDEPS='$(top_builddir)/intl/libintl.a'
	INTLLIBS=$INTLDEPS
	LIBS=`echo $LIBS | sed -e 's/-lintl//'`
        nls_cv_header_intl=intl/libintl.h
        nls_cv_header_libgt=intl/libgettext.h
      fi

      dnl Test whether we really found GNU xgettext.
      if test "$XGETTEXT" != ":"; then
	dnl If it is no GNU xgettext we define it as : so that the
	dnl Makefiles still can work.
	if $XGETTEXT --omit-header /dev/null 2> /dev/null; then
	  : ;
	else
	  AC_MSG_RESULT(
	    [found xgettext program is not GNU xgettext; ignore it])
	  XGETTEXT=":"
	fi
      fi

      # We need to process the po/ directory.
      POSUB=po
    else
      DATADIRNAME=share
      nls_cv_header_intl=intl/libintl.h
      nls_cv_header_libgt=intl/libgettext.h
    fi
    if test -z "$nls_cv_header_intl"; then
      # Clean out junk possibly left behind by a previous configuration.
      rm -f intl/libintl.h
    fi
    AC_CONFIG_LINKS($nls_cv_header_intl:$nls_cv_header_libgt)
    AC_OUTPUT_COMMANDS(
     [case "$CONFIG_FILES" in *po/Makefile.in*)
        sed -e "/POTFILES =/r po/POTFILES" po/Makefile.in > po/Makefile
      esac])


    # If this is used in GNU gettext we have to set USE_NLS to `yes'
    # because some of the sources are only built for this goal.
    if test "$PACKAGE" = gettext; then
      USE_NLS=yes
      USE_INCLUDED_LIBINTL=yes
    fi

    dnl These rules are solely for the distribution goal.  While doing this
    dnl we only have to keep exactly one list of the available catalogs
    dnl in configure.in.
    for lang in $ALL_LINGUAS; do
      GMOFILES="$GMOFILES $lang.gmo"
      POFILES="$POFILES $lang.po"
    done

    dnl Make all variables we use known to autoconf.
    AC_SUBST(USE_INCLUDED_LIBINTL)
    AC_SUBST(CATALOGS)
    AC_SUBST(CATOBJEXT)
    AC_SUBST(DATADIRNAME)
    AC_SUBST(GMOFILES)
    AC_SUBST(INSTOBJEXT)
    AC_SUBST(INTLDEPS)
    AC_SUBST(INTLLIBS)
    AC_SUBST(INTLOBJS)
    AC_SUBST(POFILES)
    AC_SUBST(POSUB)
  ])

AC_DEFUN(AM_GNU_GETTEXT,
  [AC_REQUIRE([AC_PROG_MAKE_SET])dnl
   AC_REQUIRE([AC_PROG_CC])dnl
   AC_REQUIRE([AC_PROG_RANLIB])dnl
   AC_REQUIRE([AC_ISC_POSIX])dnl
   AC_REQUIRE([AC_HEADER_STDC])dnl
   AC_REQUIRE([AC_C_CONST])dnl
   AC_REQUIRE([AC_C_INLINE])dnl
   AC_REQUIRE([AC_TYPE_OFF_T])dnl
   AC_REQUIRE([AC_TYPE_SIZE_T])dnl
   AC_REQUIRE([AC_FUNC_ALLOCA])dnl
   AC_REQUIRE([AC_FUNC_MMAP])dnl

   AC_CHECK_HEADERS([argz.h limits.h locale.h nl_types.h malloc.h string.h \
unistd.h sys/param.h])
   AC_CHECK_FUNCS([getcwd munmap putenv setenv setlocale strchr strcasecmp \
strdup __argz_count __argz_stringify __argz_next])

   if test "${ac_cv_func_stpcpy+set}" != "set"; then
     AC_CHECK_FUNCS(stpcpy)
   fi
   if test "${ac_cv_func_stpcpy}" = "yes"; then
     AC_DEFINE(HAVE_STPCPY, 1, [Define to 1 if you have the stpcpy function.])
   fi

   AM_LC_MESSAGES
   AM_WITH_NLS

   if test "x$CATOBJEXT" != "x"; then
     if test "x$ALL_LINGUAS" = "x"; then
       LINGUAS=
     else
       AC_MSG_CHECKING(for catalogs to be installed)
       NEW_LINGUAS=
       for lang in ${LINGUAS=$ALL_LINGUAS}; do
         case "$ALL_LINGUAS" in
          *$lang*) NEW_LINGUAS="$NEW_LINGUAS $lang" ;;
         esac
       done
       LINGUAS=$NEW_LINGUAS
       AC_MSG_RESULT($LINGUAS)
     fi

     dnl Construct list of names of catalog files to be constructed.
     if test -n "$LINGUAS"; then
       for lang in $LINGUAS; do CATALOGS="$CATALOGS $lang$CATOBJEXT"; done
     fi
   fi

   dnl The reference to <locale.h> in the installed <libintl.h> file
   dnl must be resolved because we cannot expect the users of this
   dnl to define HAVE_LOCALE_H.
   if test $ac_cv_header_locale_h = yes; then
     INCLUDE_LOCALE_H="#include <locale.h>"
   else
     INCLUDE_LOCALE_H="\
/* The system does not provide the header <locale.h>.  Take care yourself.  */"
   fi
   AC_SUBST(INCLUDE_LOCALE_H)

   dnl Determine which catalog format we have (if any is needed)
   dnl For now we know about two different formats:
   dnl   Linux libc-5 and the normal X/Open format
   test -d intl || mkdir intl
   if test "$CATOBJEXT" = ".cat"; then
     AC_CHECK_HEADER(linux/version.h, msgformat=linux, msgformat=xopen)

     dnl Transform the SED scripts while copying because some dumb SEDs
     dnl cannot handle comments.
     sed -e '/^#/d' $srcdir/intl/$msgformat-msg.sed > intl/po2msg.sed
   fi
   dnl po2tbl.sed is always needed.
   sed -e '/^#.*[^\\]$/d' -e '/^#$/d' \
     $srcdir/intl/po2tbl.sed.in > intl/po2tbl.sed

   dnl In the intl/Makefile.in we have a special dependency which makes
   dnl only sense for gettext.  We comment this out for non-gettext
   dnl packages.
   if test "$PACKAGE" = "gettext"; then
     GT_NO="#NO#"
     GT_YES=
   else
     GT_NO=
     GT_YES="#YES#"
   fi
   AC_SUBST(GT_NO)
   AC_SUBST(GT_YES)

   dnl If the AC_CONFIG_AUX_DIR macro for autoconf is used we possibly
   dnl find the mkinstalldirs script in another subdir but ($top_srcdir).
   dnl Try to locate is.
   MKINSTALLDIRS=
   if test -n "$ac_aux_dir"; then
     MKINSTALLDIRS="\$(top_srcdir)/$ac_aux_dir/mkinstalldirs"
   fi
   if test -z "$MKINSTALLDIRS"; then
     MKINSTALLDIRS="\$(top_srcdir)/mkinstalldirs"
   fi
   AC_SUBST(MKINSTALLDIRS)

   dnl *** For now the libtool support in intl/Makefile is not for real.
   l=
   AC_SUBST(l)

   dnl Generate list of files to be processed by xgettext which will
   dnl be included in po/Makefile.
   test -d po || mkdir po
   case "$srcdir" in
   .)
     posrcprefix="../" ;;
   /* | [[A-Za-z]]:*)
     posrcprefix="$srcdir/" ;;
   *)
     posrcprefix="../$srcdir/" ;;
   esac
   rm -f po/POTFILES
   sed -e "/^#/d" -e "/^\$/d" -e "s,.*,	$posrcprefix& \\\\," -e "\$s/\(.*\) \\\\/\1/" \
	< $srcdir/po/POTFILES.in > po/POTFILES
  ])
# Like AC_CONFIG_HEADER, but automatically create stamp file.

AC_DEFUN(AM_CONFIG_HEADER,
[AC_PREREQ([2.12])
AC_CONFIG_HEADER([$1])
dnl When config.status generates a header, we must update the stamp-h file.
dnl This file resides in the same directory as the config header
dnl that is generated.  We must strip everything past the first ":",
dnl and everything past the last "/".
AC_OUTPUT_COMMANDS(changequote(<<,>>)dnl
ifelse(patsubst(<<$1>>, <<[^ ]>>, <<>>), <<>>,
<<test -z "<<$>>CONFIG_HEADERS" || echo timestamp > patsubst(<<$1>>, <<^\([^:]*/\)?.*>>, <<\1>>)stamp-h<<>>dnl>>,
<<am_indx=1
for am_file in <<$1>>; do
  case " <<$>>CONFIG_HEADERS " in
  *" <<$>>am_file "*<<)>>
    echo timestamp > `echo <<$>>am_file | sed -e 's%:.*%%' -e 's%[^/]*$%%'`stamp-h$am_indx
    ;;
  esac
  am_indx=`expr "<<$>>am_indx" + 1`
done<<>>dnl>>)
changequote([,]))])
# Do all the work for Automake.  This macro actually does too much --
# some checks are only needed if your package does certain things.
# But this isn't really a big deal.

# serial 1

dnl Usage:
dnl AM_INIT_AUTOMAKE(package,version, [no-define])

AC_DEFUN(AM_INIT_AUTOMAKE,
[AC_REQUIRE([AC_PROG_INSTALL])
dnl We require 2.13 because we rely on SHELL being computed by configure.
AC_PREREQ([2.13])
PACKAGE=[$1]
AC_SUBST(PACKAGE)
VERSION=[$2]
AC_SUBST(VERSION)
dnl test to see if srcdir already configured
if test "`CDPATH=: && cd $srcdir && pwd`" != "`pwd`" &&
   test -f $srcdir/config.status; then
  AC_MSG_ERROR([source directory already configured; run "make distclean" there first])
fi
ifelse([$3],,
AC_DEFINE_UNQUOTED(PACKAGE, "$PACKAGE", [Name of package])
AC_DEFINE_UNQUOTED(VERSION, "$VERSION", [Version number of package]))
AC_REQUIRE([AM_SANITY_CHECK])
AC_REQUIRE([AC_ARG_PROGRAM])
AM_MISSING_PROG(ACLOCAL, aclocal)
AM_MISSING_PROG(AUTOCONF, autoconf)
AM_MISSING_PROG(AUTOMAKE, automake)
AM_MISSING_PROG(AUTOHEADER, autoheader)
AM_MISSING_PROG(MAKEINFO, makeinfo)
AM_MISSING_PROG(AMTAR, tar)
AM_MISSING_INSTALL_SH(install_sh)
dnl We need awk for the "check" target.  The system "awk" is bad on
dnl some platforms.
AC_REQUIRE([AC_PROG_AWK])
AC_REQUIRE([AC_PROG_MAKE_SET])
AC_REQUIRE([AM_DEP_TRACK])
AC_REQUIRE([AM_SET_DEPDIR])
ifdef([AC_PROVIDE_AC_PROG_CC], [AM_DEPENDENCIES(CC)], [
   define([AC_PROG_CC], defn([AC_PROG_CC])[AM_DEPENDENCIES(CC)])])
ifdef([AC_PROVIDE_AC_PROG_CXX], [AM_DEPENDENCIES(CXX)], [
   define([AC_PROG_CXX], defn([AC_PROG_CXX])[AM_DEPENDENCIES(CXX)])])
])
#serial 3

dnl From Paul Eggert.

# Define HAVE_INTTYPES_H if <inttypes.h> exists,
# doesn't clash with <sys/types.h>, and declares uintmax_t.

AC_DEFUN(jm_AC_HEADER_INTTYPES_H,
[
  AC_CACHE_CHECK([for inttypes.h], jm_ac_cv_header_inttypes_h,
  [AC_TRY_COMPILE(
    [#include <sys/types.h>
#include <inttypes.h>],
    [uintmax_t i = (uintmax_t) -1;],
    jm_ac_cv_header_inttypes_h=yes,
    jm_ac_cv_header_inttypes_h=no)])
  if test $jm_ac_cv_header_inttypes_h = yes; then
    AC_DEFINE_UNQUOTED(HAVE_INTTYPES_H, 1,
[Define if <inttypes.h> exists, doesn't clash with <sys/types.h>,
   and declares uintmax_t. ])
  fi
])
# Check whether LC_MESSAGES is available in <locale.h>.
# Ulrich Drepper <drepper@cygnus.com>, 1995.
#
# This file can be copied and used freely without restrictions.  It can
# be used in projects which are not available under the GNU Public License
# but which still want to provide support for the GNU gettext functionality.
# Please note that the actual code is *not* freely available.

# serial 2

AC_PREREQ(2.13)               dnl Minimum Autoconf version required.

AC_DEFUN(AM_LC_MESSAGES,
  [if test $ac_cv_header_locale_h = yes; then
    AC_CACHE_CHECK([for LC_MESSAGES], am_cv_val_LC_MESSAGES,
      [AC_TRY_LINK([#include <locale.h>], [return LC_MESSAGES],
       am_cv_val_LC_MESSAGES=yes, am_cv_val_LC_MESSAGES=no)])
    if test $am_cv_val_LC_MESSAGES = yes; then
      AC_DEFINE(HAVE_LC_MESSAGES, 1,
		[Define if your locale.h file contains LC_MESSAGES.])
    fi
  fi])
## Replacement for AC_PROG_LEX and AC_DECL_YYTEXT
## by Alexandre Oliva <oliva@dcc.unicamp.br>

dnl AM_PROG_LEX
dnl Look for flex, lex or missing, then run AC_PROG_LEX and AC_DECL_YYTEXT
AC_DEFUN(AM_PROG_LEX,
[AC_REQUIRE([AM_MISSING_HAS_RUN])
AC_CHECK_PROGS(LEX, flex lex, [${am_missing_run}flex])
AC_PROG_LEX
AC_DECL_YYTEXT])
dnl ## --------------------------------------------------------- ##
dnl ##  Check if libpaper is available                           ##
dnl ##                           demaille@inf.enst.fr            ##
dnl ## --------------------------------------------------------- ##
dnl
dnl

# serial 1

AC_DEFUN(ad_FUNC_SYSTEMPAPERNAME,
[
  AC_CHECK_LIB(paper, systempapername, 
    dnl Action if found
    [
      AC_DEFINE(HAVE_SYSTEMPAPERNAME, 1,
                [Define if you have the systempapername function])
      LIBS="$LIBS -lpaper"
      AC_CHECK_HEADERS(paper.h)
    ])
])
## libtool.m4 - Configure libtool for the target system. -*-Shell-script-*-
## Copyright (C) 1996-1999 Free Software Foundation, Inc.
## Originally by Gordon Matzigkeit <gord@gnu.ai.mit.edu>, 1996
##
## This program is free software; you can redistribute it and/or modify
## it under the terms of the GNU General Public License as published by
## the Free Software Foundation; either version 2 of the License, or
## (at your option) any later version.
##
## This program is distributed in the hope that it will be useful, but
## WITHOUT ANY WARRANTY; without even the implied warranty of
## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
## General Public License for more details.
##
## You should have received a copy of the GNU General Public License
## along with this program; if not, write to the Free Software
## Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
##
## As a special exception to the GNU General Public License, if you
## distribute this file as part of a program that contains a
## configuration script generated by Autoconf, you may include it under
## the same distribution terms that you use for the rest of that program.

# serial 40 AC_PROG_LIBTOOL
AC_DEFUN(AC_PROG_LIBTOOL,
[AC_REQUIRE([AC_LIBTOOL_SETUP])dnl

# Save cache, so that ltconfig can load it
AC_CACHE_SAVE

# Actually configure libtool.  ac_aux_dir is where install-sh is found.
CC="$CC" CFLAGS="$CFLAGS" CPPFLAGS="$CPPFLAGS" \
LD="$LD" LDFLAGS="$LDFLAGS" LIBS="$LIBS" \
LN_S="$LN_S" NM="$NM" RANLIB="$RANLIB" \
DLLTOOL="$DLLTOOL" AS="$AS" OBJDUMP="$OBJDUMP" \
${CONFIG_SHELL-/bin/sh} $ac_aux_dir/ltconfig --no-reexec \
$libtool_flags --no-verify $ac_aux_dir/ltmain.sh $lt_target \
|| AC_MSG_ERROR([libtool configure failed])

# Reload cache, that may have been modified by ltconfig
AC_CACHE_LOAD

# This can be used to rebuild libtool when needed
LIBTOOL_DEPS="$ac_aux_dir/ltconfig $ac_aux_dir/ltmain.sh"

# Always use our own libtool.
LIBTOOL='$(SHELL) $(top_builddir)/libtool'
AC_SUBST(LIBTOOL)dnl

# Redirect the config.log output again, so that the ltconfig log is not
# clobbered by the next message.
exec 5>>./config.log
])

AC_DEFUN(AC_LIBTOOL_SETUP,
[AC_PREREQ(2.13)dnl
AC_REQUIRE([AC_ENABLE_SHARED])dnl
AC_REQUIRE([AC_ENABLE_STATIC])dnl
AC_REQUIRE([AC_ENABLE_FAST_INSTALL])dnl
AC_REQUIRE([AC_CANONICAL_HOST])dnl
AC_REQUIRE([_AC_CANONICAL_BUILD])dnl
AC_REQUIRE([AC_PROG_RANLIB])dnl
AC_REQUIRE([AC_PROG_CC])dnl
AC_REQUIRE([AC_PROG_LD])dnl
AC_REQUIRE([AC_PROG_NM])dnl
AC_REQUIRE([AC_PROG_LN_S])dnl
dnl

case "$target" in
NONE) lt_target="$host" ;;
*) lt_target="$target" ;;
esac

# Check for any special flags to pass to ltconfig.
libtool_flags="--cache-file=$cache_file"
test "$enable_shared" = no && libtool_flags="$libtool_flags --disable-shared"
test "$enable_static" = no && libtool_flags="$libtool_flags --disable-static"
test "$enable_fast_install" = no && libtool_flags="$libtool_flags --disable-fast-install"
test "$ac_cv_prog_gcc" = yes && libtool_flags="$libtool_flags --with-gcc"
test "$ac_cv_prog_gnu_ld" = yes && libtool_flags="$libtool_flags --with-gnu-ld"
ifdef([AC_PROVIDE_AC_LIBTOOL_DLOPEN],
[libtool_flags="$libtool_flags --enable-dlopen"])
ifdef([AC_PROVIDE_AC_LIBTOOL_WIN32_DLL],
[libtool_flags="$libtool_flags --enable-win32-dll"])
AC_ARG_ENABLE(libtool-lock,
  [  --disable-libtool-lock  avoid locking (might break parallel builds)])
test "x$enable_libtool_lock" = xno && libtool_flags="$libtool_flags --disable-lock"
test x"$silent" = xyes && libtool_flags="$libtool_flags --silent"

# Some flags need to be propagated to the compiler or linker for good
# libtool support.
case "$lt_target" in
*-*-irix6*)
  # Find out which ABI we are using.
  echo '[#]line __oline__ "configure"' > conftest.$ac_ext
  if AC_TRY_EVAL(ac_compile); then
    case "`/usr/bin/file conftest.o`" in
    *32-bit*)
      LD="${LD-ld} -32"
      ;;
    *N32*)
      LD="${LD-ld} -n32"
      ;;
    *64-bit*)
      LD="${LD-ld} -64"
      ;;
    esac
  fi
  rm -rf conftest*
  ;;

*-*-sco3.2v5*)
  # On SCO OpenServer 5, we need -belf to get full-featured binaries.
  SAVE_CFLAGS="$CFLAGS"
  CFLAGS="$CFLAGS -belf"
  AC_CACHE_CHECK([whether the C compiler needs -belf], lt_cv_cc_needs_belf,
    [AC_TRY_LINK([],[],[lt_cv_cc_needs_belf=yes],[lt_cv_cc_needs_belf=no])])
  if test x"$lt_cv_cc_needs_belf" != x"yes"; then
    # this is probably gcc 2.8.0, egcs 1.0 or newer; no need for -belf
    CFLAGS="$SAVE_CFLAGS"
  fi
  ;;

ifdef([AC_PROVIDE_AC_LIBTOOL_WIN32_DLL],
[*-*-cygwin* | *-*-mingw*)
  AC_CHECK_TOOL(DLLTOOL, dlltool, false)
  AC_CHECK_TOOL(AS, as, false)
  AC_CHECK_TOOL(OBJDUMP, objdump, false)
  ;;
])
esac
])

# AC_LIBTOOL_DLOPEN - enable checks for dlopen support
AC_DEFUN(AC_LIBTOOL_DLOPEN, [AC_BEFORE([$0],[AC_LIBTOOL_SETUP])])

# AC_LIBTOOL_WIN32_DLL - declare package support for building win32 dll's
AC_DEFUN(AC_LIBTOOL_WIN32_DLL, [AC_BEFORE([$0], [AC_LIBTOOL_SETUP])])

# AC_ENABLE_SHARED - implement the --enable-shared flag
# Usage: AC_ENABLE_SHARED[(DEFAULT)]
#   Where DEFAULT is either `yes' or `no'.  If omitted, it defaults to
#   `yes'.
AC_DEFUN(AC_ENABLE_SHARED, [dnl
define([AC_ENABLE_SHARED_DEFAULT], ifelse($1, no, no, yes))dnl
AC_ARG_ENABLE(shared,
changequote(<<, >>)dnl
<<  --enable-shared[=PKGS]  build shared libraries [default=>>changequote([,])AC_ENABLE_SHARED_DEFAULT[]changequote(<<, >>)],
changequote([, ])dnl
[p=${PACKAGE-default}
case "$enableval" in
yes) enable_shared=yes ;;
no) enable_shared=no ;;
*)
  enable_shared=no
  # Look at the argument we got.  We use all the common list separators.
  IFS="${IFS= 	}"; ac_save_ifs="$IFS"; IFS="${IFS}:,"
  for pkg in $enableval; do
    if test "X$pkg" = "X$p"; then
      enable_shared=yes
    fi
  done
  IFS="$ac_save_ifs"
  ;;
esac],
enable_shared=AC_ENABLE_SHARED_DEFAULT)dnl
])

# AC_DISABLE_SHARED - set the default shared flag to --disable-shared
AC_DEFUN(AC_DISABLE_SHARED, [AC_BEFORE([$0],[AC_LIBTOOL_SETUP])dnl
AC_ENABLE_SHARED(no)])

# AC_ENABLE_STATIC - implement the --enable-static flag
# Usage: AC_ENABLE_STATIC[(DEFAULT)]
#   Where DEFAULT is either `yes' or `no'.  If omitted, it defaults to
#   `yes'.
AC_DEFUN(AC_ENABLE_STATIC, [dnl
define([AC_ENABLE_STATIC_DEFAULT], ifelse($1, no, no, yes))dnl
AC_ARG_ENABLE(static,
changequote(<<, >>)dnl
<<  --enable-static[=PKGS]  build static libraries [default=>>changequote([, ])AC_ENABLE_STATIC_DEFAULT[]changequote(<<, >>)],
changequote([, ])dnl
[p=${PACKAGE-default}
case "$enableval" in
yes) enable_static=yes ;;
no) enable_static=no ;;
*)
  enable_static=no
  # Look at the argument we got.  We use all the common list separators.
  IFS="${IFS= 	}"; ac_save_ifs="$IFS"; IFS="${IFS}:,"
  for pkg in $enableval; do
    if test "X$pkg" = "X$p"; then
      enable_static=yes
    fi
  done
  IFS="$ac_save_ifs"
  ;;
esac],
enable_static=AC_ENABLE_STATIC_DEFAULT)dnl
])

# AC_DISABLE_STATIC - set the default static flag to --disable-static
AC_DEFUN(AC_DISABLE_STATIC, [AC_BEFORE([$0],[AC_LIBTOOL_SETUP])dnl
AC_ENABLE_STATIC(no)])


# AC_ENABLE_FAST_INSTALL - implement the --enable-fast-install flag
# Usage: AC_ENABLE_FAST_INSTALL[(DEFAULT)]
#   Where DEFAULT is either `yes' or `no'.  If omitted, it defaults to
#   `yes'.
AC_DEFUN(AC_ENABLE_FAST_INSTALL, [dnl
define([AC_ENABLE_FAST_INSTALL_DEFAULT], ifelse($1, no, no, yes))dnl
AC_ARG_ENABLE(fast-install,
changequote(<<, >>)dnl
<<  --enable-fast-install[=PKGS]  optimize for fast installation [default=>>changequote([, ])AC_ENABLE_FAST_INSTALL_DEFAULT[]changequote(<<, >>)],
changequote([, ])dnl
[p=${PACKAGE-default}
case "$enableval" in
yes) enable_fast_install=yes ;;
no) enable_fast_install=no ;;
*)
  enable_fast_install=no
  # Look at the argument we got.  We use all the common list separators.
  IFS="${IFS= 	}"; ac_save_ifs="$IFS"; IFS="${IFS}:,"
  for pkg in $enableval; do
    if test "X$pkg" = "X$p"; then
      enable_fast_install=yes
    fi
  done
  IFS="$ac_save_ifs"
  ;;
esac],
enable_fast_install=AC_ENABLE_FAST_INSTALL_DEFAULT)dnl
])

# AC_ENABLE_FAST_INSTALL - set the default to --disable-fast-install
AC_DEFUN(AC_DISABLE_FAST_INSTALL, [AC_BEFORE([$0],[AC_LIBTOOL_SETUP])dnl
AC_ENABLE_FAST_INSTALL(no)])

# AC_PROG_LD - find the path to the GNU or non-GNU linker
AC_DEFUN(AC_PROG_LD,
[AC_ARG_WITH(gnu-ld,
[  --with-gnu-ld           assume the C compiler uses GNU ld [default=no]],
test "$withval" = no || with_gnu_ld=yes, with_gnu_ld=no)
AC_REQUIRE([AC_PROG_CC])dnl
AC_REQUIRE([AC_CANONICAL_HOST])dnl
AC_REQUIRE([_AC_CANONICAL_BUILD])dnl
ac_prog=ld
if test "$ac_cv_prog_gcc" = yes; then
  # Check if gcc -print-prog-name=ld gives a path.
  AC_MSG_CHECKING([for ld used by GCC])
  ac_prog=`($CC -print-prog-name=ld) 2>&5`
  case "$ac_prog" in
    # Accept absolute paths.
changequote(,)dnl
    [\\/]* | [A-Za-z]:[\\/]*)
      re_direlt='/[^/][^/]*/\.\./'
changequote([,])dnl
      # Canonicalize the path of ld
      ac_prog=`echo $ac_prog| sed 's%\\\\%/%g'`
      while echo $ac_prog | grep "$re_direlt" > /dev/null 2>&1; do
	ac_prog=`echo $ac_prog| sed "s%$re_direlt%/%"`
      done
      test -z "$LD" && LD="$ac_prog"
      ;;
  "")
    # If it fails, then pretend we aren't using GCC.
    ac_prog=ld
    ;;
  *)
    # If it is relative, then search for the first ld in PATH.
    with_gnu_ld=unknown
    ;;
  esac
elif test "$with_gnu_ld" = yes; then
  AC_MSG_CHECKING([for GNU ld])
else
  AC_MSG_CHECKING([for non-GNU ld])
fi
AC_CACHE_VAL(ac_cv_path_LD,
[if test -z "$LD"; then
  IFS="${IFS= 	}"; ac_save_ifs="$IFS"; IFS="${IFS}${PATH_SEPARATOR-:}"
  for ac_dir in $PATH; do
    test -z "$ac_dir" && ac_dir=.
    if test -f "$ac_dir/$ac_prog" || test -f "$ac_dir/$ac_prog$ac_exeext"; then
      ac_cv_path_LD="$ac_dir/$ac_prog"
      # Check to see if the program is GNU ld.  I'd rather use --version,
      # but apparently some GNU ld's only accept -v.
      # Break only if it was the GNU/non-GNU ld that we prefer.
      if "$ac_cv_path_LD" -v 2>&1 < /dev/null | egrep '(GNU|with BFD)' > /dev/null; then
	test "$with_gnu_ld" != no && break
      else
	test "$with_gnu_ld" != yes && break
      fi
    fi
  done
  IFS="$ac_save_ifs"
else
  ac_cv_path_LD="$LD" # Let the user override the test with a path.
fi])
LD="$ac_cv_path_LD"
if test -n "$LD"; then
  AC_MSG_RESULT($LD)
else
  AC_MSG_RESULT(no)
fi
test -z "$LD" && AC_MSG_ERROR([no acceptable ld found in \$PATH])
AC_PROG_LD_GNU
])

AC_DEFUN(AC_PROG_LD_GNU,
[AC_CACHE_CHECK([if the linker ($LD) is GNU ld], ac_cv_prog_gnu_ld,
[# I'd rather use --version here, but apparently some GNU ld's only accept -v.
if $LD -v 2>&1 </dev/null | egrep '(GNU|with BFD)' 1>&5; then
  ac_cv_prog_gnu_ld=yes
else
  ac_cv_prog_gnu_ld=no
fi])
])

# AC_PROG_NM - find the path to a BSD-compatible name lister
AC_DEFUN(AC_PROG_NM,
[AC_MSG_CHECKING([for BSD-compatible nm])
AC_CACHE_VAL(ac_cv_path_NM,
[if test -n "$NM"; then
  # Let the user override the test.
  ac_cv_path_NM="$NM"
else
  IFS="${IFS= 	}"; ac_save_ifs="$IFS"; IFS="${IFS}${PATH_SEPARATOR-:}"
  for ac_dir in $PATH /usr/ccs/bin /usr/ucb /bin; do
    test -z "$ac_dir" && ac_dir=.
    if test -f $ac_dir/nm || test -f $ac_dir/nm$ac_exeext ; then
      # Check to see if the nm accepts a BSD-compat flag.
      # Adding the `sed 1q' prevents false positives on HP-UX, which says:
      #   nm: unknown option "B" ignored
      if ($ac_dir/nm -B /dev/null 2>&1 | sed '1q'; exit 0) | egrep /dev/null >/dev/null; then
	ac_cv_path_NM="$ac_dir/nm -B"
	break
      elif ($ac_dir/nm -p /dev/null 2>&1 | sed '1q'; exit 0) | egrep /dev/null >/dev/null; then
	ac_cv_path_NM="$ac_dir/nm -p"
	break
      else
	ac_cv_path_NM=${ac_cv_path_NM="$ac_dir/nm"} # keep the first match, but
	continue # so that we can try to find one that supports BSD flags
      fi
    fi
  done
  IFS="$ac_save_ifs"
  test -z "$ac_cv_path_NM" && ac_cv_path_NM=nm
fi])
NM="$ac_cv_path_NM"
AC_MSG_RESULT([$NM])
])

# AC_CHECK_LIBM - check for math library
AC_DEFUN(AC_CHECK_LIBM,
[AC_REQUIRE([AC_CANONICAL_HOST])dnl
LIBM=
case "$lt_target" in
*-*-beos* | *-*-cygwin*)
  # These system don't have libm
  ;;
*-ncr-sysv4.3*)
  AC_CHECK_LIB(mw, _mwvalidcheckl, LIBM="-lmw")
  AC_CHECK_LIB(m, main, LIBM="$LIBM -lm")
  ;;
*)
  AC_CHECK_LIB(m, main, LIBM="-lm")
  ;;
esac
])

# AC_LIBLTDL_CONVENIENCE[(dir)] - sets LIBLTDL to the link flags for
# the libltdl convenience library, adds --enable-ltdl-convenience to
# the configure arguments.  Note that LIBLTDL is not AC_SUBSTed, nor
# is AC_CONFIG_SUBDIRS called.  If DIR is not provided, it is assumed
# to be `${top_builddir}/libltdl'.  Make sure you start DIR with
# '${top_builddir}/' (note the single quotes!) if your package is not
# flat, and, if you're not using automake, define top_builddir as
# appropriate in the Makefiles.
AC_DEFUN(AC_LIBLTDL_CONVENIENCE, [AC_BEFORE([$0],[AC_LIBTOOL_SETUP])dnl
  case "$enable_ltdl_convenience" in
  no) AC_MSG_ERROR([this package needs a convenience libltdl]) ;;
  "") enable_ltdl_convenience=yes
      ac_configure_args="$ac_configure_args --enable-ltdl-convenience" ;;
  esac
  LIBLTDL=ifelse($#,1,$1,['${top_builddir}/libltdl'])/libltdlc.la
  INCLTDL=ifelse($#,1,-I$1,['-I${top_builddir}/libltdl'])
])

# AC_LIBLTDL_INSTALLABLE[(dir)] - sets LIBLTDL to the link flags for
# the libltdl installable library, and adds --enable-ltdl-install to
# the configure arguments.  Note that LIBLTDL is not AC_SUBSTed, nor
# is AC_CONFIG_SUBDIRS called.  If DIR is not provided, it is assumed
# to be `${top_builddir}/libltdl'.  Make sure you start DIR with
# '${top_builddir}/' (note the single quotes!) if your package is not
# flat, and, if you're not using automake, define top_builddir as
# appropriate in the Makefiles.
# In the future, this macro may have to be called after AC_PROG_LIBTOOL.
AC_DEFUN(AC_LIBLTDL_INSTALLABLE, [AC_BEFORE([$0],[AC_LIBTOOL_SETUP])dnl
  AC_CHECK_LIB(ltdl, main,
  [test x"$enable_ltdl_install" != xyes && enable_ltdl_install=no],
  [if test x"$enable_ltdl_install" = xno; then
     AC_MSG_WARN([libltdl not installed, but installation disabled])
   else
     enable_ltdl_install=yes
   fi
  ])
  if test x"$enable_ltdl_install" = x"yes"; then
    ac_configure_args="$ac_configure_args --enable-ltdl-install"
    LIBLTDL=ifelse($#,1,$1,['${top_builddir}/libltdl'])/libltdl.la
    INCLTDL=ifelse($#,1,-I$1,['-I${top_builddir}/libltdl'])
  else
    ac_configure_args="$ac_configure_args --enable-ltdl-install=no"
    LIBLTDL="-lltdl"
    INCLTDL=
  fi
])

dnl old names
AC_DEFUN(AM_PROG_LIBTOOL, [indir([AC_PROG_LIBTOOL])])dnl
AC_DEFUN(AM_ENABLE_SHARED, [indir([AC_ENABLE_SHARED], $@)])dnl
AC_DEFUN(AM_ENABLE_STATIC, [indir([AC_ENABLE_STATIC], $@)])dnl
AC_DEFUN(AM_DISABLE_SHARED, [indir([AC_DISABLE_SHARED], $@)])dnl
AC_DEFUN(AM_DISABLE_STATIC, [indir([AC_DISABLE_STATIC], $@)])dnl
AC_DEFUN(AM_PROG_LD, [indir([AC_PROG_LD])])dnl
AC_DEFUN(AM_PROG_NM, [indir([AC_PROG_NM])])dnl

dnl This is just to silence aclocal about the macro not being used
ifelse([AC_DISABLE_FAST_INSTALL])dnl
## ------------------------
## Emacs LISP file handling
## From Ulrich Drepper
## Almost entirely rewritten by Alexandre Oliva
## ------------------------

# serial 3

AC_DEFUN(AM_PATH_LISPDIR,
 [# If set to t, that means we are running in a shell under Emacs.
  # If you have an Emacs named "t", then use the full path.
  test x"$EMACS" = xt && EMACS=
  AC_CHECK_PROGS(EMACS, emacs xemacs, no)
  if test $EMACS != "no"; then
    if test x${lispdir+set} != xset; then
      AC_CACHE_CHECK([where .elc files should go], [am_cv_lispdir], [dnl
	am_cv_lispdir=`$EMACS -batch -q -eval '(while load-path (princ (concat (car load-path) "\n")) (setq load-path (cdr load-path)))' | sed -n -e 's,/$,,' -e '/.*\/lib\/\(x\?emacs\/site-lisp\)$/{s,,${libdir}/\1,;p;q;}' -e '/.*\/share\/\(x\?emacs\/site-lisp\)$/{s,,${datadir}/\1,;p;q;}'`
	if test -z "$am_cv_lispdir"; then
	  am_cv_lispdir='${datadir}/emacs/site-lisp'
	fi
      ])
      lispdir="$am_cv_lispdir"
    fi
  fi
  AC_SUBST(lispdir)])
## --------------------------------------------------------- ##
## Find what is the program to use to send to the printer    ##
## 				demaille@inf.enst.fr	     ##
## --------------------------------------------------------- ##

# serial 3

#
#	Find the program to send to the printer
# Put the prog name in LPR, its option for destination in LPR_QUEUE_OPTION
#
AC_DEFUN(ad_PROG_LPR,
  [AC_CHECK_PROGS(LPR, lp lpr, no)
   AC_MSG_CHECKING([for printer queue selection])
   case "x$LPR" in
      xlp)  LPR_QUEUE_OPTION=-d ;;
      xlpr) LPR_QUEUE_OPTION=-P ;;
      xno)  LPR="cat"
            LPR_QUEUE_OPTION=">"
	    ;;
      *)    # This user has specified per $LPR and $LPR_QUEUE_OPTION
	    ;;
   esac
   AC_MSG_RESULT([$LPR $LPR_QUEUE_OPTION PRINTER])
   AC_SUBST(LPR_QUEUE_OPTION)])
#serial 3

dnl From Jim Meyering.
dnl Determine whether malloc accepts 0 as its argument.
dnl If it doesn't, arrange to use the replacement function.
dnl

AC_DEFUN(jm_FUNC_MALLOC,
[
 dnl xmalloc.c requires that this symbol be defined so it doesn't
 dnl mistakenly use a broken malloc -- as it might if this test were omitted.
 AC_DEFINE_UNQUOTED(HAVE_DONE_WORKING_MALLOC_CHECK, 1,
                    [Define if the malloc check has been performed. ])

 AC_CACHE_CHECK([for working malloc], jm_cv_func_working_malloc,
  [AC_TRY_RUN([
    char *malloc ();
    int
    main ()
    {
      exit (malloc (0) ? 0 : 1);
    }
	  ],
	 jm_cv_func_working_malloc=yes,
	 jm_cv_func_working_malloc=no,
	 dnl When crosscompiling, assume malloc is broken.
	 jm_cv_func_working_malloc=no)
  ])
  if test $jm_cv_func_working_malloc = no; then
    AC_SUBST(LIBOBJS)
    LIBOBJS="$LIBOBJS malloc.$ac_objext"
    AC_DEFINE_UNQUOTED(malloc, rpl_malloc,
      [Define to rpl_malloc if the replacement function should be used.])
  fi
])
## --------------------------------------------------------- ##
## Fake the existence of programs that GNU maintainers use.  ##
## --------------------------------------------------------- ##
dnl AM_MISSING_PROG(NAME, PROGRAM)
AC_DEFUN(AM_MISSING_PROG, [
AC_REQUIRE([AM_MISSING_HAS_RUN])
$1=${$1-"${am_missing_run}$2"}
AC_SUBST($1)])

dnl Like AM_MISSING_PROG, but only looks for install-sh.
dnl AM_MISSING_INSTALL_SH(NAME)
AC_DEFUN(AM_MISSING_INSTALL_SH, [
AC_REQUIRE([AM_MISSING_HAS_RUN])
if test -z "$1"; then
   $1="${am_missing_run}install-sh"
   test -f "$1" || $1="${am_missing_run}install.sh"
fi
AC_SUBST($1)])

dnl AM_MISSING_HAS_RUN.
dnl Define MISSING if not defined so far and test if it supports --run.
dnl If it does, set am_missing_run to use it, otherwise, to nothing.
AC_DEFUN([AM_MISSING_HAS_RUN], [
test x"${MISSING+set}" = xset || \
  MISSING="\${SHELL} `CDPATH=: && cd $ac_aux_dir && pwd`/missing"
dnl Use eval to expand $SHELL
if eval "$MISSING --run :"; then
  am_missing_run="$MISSING --run "
else
  am_missing_run=
  AC_MSG_WARN([\`missing' script is too old or missing])
fi
])
dnl From Jim Meyering.
dnl FIXME: migrate into libit.

AC_DEFUN(AM_FUNC_OBSTACK,
[AC_CACHE_CHECK([for obstacks], am_cv_func_obstack,
 [AC_TRY_LINK([#include "obstack.h"],
	      [struct obstack *mem;obstack_free(mem,(char *) 0)],
	      am_cv_func_obstack=yes,
	      am_cv_func_obstack=no)])
 if test $am_cv_func_obstack = yes; then
   AC_DEFINE(HAVE_OBSTACK,1,[Define if libc includes obstacks])
 else
   LIBOBJS="$LIBOBJS obstack.$ac_objext"
 fi
])
#serial 1

dnl From Jim Meyering.
dnl Find a new-enough version of Perl.
dnl

AC_DEFUN(jm_PERL,
[
  dnl FIXME: don't hard-code 5.003
  dnl FIXME: should we cache the result?
  AC_MSG_CHECKING([for perl5.003 or newer])
  if test "${PERL+set}" = set; then
    # `PERL' is set in the user's environment.
    candidate_perl_names="$PERL"
    perl_specified=yes
  else
    candidate_perl_names='perl perl5'
    perl_specified=no
  fi

  found=no
  AC_SUBST(PERL)
  PERL="$missing_dir/missing perl"
  for perl in $candidate_perl_names; do
    # Run test in a subshell; some versions of sh will print an error if
    # an executable is not found, even if stderr is redirected.
    if ( $perl -e 'require 5.003' ) > /dev/null 2>&1; then
      PERL=$perl
      found=yes
      break
    fi
  done

  AC_MSG_RESULT($found)
  test $found = no && AC_MSG_WARN([
*** You don't seem to have perl5.003 or newer installed.
*** Because of that, you may be unable to regenerate certain files
*** if you modify the sources from which they are derived.] )
])

dnl The same, but the path to perl is wanted.
dnl
dnl By Akim Demaille, do not flame Jim for this :)
AC_DEFUN(jm_PATH_PERL,
[
  dnl FIXME: don't hard-code 5.003
  dnl FIXME: should we cache the result?
  if test "${PERL+set}" = set; then
    # `PERL' is set in the user's environment.
    candidate_perl_names="$PERL"
    perl_specified=yes
  else
    candidate_perl_names='perl perl5'
    perl_specified=no
  fi

  found=no
  for perl_name in $candidate_perl_names; do
    # Run test in a subshell; some versions of sh will print an error if
    # an executable is not found, even if stderr is redirected.
    AC_PATH_PROG(PERL, $perl_name, no)
    if test "$PERL" != "no" \
       && ( $PERL -e 'require 5.003' ) > /dev/null 2>&1; then
      found=yes
      break
    fi
  done

  if test $found = no; then
    PERL="$missing_dir/missing perl"
    AC_SUBST(PERL)
    AC_MSG_WARN([
*** You don't seem to have perl5.003 or newer installed.
*** Because of that, you may be unable to regenerate certain files
*** if you modify the sources from which they are derived.] )
  fi
])
# Search path for a program which passes the given test.
# Ulrich Drepper <drepper@cygnus.com>, 1996.
#
# This file can be copied and used freely without restrictions.  It can
# be used in projects which are not available under the GNU Public License
# but which still want to provide support for the GNU gettext functionality.
# Please note that the actual code is *not* freely available.

# serial 1

dnl AM_PATH_PROG_WITH_TEST(VARIABLE, PROG-TO-CHECK-FOR,
dnl   TEST-PERFORMED-ON-FOUND_PROGRAM [, VALUE-IF-NOT-FOUND [, PATH]])
AC_DEFUN(AM_PATH_PROG_WITH_TEST,
[# Extract the first word of "$2", so it can be a program name with args.
set dummy $2; ac_word=[$]2
AC_MSG_CHECKING([for $ac_word])
AC_CACHE_VAL(ac_cv_path_$1,
[case "[$]$1" in
  /*)
  ac_cv_path_$1="[$]$1" # Let the user override the test with a path.
  ;;
  *)
  IFS="${IFS= 	}"; ac_save_ifs="$IFS"; IFS="${IFS}:"
  for ac_dir in ifelse([$5], , $PATH, [$5]); do
    test -z "$ac_dir" && ac_dir=.
    if test -f $ac_dir/$ac_word; then
      if [$3]; then
	ac_cv_path_$1="$ac_dir/$ac_word"
	break
      fi
    fi
  done
  IFS="$ac_save_ifs"
dnl If no 4th arg is given, leave the cache variable unset,
dnl so AC_PATH_PROGS will keep looking.
ifelse([$4], , , [  test -z "[$]ac_cv_path_$1" && ac_cv_path_$1="$4"
])dnl
  ;;
esac])dnl
$1="$ac_cv_path_$1"
if test -n "[$]$1"; then
  AC_MSG_RESULT([$]$1)
else
  AC_MSG_RESULT(no)
fi
AC_SUBST($1)dnl
])
## ------------------------------- ##
## Check for function prototypes.  ##
## From Franc,ois Pinard           ##
## ------------------------------- ##

# serial 1

AC_DEFUN(AM_C_PROTOTYPES,
[AC_REQUIRE([AM_PROG_CC_STDC])
AC_REQUIRE([AC_PROG_CPP])
AC_MSG_CHECKING([for function prototypes])
if test "$am_cv_prog_cc_stdc" != no; then
  AC_MSG_RESULT(yes)
  AC_DEFINE(PROTOTYPES,1,[Define if compiler has function prototypes])
  U= ANSI2KNR=
else
  AC_MSG_RESULT(no)
  U=_ ANSI2KNR=./ansi2knr
  # Ensure some checks needed by ansi2knr itself.
  AC_HEADER_STDC
  AC_CHECK_HEADERS(string.h)
fi
AC_SUBST(U)dnl
AC_SUBST(ANSI2KNR)dnl
])
#serial 3

dnl From Jim Meyering.
dnl Determine whether realloc works when both arguments are 0.
dnl If it doesn't, arrange to use the replacement function.
dnl

AC_DEFUN(jm_FUNC_REALLOC,
[
 dnl xmalloc.c requires that this symbol be defined so it doesn't
 dnl mistakenly use a broken realloc -- as it might if this test were omitted.
 AC_DEFINE_UNQUOTED(HAVE_DONE_WORKING_REALLOC_CHECK, 1,
                    [Define if the realloc check has been performed. ])

 AC_CACHE_CHECK([for working realloc], jm_cv_func_working_realloc,
  [AC_TRY_RUN([
    char *realloc ();
    int
    main ()
    {
      exit (realloc (0, 0) ? 0 : 1);
    }
	  ],
	 jm_cv_func_working_realloc=yes,
	 jm_cv_func_working_realloc=no,
	 dnl When crosscompiling, assume realloc is broken.
	 jm_cv_func_working_realloc=no)
  ])
  if test $jm_cv_func_working_realloc = no; then
    AC_SUBST(LIBOBJS)
    LIBOBJS="$LIBOBJS realloc.$ac_objext"
    AC_DEFINE_UNQUOTED(realloc, rpl_realloc,
      [Define to rpl_realloc if the replacement function should be used.])
  fi
])
## -------------------------------------------------- ##
##  Check if rename(2) is available and working.      ##
##  Replace if necessary                              ##
##                           akim@epita.fr            ##
## -------------------------------------------------- ##

dnl rename.c should be available

# serial 2

AC_DEFUN(ad_CHECK_FUNC_RENAME,
[AC_CHECK_FUNCS(rename)
if test $ac_cv_func_rename = yes; then
  AC_CACHE_CHECK([whether rename works], ac_cv_func_rename_works,
  [ac_cv_func_rename_works=no
   : >conftest.1
   : >conftest.2
   AC_TRY_RUN([#include <stdio.h>
int main () { exit (rename ("conftest.1", "conftest.2")); }],
   test -f conftest.1 || ac_cv_func_rename_works=yes,,:)])
fi])

AC_DEFUN(ad_REPLACE_FUNC_RENAME,
[AC_REQUIRE([ad_CHECK_FUNC_RENAME])dnl
AC_REQUIRE([AC_HEADER_STAT])dnl
if test "$ac_cv_func_rename" = no ||
   test "$ac_cv_func_rename_works" = no; then
  AC_CHECK_FUNCS(link)
  dnl FIXME: Define MVDIR
  LIBOBJS="$LIBOBJS rename.o"
  AC_DEFINE_UNQUOTED(rename, rpl_rename,
   [Define to the replacement function if should be used.])
fi])
#
# Check to make sure that the build environment is sane.
#

AC_DEFUN(AM_SANITY_CHECK,
[AC_MSG_CHECKING([whether build environment is sane])
# Just in case
sleep 1
echo timestamp > conftestfile
# Do `set' in a subshell so we don't clobber the current shell's
# arguments.  Must try -L first in case configure is actually a
# symlink; some systems play weird games with the mod time of symlinks
# (eg FreeBSD returns the mod time of the symlink's containing
# directory).
if (
   set X `ls -Lt $srcdir/configure conftestfile 2> /dev/null`
   if test "[$]*" = "X"; then
      # -L didn't work.
      set X `ls -t $srcdir/configure conftestfile`
   fi
   if test "[$]*" != "X $srcdir/configure conftestfile" \
      && test "[$]*" != "X conftestfile $srcdir/configure"; then

      # If neither matched, then we have a broken ls.  This can happen
      # if, for instance, CONFIG_SHELL is bash and it inherits a
      # broken ls alias from the environment.  This has actually
      # happened.  Such a system could not be considered "sane".
      AC_MSG_ERROR([ls -t appears to fail.  Make sure there is not a broken
alias in your environment])
   fi

   test "[$]2" = conftestfile
   )
then
   # Ok.
   :
else
   AC_MSG_ERROR([newly created file is older than distributed files!
Check your system clock])
fi
rm -f conftest*
AC_MSG_RESULT(yes)])
## --------------------------------------------------------- ##
##  Check if strcasecmp/strncasecmp are available,           ##
##  and replace if necessary                                 ##
##                           demaille@inf.enst.fr            ##
## --------------------------------------------------------- ##

dnl strcasecmp.c and/or strncasecmp should be available.

# serial 1

AC_DEFUN(ad_REPLACE_FUNC_STRCASECMP,
[AC_CHECK_FUNCS(strcasecmp)
 if test $ac_cv_func_strcasecmp = no; then
   AC_CHECK_FUNCS(stricmp)
   if test $ac_cv_func_stricmp = no; then
     LIBOBJS="$LIBOBJS strcasecmp.o"
   else
     AC_DEFINE_UNQUOTED(strcasecmp, stricmp,
	  [Define to the replacement function if should be used.])
   fi
 fi])

AC_DEFUN(ad_REPLACE_FUNC_STRNCASECMP,
[AC_CHECK_FUNCS(strncasecmp)
 if test $ac_cv_func_strncasecmp = no; then
   AC_CHECK_FUNCS(strnicmp)
   if test $ac_cv_func_strnicmp = no; then
     LIBOBJS="$LIBOBJS strncasecmp.o"
   else
     AC_DEFINE_UNQUOTED(strncasecmp, strnicmp,
	  [Define to the replacement function if should be used.])
   fi
 fi])
## --------------------------------------------------------- ##
##  Check if there is a functioning strftime, and replace    ##
##                           demaille@inf.enst.fr            ##
## --------------------------------------------------------- ##

# serial 2

AC_DEFUN(ad_FUNC_STRFTIME,
[ AC_FUNC_STRFTIME
  AC_STRUCT_TIMEZONE
  AC_CHECK_FUNCS(tzset mblen mbrlen)
  AC_CHECK_HEADERS(limits.h)
  AC_FUNC_MKTIME
  if test $ac_cv_func_strftime = no; then
    LIBOBJS="$LIBOBJS strftime.o"
    if test $ac_cv_func_working_mktime = no; then
       AC_DEFINE_UNQUOTED(mktime, rpl_mktime,
	[Define to rpl_mktime if the replacement function should be used.])
    fi
  fi])
dnl From Jim Meyering.

# serial 1

AC_DEFUN(AM_SYS_POSIX_TERMIOS,
[AC_CACHE_CHECK([POSIX termios], am_cv_sys_posix_termios,
  [AC_TRY_LINK([#include <sys/types.h>
#include <unistd.h>
#include <termios.h>],
  [/* SunOS 4.0.3 has termios.h but not the library calls.  */
   tcgetattr(0, 0);],
  am_cv_sys_posix_termios=yes,
  am_cv_sys_posix_termios=no)])
])
dnl Make all the needed checks to use tinyterm.[ch]
dnl Akim.Demaille@inf.enst.fr

#serial 2

AC_DEFUN(ad_TINYTERM_CHECKS,
[AC_REQUIRE([AM_HEADER_TIOCGWINSZ_NEEDS_SYS_IOCTL])
 AC_CHECK_HEADERS(termios.h sys/types.h unistd.h limits.h)
 AC_REQUIRE([jm_AC_HEADER_INTTYPES_H])
])
#serial 5

dnl From Paul Eggert.

AC_PREREQ(2.13)

# Define uintmax_t to `unsigned long' or `unsigned long long'
# if <inttypes.h> does not exist.

AC_DEFUN(jm_AC_TYPE_UINTMAX_T,
[
  AC_REQUIRE([jm_AC_HEADER_INTTYPES_H])
  if test $jm_ac_cv_header_inttypes_h = no; then
    AC_REQUIRE([jm_AC_TYPE_UNSIGNED_LONG_LONG])
    test $ac_cv_type_unsigned_long_long = yes \
      && ac_type='unsigned long long' \
      || ac_type='unsigned long'
    AC_DEFINE_UNQUOTED(uintmax_t, $ac_type,
[  Define to unsigned long or unsigned long long
   if <inttypes.h> doesn't define.])
  fi
])
#serial 2

dnl From Paul Eggert.

AC_DEFUN(jm_AC_TYPE_UNSIGNED_LONG_LONG,
[
  AC_CACHE_CHECK([for unsigned long long], ac_cv_type_unsigned_long_long,
  [AC_TRY_LINK([unsigned long long ull = 1; int i = 63;],
    [unsigned long long ullmax = (unsigned long long) -1;
     return ull << i | ull >> i | ullmax / ull | ullmax % ull;],
    ac_cv_type_unsigned_long_long=yes,
    ac_cv_type_unsigned_long_long=no)])
  if test $ac_cv_type_unsigned_long_long = yes; then
    AC_DEFINE(HAVE_UNSIGNED_LONG_LONG, 1,
      [Define if you have the unsigned long long type.])
  fi
])
dnl From Jim Meyering.

# serial 1

AC_DEFUN(AM_HEADER_TIOCGWINSZ_NEEDS_SYS_IOCTL,
[AC_REQUIRE([AM_SYS_POSIX_TERMIOS])
 AC_CACHE_CHECK([whether use of TIOCGWINSZ requires sys/ioctl.h],
	        am_cv_sys_tiocgwinsz_needs_sys_ioctl_h,
  [am_cv_sys_tiocgwinsz_needs_sys_ioctl_h=no

  gwinsz_in_termios_h=no
  if test $am_cv_sys_posix_termios = yes; then
    AC_EGREP_CPP([yes],
    [#include <sys/types.h>
#     include <termios.h>
#     ifdef TIOCGWINSZ
        yes
#     endif
    ], gwinsz_in_termios_h=yes)
  fi

  if test $gwinsz_in_termios_h = no; then
    AC_EGREP_CPP([yes],
    [#include <sys/types.h>
#     include <sys/ioctl.h>
#     ifdef TIOCGWINSZ
        yes
#     endif
    ], am_cv_sys_tiocgwinsz_needs_sys_ioctl_h=yes)
  fi
  ])
  if test $am_cv_sys_tiocgwinsz_needs_sys_ioctl_h = yes; then
    AC_DEFINE(GWINSZ_IN_SYS_IOCTL,1,
              [Define if TIOCGWINSZ requires sys/ioctl.h])
  fi
])
#serial 2

# autoconf tests required for use of xstrtoumax.c

AC_DEFUN(jm_AC_PREREQ_XSTRTOUMAX,
[
  AC_REQUIRE([jm_AC_HEADER_INTTYPES_H])
  AC_REQUIRE([jm_AC_TYPE_UNSIGNED_LONG_LONG])
  AC_CHECK_HEADERS(stdlib.h)

  AC_CACHE_CHECK([whether <inttypes.h> defines strtoumax as a macro],
    jm_cv_func_strtoumax_macro,
    AC_EGREP_CPP([inttypes_h_defines_strtoumax], [#include <inttypes.h>
#ifdef strtoumax
 inttypes_h_defines_strtoumax
#endif],
      jm_cv_func_strtoumax_macro=yes,
      jm_cv_func_strtoumax_macro=no))

  if test "$jm_cv_func_strtoumax_macro" != yes; then
    AC_REPLACE_FUNCS(strtoumax)
  fi

  dnl We don't need (and can't compile) the replacement strtoull
  dnl unless the type `unsigned long long' exists.
  dnl Also, only the replacement strtoumax invokes strtoull,
  dnl so we need the replacement strtoull only if strtoumax does not exist.
  case "$ac_cv_type_unsigned_long_long,$jm_cv_func_strtoumax_macro,$ac_cv_func_strtoumax" in
    yes,no,no)
      AC_REPLACE_FUNCS(strtoull)
      ;;
  esac

])
