/* ANSI-C code produced by gperf version 2.7.1 (19981006 egcs) */
/* Command-line: gperf -t -D -L ANSI-C confg.gperf  */	/* -*- C -*- */
/*
 * confg.c
 *
 * Read and understanding everything about the options
 * & (dynamic) configuration of a2ps.
 * Copyright (c) 1988-1993 Miguel Santana
 * Copyright (c) 1995-1999 Akim Demaille, Miguel Santana
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

/************************************************************************/
/*									*/
/*			I n c l u d e   f i l e s			*/
/*                                                                      */
/************************************************************************/
#include "a2ps.h"
#include "routines.h"
#include "message.h"
#include "media.h"
#include "jobs.h"
#include "getshline.h"
#include "pathwalk.h"
#include "confg.h"
#include "useropt.h"
#include "path-concat.h"
#include "printers.h"
#include "options.h"
#include "metaseq.h"
#include "quotearg.h"
#include "dirname.h"

extern char *program_name;

/*
 * Hooks used
 */
config_hook delegation_hook = NULL;
config_hook toc_entry_hook = NULL;

enum keyword_e
{
  AppendLibraryPath,
  DefaultPPD,
  DefaultPrinter,
  Delegation,
  FileCommand,
  Include,
  LibraryPath,
  Medium,
  Obsolete,
  Options,
  OutputFirstLine,
  PageLabelFormat,
  PrependLibraryPath,
  Printer,
  UnknownPrinter,
  UserOption,
  Variable
};

struct keyword_s
{
  const char *name;
  enum keyword_e code;
  /* Number of arguments. */
  int argc;
  /* If true, the last argument composed of the rest of the line,
     otherwise separated by spaces. */
  bool line_token;
};

#define TOTAL_KEYWORDS 21
#define MIN_WORD_LENGTH 6
#define MAX_WORD_LENGTH 19
#define MIN_HASH_VALUE 6
#define MAX_HASH_VALUE 36
/* maximum key range = 31, duplicates = 2 */

#ifdef __GNUC__
__inline
#endif
static unsigned int
hash (register const char *str, register unsigned int len)
{
  static unsigned char asso_values[] =
    {
      37, 37, 37, 37, 37, 37, 37, 37, 37, 37,
      37, 37, 37, 37, 37, 37, 37, 37, 37, 37,
      37, 37, 37, 37, 37, 37, 37, 37, 37, 37,
      37, 37, 37, 37, 37, 37, 37, 37, 37, 37,
      37, 37, 37, 37, 37, 37, 37, 37, 37, 37,
      37, 37, 37, 37, 37, 37, 37, 37,  0, 37,
      37, 37, 37, 37, 37,  5, 37, 37,  0, 37,
       5, 37, 37,  5, 37, 37, 10,  0, 37, 20,
       0, 37, 37, 37,  5, 10,  0, 37, 37, 37,
      37, 37, 37, 37, 37, 37, 37, 37, 37, 37,
      37, 37, 37, 37, 37, 37, 37, 37, 37, 37,
      37, 37, 37, 37, 37, 37, 37, 37, 37, 37,
      37, 37, 37, 37, 37, 37, 37, 37, 37, 37,
      37, 37, 37, 37, 37, 37, 37, 37, 37, 37,
      37, 37, 37, 37, 37, 37, 37, 37, 37, 37,
      37, 37, 37, 37, 37, 37, 37, 37, 37, 37,
      37, 37, 37, 37, 37, 37, 37, 37, 37, 37,
      37, 37, 37, 37, 37, 37, 37, 37, 37, 37,
      37, 37, 37, 37, 37, 37, 37, 37, 37, 37,
      37, 37, 37, 37, 37, 37, 37, 37, 37, 37,
      37, 37, 37, 37, 37, 37, 37, 37, 37, 37,
      37, 37, 37, 37, 37, 37, 37, 37, 37, 37,
      37, 37, 37, 37, 37, 37, 37, 37, 37, 37,
      37, 37, 37, 37, 37, 37, 37, 37, 37, 37,
      37, 37, 37, 37, 37, 37, 37, 37, 37, 37,
      37, 37, 37, 37, 37, 37
    };
  return len + asso_values[(unsigned char)str[len - 1]] + asso_values[(unsigned char)str[0]];
}

