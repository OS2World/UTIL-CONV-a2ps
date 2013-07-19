/* */

  call RxFuncAdd 'SysLoadFuncs', 'RexxUtil', 'SysLoadFuncs'
  call 'SysLoadFuncs'

  parse arg p1 p2 p3 p4 p5 rest

  if p1 == ""   then dohelp()
  if p1 == "-h" then dohelp()
  if p1 == "-?" then dohelp()

  '@f:\projects\a2ps\a2ps-4.13\src\a2ps.exe -P lpr' p1 p2 p3 p4 p5
exit(0)

dohelp: procedure expose p2 p3 p4
  '@f:\projects\a2ps\a2ps-4.13\src\a2ps.exe --help' p2 p3 p4
exit(0)
