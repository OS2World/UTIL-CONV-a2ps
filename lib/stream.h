/*
 * stream.h
 *
 * Open streams on pipes or files.
 *
 * Copyright (c) 1988-1993 Miguel Santana
 * Copyright (c) 1995-1999 Akim Demaille, Miguel Santana
 *
 */

/*
 * This file is part of a2ps.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2, or (at your option)
 * any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; see the file COPYING.  If not, write to
 * the Free Software Foundation, 59 Temple Place - Suite 330,
 * Boston, MA 02111-1307, USA.
 */

/*
 * $Id: stream.h,v 1.4 1998/03/03 15:51:22 demaille Exp $
 */
#ifndef _STREAM_H_
#define _STREAM_H_
#include "xbackupfile.h"

struct stream
{
  bool is_file;	/* Is it a file (no : pipe)		*/
  FILE *fp;
};

/* Open for reading */
struct stream * stream_ropen PARAMS ((const char * command,
				      bool is_file));
/* Open for writing */
struct stream * stream_wopen PARAMS ((const char * command,
				      bool is_file));
/* Open for writing, using backup services */
struct stream * stream_wopen_backup PARAMS ((const char * command,
					     bool is_file,
					     enum backup_type backup_type));

/*
 * Uses the perl convention to know whether file or pipe
 * I.e., command starts by '>', or '|'
 */
struct stream * stream_perl_open_backup
   PARAMS ((char const * perl_command, enum backup_type backup,
	    const char **name));

/* Closes and frees.  */
void stream_close PARAMS ((struct stream * stream));

#endif