#ifdef __GNUC__
__inline
#endif
struct keyword_s *
in_word_set (register const char *str, register unsigned int len)
{
  static struct keyword_s wordlist[] =
    {
      {"Media:",			Medium, 		2, true},
      {"Medium:",		Medium, 		2, true},
      {"Pattern:",		Obsolete, 		1, true},
      {"Printer:",		Printer, 		2, true},
      {"Variable:",		Variable,		2, true},
      {"DefaultPPD:",		DefaultPPD,		1, false},
      {"Delegation:",		Delegation, 		1, true},
      {"PassThrough:",		Obsolete, 		1, true},
      {"Include:",		Include,		1, false},
      {"DefaultPrinter:",	DefaultPrinter,		1, true},
      {"PageLabelFormat:",	PageLabelFormat, 	1, true},
      {"FileCommand:",		FileCommand, 		1, true},
      {"MacroMetaSequence:",	Variable, 		2, true},
      {"PrependLibraryPath:",	PrependLibraryPath,	1, true},
      {"UserOption:",		UserOption, 		2, true},
      {"LibraryPath:",		LibraryPath, 		1, false},
      {"AppendLibraryPath:",	AppendLibraryPath, 	1, true},
      {"TemporaryDirectory:",	Obsolete,		1, true},
      {"UnknownPrinter:",	UnknownPrinter,		1, true},
      {"Options:",		Options, 		1, true},
      {"OutputFirstLine:",	OutputFirstLine, 	1, true}
    };

  static short lookup[] =
    {
       -1,  -1,  -1,  -1,  -1,  -1,   0,   1, -51,   4,
       -1, -48,   7,   8,  -1,   9,  10,  11,  12,  13,
       -1,  14,  15,  16,  17,  18, -16,  -2,  19, -19,
       -2,  -1,  -1,  -1,  -1,  -1,  20
    };

  if (len <= MAX_WORD_LENGTH && len >= MIN_WORD_LENGTH)
    {
      register int key = hash (str, len);

      if (key <= MAX_HASH_VALUE && key >= 0)
        {
          register int index = lookup[key];

          if (index >= 0)
            {
              register const char *s = wordlist[index].name;

              if (*str == *s && !strcmp (str + 1, s + 1))
                return &wordlist[index];
            }
          else if (index < -TOTAL_KEYWORDS)
            {
              register int offset = - 1 - TOTAL_KEYWORDS - index;
              register struct keyword_s *wordptr = &wordlist[TOTAL_KEYWORDS + lookup[offset]];
              register struct keyword_s *wordendptr = wordptr + -lookup[offset + 1];

              while (wordptr < wordendptr)
                {
                  register const char *s = wordptr->name;

                  if (*str == *s && !strcmp (str + 1, s + 1))
                    return wordptr;
                  wordptr++;
                }
            }
        }
    }
  return 0;
}
/*
 * Read the configuration file
 */
