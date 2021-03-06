include(shell.m4)dnl -*- shell-script -*-
#! /bin/sh
# -*- ksh -*-
# pdiff --- Print diff in a nice way

GPL([Copyright (c) 1998, 1999 Akim Demaille, Miguel Santana])

# Author: Akim Demaille <demaille@inf.enst.fr>

# Get the name of the program
program=`echo $0 | sed 's#.*/##g'`

changequote(, )
# Local vars
a2ps=${A2PS:-a2ps}
a2ps_options=
debug=
diff_on=words
diff_prog=${DIFF:-diff}
diff_options='-u'
file=
output=
tmpdir=/tmp/$program.$$
verbose=echo
wdiff_prog=${WDIFF:-wdiff}
wdiff_options='-w[wd- -x-wd] -y{wd+ -z+wd}'
# The version/usage strings
version="pdiff 0.4 (@GNU_PACKAGE@ @VERSION@)
Written by Akim Demaille.

Copyright (c) 1997-1999 Akim Demaille, Miguel Santana
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE."

usage="\
Usage: $program FILE1 FILE2 [-- A2PS-OPTIONS...]
Pretty print the differences between FILE1 and FILE2.

Options:
 -h, --help           display this help and exit
 -v, --version        display version information and exit
 -q, --quiet          don't print informational messages
 -l, --lines          search for line differences (\`diff')
 -w, --words          search for word differences (\`wdiff')
 -o, --output=FILE    save the output in FILE

Options for a2ps are given after \`--', for instance

    $ pdiff COPYING COPYING.LIB -- -Pdisplay

News, updates and documentation: http://www.inf.enst.fr/~demaille/a2ps/.
Report bugs to <bug-a2ps@gnu.org>."

help="Try \`$program --help' for more information."
changequote([, ])

# Parse command line arguments.
option_without_arguments='vhsqDlw'
GETOPT([    -v | --v*) echo "$version"; exit 0;;
    -h | --h*) echo "$usage"; exit 0;;
    -s|-q|--q*|--s*) verbose=: ;;
    -D | --debug) debug=: ;;
    -o|--output) shift
                 a2ps_options="$a2ps_options --output=$1" ;;
    -l|--lines) diff_on=lines;;
    -w|--words) diff_on=words;;])

# What remains is ORIG NEW [A2PS_OPTIONS...]
if test $# -lt 2; then
 exec 1>&2
 echo "$program: not enough arguments"
 echo "$help"
 exit 1
fi

file1="$1"
shift
file2="$1"
shift

# Set the titles
a2ps_options="--left-title=$file1 --right-title=$file2 $a2ps_options"
a2ps_options="--center-title $a2ps_options"

# Use the right prologue
a2ps_options="--prolog=diff $a2ps_options"

# Give the additional arguments given by the user
a2ps_options="$@ $a2ps_options"

# Set -x now if debugging
test $debug && set -x

# Call the correct diffing program, and pipe into a2ps
case $diff_on in
  words) # Word differences
    $wdiff_prog $wdiff_options $file1 $file2	\
       | $a2ps -Ewdiff $a2ps_options || exit 1
    ;;

  lines) # Line differences
    # We need the total number of lines
    lines=`wc -l $file1 $file2 | sed -n 3p`
    lines=`set -- $lines && echo $1`
    $diff_prog $diff_options -$lines $file1 $file2	\
       | $a2ps -gEudiff $a2ps_options || exit 1
    ;;
esac

exit 0
