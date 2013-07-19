/* GSSE */
/* version 980929 */
/*
  Generic Shell Script Executor for OS/2
  ======================================

  Just rename this .cmd to <foo.cmd> and it will execute the
  shell script <foo> by calling sh.exe (as found in path)

  No need to patch the shell scripts anymore. Works also
  for all shells that support REXX scripts.
  Note that "sh.exe" is explicitly called!
*/

Parse Arg param
Parse Source run_os run_env run_name

name   = FileSpec("Name", run_name)
path   = FileSpec("Path", run_name)
drive  = FileSpec("Drive", run_name)
shortname  = Left(name, Pos(".CMD", Translate(name))-1)
scriptname = drive""path""shortname
scriptname = SlashifyS(scriptname)
rc = ExecCmd("sh.exe " scriptname" "param)

exit

/* Subroutines */

ExecCmd: PROCEDURE
/* Execute a command properly and return it's return value */

Parse Arg cmdstring
Address CMD "@ "cmdstring
return rc

SlashifyS: PROCEDURE
/* Convert backslash into slashs */

Parse Arg input
input = Translate( input, '/', '\' )
return input