int
a2_read_config (a2ps_job * job, const char *path, const char *file)
{
/* The maximum number of args for an entry. */
#define MAX_ARGC 10
  FILE *fp;
  char * fname;
  char *buf = NULL;
  size_t bufsiz = 0;
  int firstline = 0, lastline = 0;

  fname = xpath_concat (path, file, NULL);

  fp = fopen (fname, "r");
  if (fp == NULL)
    {
      free (fname);
      return 0;
    }

  message (msg_opt | msg_file,
	   (stderr, "Reading configuration file `%s'\n", fname));

  while (getshline_numbered (&firstline, &lastline, &buf, &bufsiz, fp) != -1)
    {
      struct keyword_s *keyword;
      /* An array of the arguments.  The first argument ARGV[0] is the
	 name of the entry, eg 'Options:'. */
      int argc;
      char *argv [MAX_ARGC];

      argv[0] = strtok (buf, " \t\n");

      /* Blank line, but not empty */
      if (!argv[0])
	continue;

      keyword = in_word_set (argv[0], strlen (argv[0]));
      if (!keyword)
	error_at_line (1, 0, fname, firstline,
		       _("invalid option `%s'"), quotearg (argv[0]));

      /* Fetch the arguments */
      for (argc = 1 ; argc <= keyword->argc ; argc++)
	{
	  if (keyword->line_token && argc == keyword->argc)
	    argv [argc] = strtok (NULL, "\n");
	  else
	    argv [argc] = strtok (NULL, " \t\n");
	  if (argv [argc] == NULL)
	    error_at_line (1, 0, fname, firstline,
			   _("missing argument for `%s'"), quotearg (argv[0]));
	}
      /* Check that there is no extra argument. */
      if (strtok (NULL, "\n"))
	error_at_line (1, 0, fname, firstline,
		       "extra argument for `%s'", quotearg (argv[0]));

      /* Process the entry. */
      switch (keyword->code)
	{
	case Include:	/* At this point, read another config file. */
	  {
	    char * dir;
	    if (*argv[1] == DIRECTORY_SEPARATOR)
	      /* Path is absolute */
	      dir = NULL;
	    else
	      /* Relative.  Give its root. */
	      dir = dir_name (fname);

	    if (!a2_read_config (job, dir, argv[1]))
	      {
		char *included_file = xpath_concat (dir, argv[1], NULL);
		error_at_line (0, errno, fname, firstline,
			       _("cannot open file `%s'"),
			       quotearg (included_file));
		free (included_file);
	      }
	    XFREE (dir);
	  }
	  break;

	case Options:
	  {
	    /* Set PROGRAM_NAME so that the error messages report the
               file name and line. */
	    char *old_program_name = program_name;
	    program_name = ALLOCA (char,
				   strlen (program_name)
				   + strlen (fname)
				   + strlen ("%:%:999990"));
	    sprintf (program_name, "%s:%s:%d",
		     old_program_name, fname, firstline);
	    a2ps_handle_string_options (job, argv[1]);
	    program_name = old_program_name;
	  }
	  break;

	case DefaultPPD:      /* Default PPD file */
          a2ps_printers_default_ppdkey_set (job->printers, argv[1]);
	  break;

      /* Handling of the printers */
	case Printer:
	  if (!a2ps_printers_add (job->printers, argv[1], argv[2]))
	    error_at_line (1, 0, fname, firstline,
			   _("invalid definition for printer `%s': %s"),
			   argv[1], quotearg (argv[2]));
	  break;

	case UnknownPrinter:
	  if (!a2ps_printers_add (job->printers, _("Unknown Printer"), argv[1]))
	    error_at_line (1, 0, fname, firstline,
			   _("invalid definition for printer `%s': %s"),
			   _("Unknown Printer"), quotearg (argv[1]));
	  break;

	case DefaultPrinter:
	  if (!a2ps_printers_add (job->printers, _("Default Printer"), argv[1]))
	    error_at_line (1, 0, fname, firstline,
			   _("invalid definition for printer `%s': %s"),
			   _("Default Printer"), quotearg (argv[1]));
	  break;

	case Delegation:
	  /* This is only for a2ps the program.  Read this only if
	   there's a reader */
	  if (delegation_hook)
	    (*delegation_hook) (fname, firstline, argv[1]);
	  break;

	case UserOption:
	  user_option_add (job, argv[1], argv[2]);
	  break;

	case OutputFirstLine:
	  xustrcpy (job->status->magic_number, argv[1]);
	  break;

	case PageLabelFormat:
	  xustrcpy (job->status->page_label_format, argv[1]);
	  break;

	case Medium:
	  {
	    int w, h, llx, lly, urx, ury;

	    switch (sscanf (argv[2], "%d %d %d %d %d %d",
			    &w, &h, &llx, &lly, &urx, &ury))
	      {
	      case 6:
		/* BBox is also given */
		break;

	      case 2:
		/* A short hand has been used: use 24 points as a
		  margin all around */
		llx = lly = 24;
		urx = w - 24;
		ury = h - 24;
		break;

	      default:
		error_at_line (1, 0, fname, firstline,
			       "invalid number of arguments for `%s'",
			       quotearg (argv[0]));
	      }
	    add_medium (job, argv[1], w, h, llx, lly, urx, ury);
	  }
	  break;

	case Variable:
	  if (!macro_meta_sequence_add (job, argv[1], argv[2]))
	    error_at_line (1, 0, fname, firstline,
			   _("invalid variable identifier `%s'"),
			   quotearg (argv[1]));
	  break;

	  /* Handling of the library path */
	case LibraryPath:
	  XFREE (job->common.path);
	  job->common.path = pw_string_to_path (argv[1]);
	  break;

	case AppendLibraryPath:
	  job->common.path = pw_append_string_to_path (job->common.path,
						       argv[1]);
	  break;

	case PrependLibraryPath:
	  job->common.path = pw_prepend_string_to_path (job->common.path,
							argv[1]);
	  break;

	case FileCommand:	/* How to call file */
	  xstrcpy (job->file_command, argv[1]);
	  break;

	case Obsolete:
	  /* TRANS: The following message says that in a2ps.cfg there
	     is an entry (such as `Pattern:', or `PassThrough:') which
	     is no longer used. */
	  error_at_line (0, 0, fname, firstline,
			 _("obsolete `%s' entry.  Ignored"), argv[0]);
	  break;
	}
    }
  XFREE (fname);
  fclose (fp);
  /* BUF was allocated by getshlinenumbered. */
  free (buf);
  return 1;
}

/* Global config.
 *    This is really not an easy thing because, people may want
 *    to check the package before the installation.  The worst
 *    case is when an older a2ps is yet installed.  So we _must_
 *    have a special way to deal with the tests.  This is why
 *    I introduced an env-var: A2PS_CONFIG, which
 *    points to a2ps.cfg.
 *    Note that it also improves the robustness of `make distcheck'.
 */
void
a2_read_sys_config (a2ps_job * job)
{
  const char *config_file;

  config_file = getenv ("A2PS_CONFIG");
  if (!config_file)
    config_file = SYSCONFFILE;

  /* I see no reason to end a2ps here if the file is not found: other
     files follow.  Just say it.  */
  if (a2_read_config (job, NULL, config_file))
    return;
  error (0, errno,
	 _("cannot open file `%s'"), quotearg (config_file));
}
