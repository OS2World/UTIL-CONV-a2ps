/* tinyterm.h -- Minimalist information on the terminal
   Copyright (C) 1998 Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software Foundation,
   Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.  */

#ifndef _TINYTERM_H_
#define _TINYTERM_H_

#ifndef PARAMS
# if defined PROTOTYPES || defined __STDC__
#  define PARAMS(Args) Args
# else
#  define PARAMS(Args) ()
# endif
#endif

struct tterm;

/* Initialize TTERM taking the environment into account (for line
   width, and tabsize) for STREAM. */
void tterm_initialize PARAMS ((struct tterm *tterm, FILE *stream));

/* Set the line width of TTERM to WIDTH.  Returns the previous value. */
size_t tterm_width_set PARAMS ((struct tterm *tterm, size_t width));

/* Return the line width of TTERM. */
size_t tterm_width PARAMS ((struct tterm *tterm));

/* Set the tab size of TTERM to SIZE.  Returns the previous value. */
size_t tterm_tabsize_set PARAMS ((struct tterm *tterm, size_t size));

/* Return the tab size of TTERM. */
size_t tterm_tabsize PARAMS ((struct tterm *tterm));

#endif /* ! _TINYTERM_H_ */
