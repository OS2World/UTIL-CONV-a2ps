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
