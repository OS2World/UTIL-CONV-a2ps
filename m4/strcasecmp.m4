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
