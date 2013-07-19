
/*  A Bison parser, made from parsessh.y
    by GNU Bison version 1.28  */

#define YYBISON 1  /* Identify Bison output.  */

#define	tSTYLE	257
#define	tIS	258
#define	tEND	259
#define	tKEYWORDS	260
#define	tARE	261
#define	tIN	262
#define	tOPERATORS	263
#define	tSEQUENCES	264
#define	tFIRST	265
#define	tSECOND	266
#define	tALPHABET	267
#define	tALPHABETS	268
#define	tDOCUMENTATION	269
#define	tEXCEPTIONS	270
#define	tCASE	271
#define	tCSTRING	272
#define	tCCHAR	273
#define	tOPTIONAL	274
#define	tCLOSERS	275
#define	tWRITTEN	276
#define	tBY	277
#define	tVERSION	278
#define	tREQUIRES	279
#define	tA2PS	280
#define	tANCESTORS	281
#define	tFACE	282
#define	tFFLAGS	283
#define	tSTRING	284
#define	tLATEXSYMBOL	285
#define	tREGEX	286
#define	tSENSITIVENESS	287
#define	tBACK_REF	288

#line 1 "parsessh.y"
 /* -*- c -*- */
/*
 * Grammar for parsing the style sheets
 *
 * Copyright (c) 1988-1993 Miguel Santana
 * Copyright (c) 1995-1999 Akim Demaille, Miguel Santana
 *
 */

/*
 * This file is part of a2ps
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
 * $Id: parsessh.y,v 1.71 1998/03/04 17:27:51 demaille Exp $
 */

#include "a2ps.h"
#include "jobs.h"
#include "ffaces.h"
#include "ssheet.h"
#include "message.h"
#include "routines.h"
#include "yy2ssh.h"
#include "regex.h"

#define YYDEBUG 1
#define YYERROR_VERBOSE 1
#define YYPRINT(file, type, value)   yyprint (file, type, value)

/* We need to use the same `const' as bison, to avoid the following
   prototypes to diverge from the function declarations */
#undef const
#ifndef __cplusplus
# ifndef __STDC__
#  define const
# endif
#endif

/* Comes from the parser */
extern int sshlineno;

/* Comes from the caller */
extern FILE * sshin;
extern struct a2ps_job * job;
extern const char * sshfilename;

/* Local prototypes */
void yyerror PARAMS ((const char *msg));
static void yyprint ();

/* Initilizes the obstacks */
void sshlex_initialize PARAMS ((void));

/* Comes from main.c */
extern int highlight_level;

int yylex PARAMS ((void));
struct style_sheet * parse_style_sheet PARAMS ((const char * filename));

/* Defines the style sheet being loaded */
static struct style_sheet * parsed_style_sheet = NULL;


#line 80 "parsessh.y"
typedef union
{
  int integer;
  uchar * string;
  struct pattern * pattern;
  struct style_sheet * sheet;
  struct rule * rule;
  struct sequence * sequence;
  struct darray * array;
  struct words * words;
  struct faced_string * faced_string;
  enum face_e face;			/* Face			*/
  enum fflag_e fflags;			/* Flags for faces	*/
  struct fface_s fface;			/* Flagged face		*/
  enum case_sensitiveness sensitiveness;
} YYSTYPE;
#include <stdio.h>

#ifndef __cplusplus
#ifndef __STDC__
#define const
#endif
#endif



#define	YYFINAL		200
#define	YYFLAG		-32768
#define	YYNTBASE	39

#define YYTRANSLATE(x) ((unsigned)(x) <= 288 ? yytranslate[x] : 68)

static const char yytranslate[] = {     0,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,    36,
    37,     2,    38,    35,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
     2,     2,     2,     2,     2,     1,     3,     4,     5,     6,
     7,     8,     9,    10,    11,    12,    13,    14,    15,    16,
    17,    18,    19,    20,    21,    22,    23,    24,    25,    26,
    27,    28,    29,    30,    31,    32,    33,    34
};

#if YYDEBUG != 0
static const short yyprhs[] = {     0,
     0,     2,     9,    10,    16,    21,    27,    32,    36,    39,
    42,    47,    53,    59,    62,    65,    68,    71,    74,    78,
    83,    89,    91,    94,    98,   102,   105,   111,   113,   117,
   120,   122,   125,   127,   130,   132,   134,   137,   139,   141,
   143,   147,   149,   151,   155,   157,   159,   163,   167,   170,
   172,   177,   183,   187,   189,   191,   195,   199,   202,   204,
   209,   215,   219,   221,   223,   227,   231,   234,   236,   241,
   247,   249,   253,   259,   266,   272,   278,   283,   290,   296,
   302,   307,   315,   323,   325,   327,   328,   330,   332,   336,
   337
};

static const short yyrhs[] = {    40,
     0,     3,    30,     4,    41,     5,     3,     0,     0,    41,
    20,     6,    57,     6,     0,    41,     6,    57,     6,     0,
    41,    20,     9,    60,     9,     0,    41,     9,    60,     9,
     0,    41,    20,    63,     0,    41,    63,     0,    41,    47,
     0,    41,    14,     7,    30,     0,    41,    11,    13,     4,
    30,     0,    41,    12,    13,     4,    30,     0,    41,    49,
     0,    41,    43,     0,    41,    45,     0,    41,    46,     0,
    41,    42,     0,    25,    26,    30,     0,    25,    26,    24,
    30,     0,    15,     4,    44,     5,    15,     0,    30,     0,
    44,    30,     0,    22,    23,    30,     0,    24,     4,    30,
     0,    24,    30,     0,    27,     7,    48,     5,    27,     0,
    30,     0,    48,    35,    30,     0,    17,    33,     0,    32,
     0,    50,    32,     0,    52,     0,    30,    54,     0,    30,
     0,    54,     0,    34,    54,     0,    34,     0,    31,     0,
    52,     0,    53,    35,    52,     0,    28,     0,    29,     0,
    36,    55,    37,     0,    28,     0,    29,     0,    55,    38,
    28,     0,    55,    38,    29,     0,    30,    51,     0,    30,
     0,    36,    30,    53,    37,     0,     8,    54,     7,    58,
     5,     0,     7,    58,     5,     0,    56,     0,    59,     0,
    58,    35,    56,     0,    58,    35,    59,     0,    50,    51,
     0,    50,     0,    36,    50,    53,    37,     0,     8,    54,
     7,    61,     5,     0,     7,    61,     5,     0,    56,     0,
    62,     0,    61,    35,    56,     0,    61,    35,    62,     0,
    50,    51,     0,    50,     0,    36,    50,    53,    37,     0,
    10,     7,    64,     5,    10,     0,    65,     0,    64,    35,
    65,     0,    30,    31,    54,    66,    67,     0,    30,    30,
    54,    54,    66,    67,     0,    30,    54,    54,    66,    67,
     0,    30,    30,    54,    66,    67,     0,    30,    54,    66,
    67,     0,    50,    30,    54,    54,    66,    67,     0,    50,
    54,    54,    66,    67,     0,    50,    30,    54,    66,    67,
     0,    50,    54,    66,    67,     0,    36,    30,    53,    37,
    54,    66,    67,     0,    36,    50,    53,    37,    54,    66,
    67,     0,    18,     0,    19,     0,     0,    56,     0,    62,
     0,    21,    60,    21,     0,     0,    16,    60,    16,     0
};

#endif

#if YYDEBUG != 0
static const short yyrline[] = { 0,
   128,   135,   144,   148,   157,   163,   172,   178,   186,   191,
   196,   204,   211,   218,   221,   224,   227,   230,   244,   246,
   248,   251,   252,   267,   269,   271,   276,   283,   291,   298,
   305,   310,   321,   329,   334,   338,   342,   346,   350,   356,
   362,   373,   379,   386,   395,   401,   406,   412,   426,   431,
   437,   449,   453,   459,   465,   470,   475,   486,   492,   499,
   509,   513,   519,   526,   532,   537,   548,   554,   560,   570,
   573,   579,   598,   610,   618,   626,   634,   642,   650,   658,
   666,   674,   681,   689,   693,   699,   709,   715,   721,   728,
   733
};
#endif


#if YYDEBUG != 0 || defined (YYERROR_VERBOSE)

static const char * const yytname[] = {   "$","error","$undefined.","tSTYLE",
"tIS","tEND","tKEYWORDS","tARE","tIN","tOPERATORS","tSEQUENCES","tFIRST","tSECOND",
"tALPHABET","tALPHABETS","tDOCUMENTATION","tEXCEPTIONS","tCASE","tCSTRING","tCCHAR",
"tOPTIONAL","tCLOSERS","tWRITTEN","tBY","tVERSION","tREQUIRES","tA2PS","tANCESTORS",
"tFACE","tFFLAGS","tSTRING","tLATEXSYMBOL","tREGEX","tSENSITIVENESS","tBACK_REF",
"','","'('","')'","'+'","file","style_sheet","definition_list","requirement",
"documentation","long_string","authors","version","ancestors_def","ancestors_list",
"case_def","regex","rhs","a_rhs","rhs_list","fface","fface_sxp","rule","keywords_def",
"keywords_rule_list","keyword_regex","operators_def","operators_rule_list","operator_regex",
"sequence_def","sequence_list","sequence","closers_opt","exception_def_opt", NULL
};
#endif

static const short yyr1[] = {     0,
    39,    40,    41,    41,    41,    41,    41,    41,    41,    41,
    41,    41,    41,    41,    41,    41,    41,    41,    42,    42,
    43,    44,    44,    45,    46,    46,    47,    48,    48,    49,
    50,    50,    51,    52,    52,    52,    52,    52,    52,    53,
    53,    54,    54,    54,    55,    55,    55,    55,    56,    56,
    56,    57,    57,    58,    58,    58,    58,    59,    59,    59,
    60,    60,    61,    61,    61,    61,    62,    62,    62,    63,
    64,    64,    65,    65,    65,    65,    65,    65,    65,    65,
    65,    65,    65,    65,    65,    66,    66,    66,    66,    67,
    67
};

static const short yyr2[] = {     0,
     1,     6,     0,     5,     4,     5,     4,     3,     2,     2,
     4,     5,     5,     2,     2,     2,     2,     2,     3,     4,
     5,     1,     2,     3,     3,     2,     5,     1,     3,     2,
     1,     2,     1,     2,     1,     1,     2,     1,     1,     1,
     3,     1,     1,     3,     1,     1,     3,     3,     2,     1,
     4,     5,     3,     1,     1,     3,     3,     2,     1,     4,
     5,     3,     1,     1,     3,     3,     2,     1,     4,     5,
     1,     3,     5,     6,     5,     5,     4,     6,     5,     5,
     4,     7,     7,     1,     1,     0,     1,     1,     3,     0,
     3
};

static const short yydefact[] = {     0,
     0,     1,     0,     3,     0,     0,     0,     0,     0,     0,
     0,     0,     0,     0,     0,     0,     0,     0,     0,    18,
    15,    16,    17,    10,    14,     9,     2,     0,     0,     0,
     0,     0,     0,     0,     0,     0,     0,     0,    30,     0,
     0,     8,     0,     0,    26,     0,     0,    50,    31,     0,
    59,    54,     0,    55,    42,    43,     0,     0,     5,     0,
    68,    63,     0,    64,     0,     7,    84,    85,     0,     0,
     0,     0,    71,     0,     0,    11,    22,     0,     0,     0,
    24,    25,     0,    19,    28,     0,    35,    39,    38,    49,
    33,    36,     0,     0,    32,    58,    53,     0,    45,    46,
     0,     0,     0,    67,    62,     0,     0,     0,     0,    86,
     0,     0,     0,    86,     0,     0,    12,    13,     0,    23,
     4,     6,    20,     0,     0,    34,    37,    40,     0,     0,
    56,    57,    44,     0,     0,     0,    65,    66,     0,    86,
    86,     0,     0,    86,    87,    88,    90,     0,     0,    86,
    86,    90,    70,    72,    21,    27,    29,     0,    51,    60,
    47,    48,    52,    69,    61,    86,    90,    90,     0,    90,
     0,    77,     0,     0,    86,    90,    90,    81,    41,    90,
    76,    73,    89,    75,     0,    86,    86,    90,    80,    79,
    74,    91,    90,    90,    78,    82,    83,     0,     0,     0
};

static const short yydefgoto[] = {   198,
     2,     5,    20,    21,    78,    22,    23,    24,    86,    25,
    61,    90,   128,   129,    92,   101,   145,    30,    53,    54,
    33,    63,   146,    26,    72,    73,   147,   172
};

static const short yypact[] = {    11,
    -2,-32768,    27,-32768,    98,    40,   126,   183,    56,    62,
    65,    66,    78,    36,   175,    72,     7,    74,    99,-32768,
-32768,-32768,-32768,-32768,-32768,-32768,-32768,    69,    60,   110,
    94,    60,   133,    35,   131,   134,   116,   140,-32768,   126,
   183,-32768,   167,   168,-32768,     8,   169,   129,-32768,    18,
   120,-32768,     1,-32768,-32768,-32768,   154,   189,-32768,    18,
   120,-32768,     4,-32768,   193,-32768,-32768,-32768,   138,    34,
   143,    10,-32768,   171,   172,-32768,-32768,     5,   197,   195,
-32768,-32768,   176,-32768,-32768,    14,    60,-32768,    60,-32768,
-32768,-32768,   129,   120,-32768,-32768,-32768,    69,-32768,-32768,
   155,    69,   120,-32768,-32768,    94,    94,    60,    60,   111,
   129,   120,    60,   111,   198,    35,-32768,-32768,   146,-32768,
-32768,-32768,-32768,   178,   177,-32768,-32768,-32768,    92,   118,
-32768,-32768,-32768,   166,    21,   127,-32768,-32768,    22,   111,
    38,   183,   148,    38,-32768,-32768,   194,   151,   152,   111,
    38,   194,-32768,-32768,-32768,-32768,-32768,   129,-32768,-32768,
-32768,-32768,-32768,-32768,-32768,    38,   194,   194,   188,   194,
   183,-32768,    60,    60,    38,   194,   194,-32768,-32768,   194,
-32768,-32768,-32768,-32768,   196,    38,    38,   194,-32768,-32768,
-32768,-32768,   194,   194,-32768,-32768,-32768,   211,   213,-32768
};

static const short yypgoto[] = {-32768,
-32768,-32768,-32768,-32768,-32768,-32768,-32768,-32768,-32768,-32768,
   -26,   -39,   -44,    25,   -29,-32768,   -15,   174,   113,   119,
   -40,   109,   -13,   203,-32768,   103,   -89,  -147
};


#define	YYLAST		219


static const short yytable[] = {    58,
    80,    51,    65,    91,   178,    97,    91,    71,   105,   119,
    44,    96,    52,     1,   115,    62,    91,    64,   124,   181,
   182,   104,   184,    94,   152,   163,   165,     3,   189,   190,
     4,    83,   191,   103,   120,    98,    45,    84,   106,   110,
   195,   114,    27,   112,   116,   196,   197,    93,   125,    49,
   167,   168,    67,    68,   170,    98,   106,   126,   142,   127,
   176,   177,    34,   111,    69,    49,    49,    48,    39,    49,
    70,    51,    37,    60,    35,    51,   180,    36,   140,   141,
   144,    38,   131,   150,   151,   188,    52,    55,    56,    71,
   137,    62,   138,    64,    43,    57,   193,   194,    48,    46,
    49,   169,     6,     7,    50,    47,     8,     9,    10,    11,
   166,    12,    13,   179,    14,    59,   103,    15,   130,    16,
   175,    17,    18,    48,    19,    49,   158,   136,   159,    60,
   185,   142,    28,    29,    74,   148,   149,    75,    55,    56,
    48,    66,    49,   186,   187,    76,   143,    55,    56,    87,
    88,    95,   158,    89,   160,    57,    55,    56,    87,    88,
   155,   158,    89,   164,    57,    55,    56,   108,   109,    77,
    55,    56,   113,    57,    95,    99,   100,    93,    57,    49,
    40,    99,   100,    41,     9,   158,   158,   173,   174,    31,
    32,   133,   134,   161,   162,   102,    81,    82,    85,   107,
   117,   118,   121,   122,   156,   123,   157,   153,   183,   171,
   199,   192,   200,    79,   135,   139,   132,    42,   154
};

static const short yycheck[] = {    29,
    41,    28,    32,    48,   152,     5,    51,    34,     5,     5,
     4,    51,    28,     3,     5,    31,    61,    31,     5,   167,
   168,    61,   170,    50,   114,     5,     5,    30,   176,   177,
     4,    24,   180,    60,    30,    35,    30,    30,    35,    69,
   188,    71,     3,    70,    35,   193,   194,    30,    35,    32,
   140,   141,    18,    19,   144,    35,    35,    87,    21,    89,
   150,   151,     7,    30,    30,    32,    32,    30,    33,    32,
    36,    98,     7,    36,    13,   102,   166,    13,   108,   109,
   110,     4,    98,   113,   114,   175,   102,    28,    29,   116,
   106,   107,   106,   107,    23,    36,   186,   187,    30,    26,
    32,   142,     5,     6,    36,     7,     9,    10,    11,    12,
   140,    14,    15,   158,    17,     6,   143,    20,    94,    22,
   150,    24,    25,    30,    27,    32,    35,   103,    37,    36,
   171,    21,     7,     8,     4,   111,   112,     4,    28,    29,
    30,     9,    32,   173,   174,    30,    36,    28,    29,    30,
    31,    32,    35,    34,    37,    36,    28,    29,    30,    31,
    15,    35,    34,    37,    36,    28,    29,    30,    31,    30,
    28,    29,    30,    36,    32,    28,    29,    30,    36,    32,
     6,    28,    29,     9,    10,    35,    35,    37,    37,     7,
     8,    37,    38,    28,    29,     7,    30,    30,    30,     7,
    30,    30,     6,     9,    27,    30,    30,    10,    21,    16,
     0,    16,     0,    40,   102,   107,    98,    15,   116
};
/* -*-C-*-  Note some compilers choke on comments on `#line' lines.  */
#line 3 "/emx/share/bison.simple"
/* This file comes from bison-1.28.  */

/* Skeleton output parser for bison,
   Copyright (C) 1984, 1989, 1990 Free Software Foundation, Inc.

   This program is free software; you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 2, or (at your option)
   any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program; if not, write to the Free Software
   Foundation, Inc., 59 Temple Place - Suite 330,
   Boston, MA 02111-1307, USA.  */

/* As a special exception, when this file is copied by Bison into a
   Bison output file, you may use that output file without restriction.
   This special exception was added by the Free Software Foundation
   in version 1.24 of Bison.  */

/* This is the parser code that is written into each bison parser
  when the %semantic_parser declaration is not specified in the grammar.
  It was written by Richard Stallman by simplifying the hairy parser
  used when %semantic_parser is specified.  */

#ifndef YYSTACK_USE_ALLOCA
#ifdef alloca
#define YYSTACK_USE_ALLOCA
#else /* alloca not defined */
#ifdef __GNUC__
#define YYSTACK_USE_ALLOCA
#define alloca __builtin_alloca
#else /* not GNU C.  */
#if (!defined (__STDC__) && defined (sparc)) || defined (__sparc__) || defined (__sparc) || defined (__sgi) || (defined (__sun) && defined (__i386))
#define YYSTACK_USE_ALLOCA
#include <alloca.h>
#else /* not sparc */
/* We think this test detects Watcom and Microsoft C.  */
/* This used to test MSDOS, but that is a bad idea
   since that symbol is in the user namespace.  */
#if (defined (_MSDOS) || defined (_MSDOS_)) && !defined (__TURBOC__)
#if 0 /* No need for malloc.h, which pollutes the namespace;
	 instead, just don't use alloca.  */
#include <malloc.h>
#endif
#else /* not MSDOS, or __TURBOC__ */
#if defined(_AIX)
/* I don't know what this was needed for, but it pollutes the namespace.
   So I turned it off.   rms, 2 May 1997.  */
/* #include <malloc.h>  */
 #pragma alloca
#define YYSTACK_USE_ALLOCA
#else /* not MSDOS, or __TURBOC__, or _AIX */
#if 0
#ifdef __hpux /* haible@ilog.fr says this works for HPUX 9.05 and up,
		 and on HPUX 10.  Eventually we can turn this on.  */
#define YYSTACK_USE_ALLOCA
#define alloca __builtin_alloca
#endif /* __hpux */
#endif
#endif /* not _AIX */
#endif /* not MSDOS, or __TURBOC__ */
#endif /* not sparc */
#endif /* not GNU C */
#endif /* alloca not defined */
#endif /* YYSTACK_USE_ALLOCA not defined */

#ifdef YYSTACK_USE_ALLOCA
#define YYSTACK_ALLOC alloca
#else
#define YYSTACK_ALLOC malloc
#endif

/* Note: there must be only one dollar sign in this file.
   It is replaced by the list of actions, each action
   as one case of the switch.  */

#define yyerrok		(yyerrstatus = 0)
#define yyclearin	(yychar = YYEMPTY)
#define YYEMPTY		-2
#define YYEOF		0
#define YYACCEPT	goto yyacceptlab
#define YYABORT 	goto yyabortlab
#define YYERROR		goto yyerrlab1
/* Like YYERROR except do call yyerror.
   This remains here temporarily to ease the
   transition to the new meaning of YYERROR, for GCC.
   Once GCC version 2 has supplanted version 1, this can go.  */
#define YYFAIL		goto yyerrlab
#define YYRECOVERING()  (!!yyerrstatus)
#define YYBACKUP(token, value) \
do								\
  if (yychar == YYEMPTY && yylen == 1)				\
    { yychar = (token), yylval = (value);			\
      yychar1 = YYTRANSLATE (yychar);				\
      YYPOPSTACK;						\
      goto yybackup;						\
    }								\
  else								\
    { yyerror ("syntax error: cannot back up"); YYERROR; }	\
while (0)

#define YYTERROR	1
#define YYERRCODE	256

#ifndef YYPURE
#define YYLEX		yylex()
#endif

#ifdef YYPURE
#ifdef YYLSP_NEEDED
#ifdef YYLEX_PARAM
#define YYLEX		yylex(&yylval, &yylloc, YYLEX_PARAM)
#else
#define YYLEX		yylex(&yylval, &yylloc)
#endif
#else /* not YYLSP_NEEDED */
#ifdef YYLEX_PARAM
#define YYLEX		yylex(&yylval, YYLEX_PARAM)
#else
#define YYLEX		yylex(&yylval)
#endif
#endif /* not YYLSP_NEEDED */
#endif

/* If nonreentrant, generate the variables here */

#ifndef YYPURE

int	yychar;			/*  the lookahead symbol		*/
YYSTYPE	yylval;			/*  the semantic value of the		*/
				/*  lookahead symbol			*/

#ifdef YYLSP_NEEDED
YYLTYPE yylloc;			/*  location data for the lookahead	*/
				/*  symbol				*/
#endif

int yynerrs;			/*  number of parse errors so far       */
#endif  /* not YYPURE */

#if YYDEBUG != 0
int yydebug;			/*  nonzero means print parse trace	*/
/* Since this is uninitialized, it does not stop multiple parsers
   from coexisting.  */
#endif

/*  YYINITDEPTH indicates the initial size of the parser's stacks	*/

#ifndef	YYINITDEPTH
#define YYINITDEPTH 200
#endif

/*  YYMAXDEPTH is the maximum size the stacks can grow to
    (effective only if the built-in stack extension method is used).  */

#if YYMAXDEPTH == 0
#undef YYMAXDEPTH
#endif

#ifndef YYMAXDEPTH
#define YYMAXDEPTH 10000
#endif

/* Define __yy_memcpy.  Note that the size argument
   should be passed with type unsigned int, because that is what the non-GCC
   definitions require.  With GCC, __builtin_memcpy takes an arg
   of type size_t, but it can handle unsigned int.  */

#if __GNUC__ > 1		/* GNU C and GNU C++ define this.  */
#define __yy_memcpy(TO,FROM,COUNT)	__builtin_memcpy(TO,FROM,COUNT)
#else				/* not GNU C or C++ */
#ifndef __cplusplus

/* This is the most reliable way to avoid incompatibilities
   in available built-in functions on various systems.  */
static void
__yy_memcpy (to, from, count)
     char *to;
     char *from;
     unsigned int count;
{
  register char *f = from;
  register char *t = to;
  register int i = count;

  while (i-- > 0)
    *t++ = *f++;
}

#else /* __cplusplus */

/* This is the most reliable way to avoid incompatibilities
   in available built-in functions on various systems.  */
static void
__yy_memcpy (char *to, char *from, unsigned int count)
{
  register char *t = to;
  register char *f = from;
  register int i = count;

  while (i-- > 0)
    *t++ = *f++;
}

#endif
#endif

#line 217 "/emx/share/bison.simple"

/* The user can define YYPARSE_PARAM as the name of an argument to be passed
   into yyparse.  The argument should have type void *.
   It should actually point to an object.
   Grammar actions can access the variable by casting it
   to the proper pointer type.  */

#ifdef YYPARSE_PARAM
#ifdef __cplusplus
#define YYPARSE_PARAM_ARG void *YYPARSE_PARAM
#define YYPARSE_PARAM_DECL
#else /* not __cplusplus */
#define YYPARSE_PARAM_ARG YYPARSE_PARAM
#define YYPARSE_PARAM_DECL void *YYPARSE_PARAM;
#endif /* not __cplusplus */
#else /* not YYPARSE_PARAM */
#define YYPARSE_PARAM_ARG
#define YYPARSE_PARAM_DECL
#endif /* not YYPARSE_PARAM */

/* Prevent warning if -Wstrict-prototypes.  */
#ifdef __GNUC__
#ifdef YYPARSE_PARAM
int yyparse (void *);
#else
int yyparse (void);
#endif
#endif

int
yyparse(YYPARSE_PARAM_ARG)
     YYPARSE_PARAM_DECL
{
  register int yystate;
  register int yyn;
  register short *yyssp;
  register YYSTYPE *yyvsp;
  int yyerrstatus;	/*  number of tokens to shift before error messages enabled */
  int yychar1 = 0;		/*  lookahead token as an internal (translated) token number */

  short	yyssa[YYINITDEPTH];	/*  the state stack			*/
  YYSTYPE yyvsa[YYINITDEPTH];	/*  the semantic value stack		*/

  short *yyss = yyssa;		/*  refer to the stacks thru separate pointers */
  YYSTYPE *yyvs = yyvsa;	/*  to allow yyoverflow to reallocate them elsewhere */

#ifdef YYLSP_NEEDED
  YYLTYPE yylsa[YYINITDEPTH];	/*  the location stack			*/
  YYLTYPE *yyls = yylsa;
  YYLTYPE *yylsp;

#define YYPOPSTACK   (yyvsp--, yyssp--, yylsp--)
#else
#define YYPOPSTACK   (yyvsp--, yyssp--)
#endif

  int yystacksize = YYINITDEPTH;
  int yyfree_stacks = 0;

#ifdef YYPURE
  int yychar;
  YYSTYPE yylval;
  int yynerrs;
#ifdef YYLSP_NEEDED
  YYLTYPE yylloc;
#endif
#endif

  YYSTYPE yyval;		/*  the variable used to return		*/
				/*  semantic values from the action	*/
				/*  routines				*/

  int yylen;

#if YYDEBUG != 0
  if (yydebug)
    fprintf(stderr, "Starting parse\n");
#endif

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY;		/* Cause a token to be read.  */

  /* Initialize stack pointers.
     Waste one element of value and location stack
     so that they stay on the same level as the state stack.
     The wasted elements are never initialized.  */

  yyssp = yyss - 1;
  yyvsp = yyvs;
#ifdef YYLSP_NEEDED
  yylsp = yyls;
#endif

/* Push a new state, which is found in  yystate  .  */
/* In all cases, when you get here, the value and location stacks
   have just been pushed. so pushing a state here evens the stacks.  */
yynewstate:

  *++yyssp = yystate;

  if (yyssp >= yyss + yystacksize - 1)
    {
      /* Give user a chance to reallocate the stack */
      /* Use copies of these so that the &'s don't force the real ones into memory. */
      YYSTYPE *yyvs1 = yyvs;
      short *yyss1 = yyss;
#ifdef YYLSP_NEEDED
      YYLTYPE *yyls1 = yyls;
#endif

      /* Get the current used size of the three stacks, in elements.  */
      int size = yyssp - yyss + 1;

#ifdef yyoverflow
      /* Each stack pointer address is followed by the size of
	 the data in use in that stack, in bytes.  */
#ifdef YYLSP_NEEDED
      /* This used to be a conditional around just the two extra args,
	 but that might be undefined if yyoverflow is a macro.  */
      yyoverflow("parser stack overflow",
		 &yyss1, size * sizeof (*yyssp),
		 &yyvs1, size * sizeof (*yyvsp),
		 &yyls1, size * sizeof (*yylsp),
		 &yystacksize);
#else
      yyoverflow("parser stack overflow",
		 &yyss1, size * sizeof (*yyssp),
		 &yyvs1, size * sizeof (*yyvsp),
		 &yystacksize);
#endif

      yyss = yyss1; yyvs = yyvs1;
#ifdef YYLSP_NEEDED
      yyls = yyls1;
#endif
#else /* no yyoverflow */
      /* Extend the stack our own way.  */
      if (yystacksize >= YYMAXDEPTH)
	{
	  yyerror("parser stack overflow");
	  if (yyfree_stacks)
	    {
	      free (yyss);
	      free (yyvs);
#ifdef YYLSP_NEEDED
	      free (yyls);
#endif
	    }
	  return 2;
	}
      yystacksize *= 2;
      if (yystacksize > YYMAXDEPTH)
	yystacksize = YYMAXDEPTH;
#ifndef YYSTACK_USE_ALLOCA
      yyfree_stacks = 1;
#endif
      yyss = (short *) YYSTACK_ALLOC (yystacksize * sizeof (*yyssp));
      __yy_memcpy ((char *)yyss, (char *)yyss1,
		   size * (unsigned int) sizeof (*yyssp));
      yyvs = (YYSTYPE *) YYSTACK_ALLOC (yystacksize * sizeof (*yyvsp));
      __yy_memcpy ((char *)yyvs, (char *)yyvs1,
		   size * (unsigned int) sizeof (*yyvsp));
#ifdef YYLSP_NEEDED
      yyls = (YYLTYPE *) YYSTACK_ALLOC (yystacksize * sizeof (*yylsp));
      __yy_memcpy ((char *)yyls, (char *)yyls1,
		   size * (unsigned int) sizeof (*yylsp));
#endif
#endif /* no yyoverflow */

      yyssp = yyss + size - 1;
      yyvsp = yyvs + size - 1;
#ifdef YYLSP_NEEDED
      yylsp = yyls + size - 1;
#endif

#if YYDEBUG != 0
      if (yydebug)
	fprintf(stderr, "Stack size increased to %d\n", yystacksize);
#endif

      if (yyssp >= yyss + yystacksize - 1)
	YYABORT;
    }

#if YYDEBUG != 0
  if (yydebug)
    fprintf(stderr, "Entering state %d\n", yystate);
#endif

  goto yybackup;
 yybackup:

/* Do appropriate processing given the current state.  */
/* Read a lookahead token if we need one and don't already have one.  */
/* yyresume: */

  /* First try to decide what to do without reference to lookahead token.  */

  yyn = yypact[yystate];
  if (yyn == YYFLAG)
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* yychar is either YYEMPTY or YYEOF
     or a valid token in external form.  */

  if (yychar == YYEMPTY)
    {
#if YYDEBUG != 0
      if (yydebug)
	fprintf(stderr, "Reading a token: ");
#endif
      yychar = YYLEX;
    }

  /* Convert token to internal form (in yychar1) for indexing tables with */

  if (yychar <= 0)		/* This means end of input. */
    {
      yychar1 = 0;
      yychar = YYEOF;		/* Don't call YYLEX any more */

#if YYDEBUG != 0
      if (yydebug)
	fprintf(stderr, "Now at end of input.\n");
#endif
    }
  else
    {
      yychar1 = YYTRANSLATE(yychar);

#if YYDEBUG != 0
      if (yydebug)
	{
	  fprintf (stderr, "Next token is %d (%s", yychar, yytname[yychar1]);
	  /* Give the individual parser a way to print the precise meaning
	     of a token, for further debugging info.  */
#ifdef YYPRINT
	  YYPRINT (stderr, yychar, yylval);
#endif
	  fprintf (stderr, ")\n");
	}
#endif
    }

  yyn += yychar1;
  if (yyn < 0 || yyn > YYLAST || yycheck[yyn] != yychar1)
    goto yydefault;

  yyn = yytable[yyn];

  /* yyn is what to do for this token type in this state.
     Negative => reduce, -yyn is rule number.
     Positive => shift, yyn is new state.
       New state is final state => don't bother to shift,
       just return success.
     0, or most negative number => error.  */

  if (yyn < 0)
    {
      if (yyn == YYFLAG)
	goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }
  else if (yyn == 0)
    goto yyerrlab;

  if (yyn == YYFINAL)
    YYACCEPT;

  /* Shift the lookahead token.  */

#if YYDEBUG != 0
  if (yydebug)
    fprintf(stderr, "Shifting token %d (%s), ", yychar, yytname[yychar1]);
#endif

  /* Discard the token being shifted unless it is eof.  */
  if (yychar != YYEOF)
    yychar = YYEMPTY;

  *++yyvsp = yylval;
#ifdef YYLSP_NEEDED
  *++yylsp = yylloc;
#endif

  /* count tokens shifted since error; after three, turn off error status.  */
  if (yyerrstatus) yyerrstatus--;

  yystate = yyn;
  goto yynewstate;

/* Do the default action for the current state.  */
yydefault:

  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;

/* Do a reduction.  yyn is the number of a rule to reduce with.  */
yyreduce:
  yylen = yyr2[yyn];
  if (yylen > 0)
    yyval = yyvsp[1-yylen]; /* implement default value of the action */

#if YYDEBUG != 0
  if (yydebug)
    {
      int i;

      fprintf (stderr, "Reducing via rule %d (line %d), ",
	       yyn, yyrline[yyn]);

      /* Print the symbols being reduced, and their result.  */
      for (i = yyprhs[yyn]; yyrhs[i] > 0; i++)
	fprintf (stderr, "%s ", yytname[yyrhs[i]]);
      fprintf (stderr, " -> %s\n", yytname[yyr1[yyn]]);
    }
#endif


  switch (yyn) {

case 1:
#line 130 "parsessh.y"
{
      parsed_style_sheet = yyvsp[0].sheet;
    ;
    break;}
case 2:
#line 137 "parsessh.y"
{
	yyvsp[-2].sheet->name = yyvsp[-4].string;
	yyvsp[-2].sheet->key = "<No key yet>";
	yyval.sheet = yyvsp[-2].sheet;
      ;
    break;}
case 3:
#line 145 "parsessh.y"
{
	  yyval.sheet = new_style_sheet ((const uchar *) "<no name>");
	;
    break;}
case 4:
#line 149 "parsessh.y"
{
	  if (highlight_level == 2) {
	    words_set_no_face (yyvsp[-1].words, Plain_fface);
	    words_merge_rules_unique (yyvsp[-4].sheet->keywords, yyvsp[-1].words);
	  } else
	    words_free (yyvsp[-1].words);
	  yyval.sheet = yyvsp[-4].sheet;
	;
    break;}
case 5:
#line 158 "parsessh.y"
{
	  words_set_no_face (yyvsp[-1].words, Plain_fface);
	  words_merge_rules_unique (yyvsp[-3].sheet->keywords, yyvsp[-1].words);
	  yyval.sheet = yyvsp[-3].sheet;
	;
    break;}
case 6:
#line 164 "parsessh.y"
{
	  if (highlight_level == 2) {
	    words_set_no_face (yyvsp[-1].words, Plain_fface);
	    words_merge_rules_unique (yyvsp[-4].sheet->operators, yyvsp[-1].words);
	  } else
	    words_free (yyvsp[-1].words);
	  yyval.sheet = yyvsp[-4].sheet;
	;
    break;}
case 7:
#line 173 "parsessh.y"
{
	  words_set_no_face (yyvsp[-1].words, Plain_fface);
	  words_merge_rules_unique (yyvsp[-3].sheet->operators, yyvsp[-1].words);
	  yyval.sheet = yyvsp[-3].sheet;
	;
    break;}
case 8:
#line 178 "parsessh.y"
{
	  if (highlight_level == 2) {
	    da_concat (yyvsp[-2].sheet->sequences, yyvsp[0].array);
	    da_erase (yyvsp[0].array);
	  } else
	    da_free (yyvsp[0].array, (da_map_func_t) free_sequence);
	  yyval.sheet = yyvsp[-2].sheet;
	;
    break;}
case 9:
#line 186 "parsessh.y"
{
	  da_concat (yyvsp[-1].sheet->sequences, yyvsp[0].array);
	  da_erase (yyvsp[0].array);
	  yyval.sheet = yyvsp[-1].sheet;
	;
    break;}
case 10:
#line 191 "parsessh.y"
{
	  da_concat (yyvsp[-1].sheet->ancestors, yyvsp[0].array);
	  da_erase (yyvsp[0].array);
	  yyval.sheet = yyvsp[-1].sheet;
	;
    break;}
case 11:
#line 196 "parsessh.y"
{
	  string_to_array (yyvsp[-3].sheet->alpha1, yyvsp[0].string);
	  string_to_array (yyvsp[-3].sheet->alpha2, yyvsp[0].string);
	  /* This is the syntax table used by regex */
	  free (yyvsp[0].string);
	  yyvsp[0].string = NULL;
	  yyval.sheet = yyvsp[-3].sheet;
	;
    break;}
case 12:
#line 204 "parsessh.y"
{
	  string_to_array (yyvsp[-4].sheet->alpha1, yyvsp[0].string);
	  /* This is the syntax table used by regex */
	  free (yyvsp[0].string);
	  yyvsp[0].string = NULL;
	  yyval.sheet = yyvsp[-4].sheet;
	;
    break;}
case 13:
#line 211 "parsessh.y"
{
	  string_to_array (yyvsp[-4].sheet->alpha2, yyvsp[0].string);
	  /* This is the syntax table used by regex */
	  free (yyvsp[0].string);
	  yyvsp[0].string = NULL;
	  yyval.sheet = yyvsp[-4].sheet;
	;
    break;}
case 14:
#line 218 "parsessh.y"
{
	  yyvsp[-1].sheet->sensitiveness = yyvsp[0].sensitiveness;
	;
    break;}
case 15:
#line 221 "parsessh.y"
{
	  yyvsp[-1].sheet->documentation = yyvsp[0].string;
	;
    break;}
case 16:
#line 224 "parsessh.y"
{
	  yyvsp[-1].sheet->author = yyvsp[0].string;
	;
    break;}
case 17:
#line 227 "parsessh.y"
{
	  style_sheet_set_version (yyvsp[-1].sheet, (const char *) yyvsp[0].string);
	;
    break;}
case 18:
#line 230 "parsessh.y"
{
	  /* Make sure now that we won't encounter new tokens.
	   * This avoids nasty error messages, or worse:
	   * unexpected behavior at run time */
	  if (!style_sheet_set_requirement (yyvsp[-1].sheet, (const char *) yyvsp[0].string))
	    error (1, 0,
		   _("cannot process `%s' which requires a2ps version %s"),
		   sshfilename, yyvsp[0].string);
	;
    break;}
case 19:
#line 245 "parsessh.y"
{ yyval.string = yyvsp[0].string ; ;
    break;}
case 20:
#line 246 "parsessh.y"
{ yyval.string = yyvsp[0].string ; ;
    break;}
case 21:
#line 249 "parsessh.y"
{ yyval.string = yyvsp[-2].string ; ;
    break;}
case 22:
#line 251 "parsessh.y"
{ yyval.string = yyvsp[0].string; ;
    break;}
case 23:
#line 253 "parsessh.y"
{
	  size_t len1;
	  size_t len2;

	  len1 = ustrlen (yyvsp[-1].string);
	  yyvsp[-1].string[len1] = '\n';
	  len2 = ustrlen (yyvsp[0].string);
	  yyval.string = XMALLOC (uchar, len1 + len2 + 2);
	  ustpcpy (ustpncpy (yyval.string, yyvsp[-1].string, len1 + 1), yyvsp[0].string);
	  free (yyvsp[-1].string);
	  free (yyvsp[0].string);
	;
    break;}
case 24:
#line 267 "parsessh.y"
{ yyval.string = yyvsp[0].string ; ;
    break;}
case 25:
#line 270 "parsessh.y"
{ yyval.string = yyvsp[0].string ; ;
    break;}
case 26:
#line 271 "parsessh.y"
{ yyval.string = yyvsp[0].string ; ;
    break;}
case 27:
#line 277 "parsessh.y"
{
	  /* The list of keys of style sheets from which it inherits */
  	  yyval.array = yyvsp[-2].array;
	;
    break;}
case 28:
#line 284 "parsessh.y"
{
	  /* Create a list of ancestors, and drop the new one in */
	  yyval.array = da_new ("Ancestors tmp", 2,
		       da_linear, 2,
		       (da_print_func_t) da_str_print, NULL);
	  da_append (yyval.array, yyvsp[0].string);
	;
    break;}
case 29:
#line 292 "parsessh.y"
{
	  da_append (yyvsp[-2].array, yyvsp[0].string);
	  yyval.array = yyvsp[-2].array;
	;
    break;}
case 30:
#line 298 "parsessh.y"
{ yyval.sensitiveness = yyvsp[0].sensitiveness ; ;
    break;}
case 31:
#line 307 "parsessh.y"
{
	  yyval.pattern = yyvsp[0].pattern;
	;
    break;}
case 32:
#line 311 "parsessh.y"
{
	  /* Concatenate $2 to $1 makes $$ */
	  yyval.pattern = yyvsp[-1].pattern;
	  yyval.pattern->pattern = XREALLOC (yyval.pattern->pattern, char, yyvsp[-1].pattern->len + yyvsp[0].pattern->len + 1);
	  strncpy (yyval.pattern->pattern + yyval.pattern->len, yyvsp[0].pattern->pattern, yyvsp[0].pattern->len);
	  yyval.pattern->len += yyvsp[0].pattern->len;
	  free (yyvsp[0].pattern->pattern);
	;
    break;}
case 33:
#line 323 "parsessh.y"
{
	  yyval.array = rhs_new ();
	  rhs_add (yyval.array, yyvsp[0].faced_string);
	;
    break;}
case 34:
#line 331 "parsessh.y"
{
	  yyval.faced_string = faced_string_new  (yyvsp[-1].string, 0, yyvsp[0].fface);
	;
    break;}
case 35:
#line 335 "parsessh.y"
{
	  yyval.faced_string = faced_string_new  (yyvsp[0].string, 0, No_fface);
	;
    break;}
case 36:
#line 339 "parsessh.y"
{
	  yyval.faced_string = faced_string_new  (NULL, 0, yyvsp[0].fface);
	;
    break;}
case 37:
#line 343 "parsessh.y"
{
	  yyval.faced_string = faced_string_new  (UNULL, yyvsp[-1].integer, yyvsp[0].fface);
	;
    break;}
case 38:
#line 347 "parsessh.y"
{
	  yyval.faced_string = faced_string_new  (UNULL, yyvsp[0].integer, No_fface);
	;
    break;}
case 39:
#line 351 "parsessh.y"
{
	  yyval.faced_string = faced_string_new (yyvsp[0].string, 0, Symbol_fface);
	;
    break;}
case 40:
#line 358 "parsessh.y"
{
	  yyval.array = rhs_new ();
	  rhs_add (yyval.array, yyvsp[0].faced_string);
	;
    break;}
case 41:
#line 364 "parsessh.y"
{
	  rhs_add (yyvsp[-2].array, yyvsp[0].faced_string);
	  yyval.array = yyvsp[-2].array;
	;
    break;}
case 42:
#line 375 "parsessh.y"
{
	  fface_set_face (yyval.fface, yyvsp[0].face);
	  fface_reset_flags (yyval.fface);
	;
    break;}
case 43:
#line 380 "parsessh.y"
{
	  fface_reset_face (yyval.fface);
	  fface_set_flags (yyval.fface, yyvsp[0].fflags);
	  /* If there is no face, then set Invisible */
	  fface_add_flags (yyval.fface, ff_Invisible);
	;
    break;}
case 44:
#line 387 "parsessh.y"
{
	  yyval.fface = yyvsp[-1].fface;
	  /* If there is no face, then set Invisible */
	  if (fface_get_face (yyval.fface) == No_face)
	    fface_add_flags (yyval.fface, ff_Invisible);
	;
    break;}
case 45:
#line 397 "parsessh.y"
{
	  fface_set_face(yyval.fface, yyvsp[0].face);
	  fface_reset_flags(yyval.fface);
	;
    break;}
case 46:
#line 402 "parsessh.y"
{
	  fface_reset_face(yyval.fface);
	  fface_set_flags(yyval.fface, yyvsp[0].fflags);
	;
    break;}
case 47:
#line 407 "parsessh.y"
{
	  /* FIXME: Overloading of the face should be forbidden */
	  yyval.fface = yyvsp[-2].fface;
	  fface_set_face(yyval.fface, yyvsp[0].face);
	;
    break;}
case 48:
#line 413 "parsessh.y"
{
	  yyval.fface = yyvsp[-2].fface;
	  fface_add_flags(yyval.fface, yyvsp[0].fflags);
	;
    break;}
case 49:
#line 427 "parsessh.y"
{
	  yyval.rule = rule_new (yyvsp[-1].string, NULL, yyvsp[0].array,
			 sshfilename, sshlineno);
	;
    break;}
case 50:
#line 432 "parsessh.y"
{
	  yyval.rule = rule_new (yyvsp[0].string, NULL,
			 rhs_new_single (UNULL, 0, No_fface),
			 sshfilename, sshlineno);
	;
    break;}
case 51:
#line 438 "parsessh.y"
{
	  yyval.rule = rule_new (yyvsp[-2].string, NULL, yyvsp[-1].array,
			 sshfilename, sshlineno);
	;
    break;}
case 52:
#line 449 "parsessh.y"
{
	  words_set_no_face (yyvsp[-1].words, yyvsp[-3].fface);
	  yyval.words = yyvsp[-1].words;
	;
    break;}
case 53:
#line 453 "parsessh.y"
{
  	  /* First of all, the No_face must be turned into Plain */
  	  yyval.words = yyvsp[-1].words;
	;
    break;}
case 54:
#line 461 "parsessh.y"
{
	  yyval.words = words_new ("Keywords: Strings", "Keywords: Regexps", 100, 100);
	  words_add_string (yyval.words, yyvsp[0].rule);
	;
    break;}
case 55:
#line 466 "parsessh.y"
{
	  yyval.words = words_new ("Keywords: Strings", "Keywords: Regexps", 100, 100);
	  words_add_regex (yyval.words, yyvsp[0].rule);
	;
    break;}
case 56:
#line 471 "parsessh.y"
{
	  words_add_string (yyvsp[-2].words, yyvsp[0].rule);
	  yyval.words = yyvsp[-2].words;
	;
    break;}
case 57:
#line 476 "parsessh.y"
{
	  words_add_regex (yyvsp[-2].words, yyvsp[0].rule);
	  yyval.words = yyvsp[-2].words;
	;
    break;}
case 58:
#line 488 "parsessh.y"
{
	  yyval.rule = keyword_rule_new (UNULL, yyvsp[-1].pattern, yyvsp[0].array,
				 sshfilename, sshlineno);
	;
    break;}
case 59:
#line 493 "parsessh.y"
{
	  yyval.rule = keyword_rule_new (UNULL, yyvsp[0].pattern,
				   rhs_new_single (UNULL, 0,
							    No_fface),
				 sshfilename, sshlineno);
	;
    break;}
case 60:
#line 500 "parsessh.y"
{
	  yyval.rule = keyword_rule_new (UNULL, yyvsp[-2].pattern, yyvsp[-1].array,
				 sshfilename, sshlineno);
	;
    break;}
case 61:
#line 509 "parsessh.y"
{
	  words_set_no_face (yyvsp[-1].words, yyvsp[-3].fface);
	  yyval.words = yyvsp[-1].words;
	;
    break;}
case 62:
#line 513 "parsessh.y"
{
  	  /* First of all, the No_face must be turned into Plain */
  	  yyval.words = yyvsp[-1].words;
	;
    break;}
case 63:
#line 521 "parsessh.y"
{
	  yyval.words = words_new ("Operators: Strings", "Operators: Regexps",
			  100, 100);
	  words_add_string (yyval.words, yyvsp[0].rule);
	;
    break;}
case 64:
#line 527 "parsessh.y"
{
	  yyval.words = words_new ("Operators: Strings", "Operators: Regexps",
			  100, 100);
	  words_add_regex (yyval.words, yyvsp[0].rule);
	;
    break;}
case 65:
#line 533 "parsessh.y"
{
	  words_add_string (yyvsp[-2].words, yyvsp[0].rule);
	  yyval.words = yyvsp[-2].words;
	;
    break;}
case 66:
#line 538 "parsessh.y"
{
	  words_add_regex (yyvsp[-2].words, yyvsp[0].rule);
	  yyval.words = yyvsp[-2].words;
	;
    break;}
case 67:
#line 550 "parsessh.y"
{
	  yyval.rule = rule_new (UNULL, yyvsp[-1].pattern, yyvsp[0].array,
			 sshfilename, sshlineno);
	;
    break;}
case 68:
#line 555 "parsessh.y"
{
	  yyval.rule = rule_new (UNULL, yyvsp[0].pattern,
			   rhs_new_single (UNULL, 0, No_fface),
			 sshfilename, sshlineno);
	;
    break;}
case 69:
#line 561 "parsessh.y"
{
	  yyval.rule = rule_new (UNULL, yyvsp[-2].pattern, yyvsp[-1].array,
			 sshfilename, sshlineno);
	;
    break;}
case 70:
#line 570 "parsessh.y"
{ yyval.array = yyvsp[-2].array; ;
    break;}
case 71:
#line 573 "parsessh.y"
{
	  yyval.array = da_new ("Sequence tmp", 100,
		       da_linear, 100,
		       (da_print_func_t) sequence_self_print, NULL);
	  da_append (yyval.array, yyvsp[0].sequence);
	;
    break;}
case 72:
#line 579 "parsessh.y"
{
	  da_append (yyvsp[-2].array, yyvsp[0].sequence);
	  yyval.array = yyvsp[-2].array;
	;
    break;}
case 73:
#line 603 "parsessh.y"
{
	  struct rule * open_rule;
	  open_rule = rule_new (yyvsp[-4].string, NULL,
				rhs_new_single (yyvsp[-3].string, 0, Symbol_fface),
				sshfilename, sshlineno);
	  yyval.sequence = sequence_new (open_rule, yyvsp[-2].fface, yyvsp[-1].words, yyvsp[0].words);
	;
    break;}
case 74:
#line 611 "parsessh.y"
{
	  struct rule * open_rule;
	  open_rule = rule_new (yyvsp[-5].string, NULL,
				rhs_new_single (yyvsp[-4].string, 0, yyvsp[-3].fface),
				sshfilename, sshlineno);
	  yyval.sequence = sequence_new (open_rule, yyvsp[-2].fface, yyvsp[-1].words, yyvsp[0].words);
	;
    break;}
case 75:
#line 619 "parsessh.y"
{
	  struct rule * open_rule;
	  open_rule = rule_new (yyvsp[-4].string, NULL,
				rhs_new_single (UNULL, 0, yyvsp[-3].fface),
				sshfilename, sshlineno);
	  yyval.sequence = sequence_new (open_rule, yyvsp[-2].fface, yyvsp[-1].words, yyvsp[0].words);
	;
    break;}
case 76:
#line 627 "parsessh.y"
{
	  struct rule * open_rule;
	  open_rule = rule_new (yyvsp[-4].string, NULL,
				rhs_new_single (yyvsp[-3].string, 0, yyvsp[-2].fface),
				sshfilename, sshlineno);
	  yyval.sequence = sequence_new (open_rule, yyvsp[-2].fface, yyvsp[-1].words, yyvsp[0].words);
	;
    break;}
case 77:
#line 635 "parsessh.y"
{
	  struct rule * open_rule;
	  open_rule = rule_new (yyvsp[-3].string, NULL,
				rhs_new_single (UNULL, 0, yyvsp[-2].fface),
				sshfilename, sshlineno);
	  yyval.sequence = sequence_new (open_rule, yyvsp[-2].fface, yyvsp[-1].words, yyvsp[0].words);
	;
    break;}
case 78:
#line 643 "parsessh.y"
{
	  struct rule * open_rule;
	  open_rule = rule_new (UNULL, yyvsp[-5].pattern,
				rhs_new_single (yyvsp[-4].string, 0, yyvsp[-3].fface),
				sshfilename, sshlineno);
	  yyval.sequence = sequence_new (open_rule, yyvsp[-2].fface, yyvsp[-1].words, yyvsp[0].words);
	;
    break;}
case 79:
#line 651 "parsessh.y"
{
	  struct rule * open_rule;
	  open_rule = rule_new (UNULL, yyvsp[-4].pattern,
				rhs_new_single (UNULL, 0, yyvsp[-3].fface),
				sshfilename, sshlineno);
	  yyval.sequence = sequence_new (open_rule, yyvsp[-2].fface, yyvsp[-1].words, yyvsp[0].words);
	;
    break;}
case 80:
#line 659 "parsessh.y"
{
	  struct rule * open_rule;
	  open_rule = rule_new (UNULL, yyvsp[-4].pattern,
				rhs_new_single (yyvsp[-3].string, 0, yyvsp[-2].fface),
				sshfilename, sshlineno);
	  yyval.sequence = sequence_new (open_rule, yyvsp[-2].fface, yyvsp[-1].words, yyvsp[0].words);
	;
    break;}
case 81:
#line 667 "parsessh.y"
{
	  struct rule * open_rule;
	  open_rule = rule_new (UNULL, yyvsp[-3].pattern,
				rhs_new_single (UNULL, 0, No_fface),
				sshfilename, sshlineno);
	  yyval.sequence = sequence_new (open_rule, yyvsp[-2].fface, yyvsp[-1].words, yyvsp[0].words);
	;
    break;}
case 82:
#line 675 "parsessh.y"
{
	  struct rule * open_rule;
	  open_rule = rule_new (yyvsp[-5].string, NULL, yyvsp[-4].array,
				sshfilename, sshlineno);
	  yyval.sequence = sequence_new (open_rule, yyvsp[-2].fface, yyvsp[-1].words, yyvsp[0].words);
	;
    break;}
case 83:
#line 682 "parsessh.y"
{
	  struct rule * open_rule;
	  open_rule = rule_new (UNULL, yyvsp[-5].pattern, yyvsp[-4].array,
				sshfilename, sshlineno);
	  yyval.sequence = sequence_new (open_rule, yyvsp[-2].fface, yyvsp[-1].words, yyvsp[0].words);
	;
    break;}
case 84:
#line 690 "parsessh.y"
{
	  yyval.sequence = new_C_string_sequence ("\"");
	;
    break;}
case 85:
#line 694 "parsessh.y"
{
	  yyval.sequence = new_C_string_sequence ("\'");
	;
    break;}
case 86:
#line 701 "parsessh.y"
{
	  /* This is a shortcut which means "up to the end of the line". */
	  yyval.words = words_new ("Closing: Strings", "Closing: Regexps", 2, 2);
	  words_add_string (yyval.words, rule_new (xustrdup ("\n"), NULL,
					  rhs_new_single (NULL, 0,
							  No_fface),
					  sshfilename, sshlineno));
	;
    break;}
case 87:
#line 710 "parsessh.y"
{
	  /* Only one */
	  yyval.words = words_new ("Closing: Strings", "Closing: Regexps", 2, 2);
	  words_add_string (yyval.words, yyvsp[0].rule);
	;
    break;}
case 88:
#line 716 "parsessh.y"
{
	  /* Only one */
	  yyval.words = words_new ("Closing: Strings", "Closing: Regexps", 2, 2);
	  words_add_regex (yyval.words, yyvsp[0].rule);
	;
    break;}
case 89:
#line 722 "parsessh.y"
{
	  /* Several, comma separated, between () */
	  yyval.words = yyvsp[-1].words;
	;
    break;}
case 90:
#line 730 "parsessh.y"
{
	  yyval.words = words_new ("Exceptions: Strings", "Exceptions: Regexps", 1, 1);
	;
    break;}
case 91:
#line 734 "parsessh.y"
{
	  yyval.words = yyvsp[-1].words;
	;
    break;}
}
   /* the action file gets copied in in place of this dollarsign */
#line 543 "/emx/share/bison.simple"

  yyvsp -= yylen;
  yyssp -= yylen;
#ifdef YYLSP_NEEDED
  yylsp -= yylen;
#endif

#if YYDEBUG != 0
  if (yydebug)
    {
      short *ssp1 = yyss - 1;
      fprintf (stderr, "state stack now");
      while (ssp1 != yyssp)
	fprintf (stderr, " %d", *++ssp1);
      fprintf (stderr, "\n");
    }
#endif

  *++yyvsp = yyval;

#ifdef YYLSP_NEEDED
  yylsp++;
  if (yylen == 0)
    {
      yylsp->first_line = yylloc.first_line;
      yylsp->first_column = yylloc.first_column;
      yylsp->last_line = (yylsp-1)->last_line;
      yylsp->last_column = (yylsp-1)->last_column;
      yylsp->text = 0;
    }
  else
    {
      yylsp->last_line = (yylsp+yylen-1)->last_line;
      yylsp->last_column = (yylsp+yylen-1)->last_column;
    }
#endif

  /* Now "shift" the result of the reduction.
     Determine what state that goes to,
     based on the state we popped back to
     and the rule number reduced by.  */

  yyn = yyr1[yyn];

  yystate = yypgoto[yyn - YYNTBASE] + *yyssp;
  if (yystate >= 0 && yystate <= YYLAST && yycheck[yystate] == *yyssp)
    yystate = yytable[yystate];
  else
    yystate = yydefgoto[yyn - YYNTBASE];

  goto yynewstate;

yyerrlab:   /* here on detecting error */

  if (! yyerrstatus)
    /* If not already recovering from an error, report this error.  */
    {
      ++yynerrs;

#ifdef YYERROR_VERBOSE
      yyn = yypact[yystate];

      if (yyn > YYFLAG && yyn < YYLAST)
	{
	  int size = 0;
	  char *msg;
	  int x, count;

	  count = 0;
	  /* Start X at -yyn if nec to avoid negative indexes in yycheck.  */
	  for (x = (yyn < 0 ? -yyn : 0);
	       x < (sizeof(yytname) / sizeof(char *)); x++)
	    if (yycheck[x + yyn] == x)
	      size += strlen(yytname[x]) + 15, count++;
	  msg = (char *) malloc(size + 15);
	  if (msg != 0)
	    {
	      strcpy(msg, "parse error");

	      if (count < 5)
		{
		  count = 0;
		  for (x = (yyn < 0 ? -yyn : 0);
		       x < (sizeof(yytname) / sizeof(char *)); x++)
		    if (yycheck[x + yyn] == x)
		      {
			strcat(msg, count == 0 ? ", expecting `" : " or `");
			strcat(msg, yytname[x]);
			strcat(msg, "'");
			count++;
		      }
		}
	      yyerror(msg);
	      free(msg);
	    }
	  else
	    yyerror ("parse error; also virtual memory exceeded");
	}
      else
#endif /* YYERROR_VERBOSE */
	yyerror("parse error");
    }

  goto yyerrlab1;
yyerrlab1:   /* here on error raised explicitly by an action */

  if (yyerrstatus == 3)
    {
      /* if just tried and failed to reuse lookahead token after an error, discard it.  */

      /* return failure if at end of input */
      if (yychar == YYEOF)
	YYABORT;

#if YYDEBUG != 0
      if (yydebug)
	fprintf(stderr, "Discarding token %d (%s).\n", yychar, yytname[yychar1]);
#endif

      yychar = YYEMPTY;
    }

  /* Else will try to reuse lookahead token
     after shifting the error token.  */

  yyerrstatus = 3;		/* Each real token shifted decrements this */

  goto yyerrhandle;

yyerrdefault:  /* current state does not do anything special for the error token. */

#if 0
  /* This is wrong; only states that explicitly want error tokens
     should shift them.  */
  yyn = yydefact[yystate];  /* If its default is to accept any token, ok.  Otherwise pop it.*/
  if (yyn) goto yydefault;
#endif

yyerrpop:   /* pop the current state because it cannot handle the error token */

  if (yyssp == yyss) YYABORT;
  yyvsp--;
  yystate = *--yyssp;
#ifdef YYLSP_NEEDED
  yylsp--;
#endif

#if YYDEBUG != 0
  if (yydebug)
    {
      short *ssp1 = yyss - 1;
      fprintf (stderr, "Error: state stack now");
      while (ssp1 != yyssp)
	fprintf (stderr, " %d", *++ssp1);
      fprintf (stderr, "\n");
    }
#endif

yyerrhandle:

  yyn = yypact[yystate];
  if (yyn == YYFLAG)
    goto yyerrdefault;

  yyn += YYTERROR;
  if (yyn < 0 || yyn > YYLAST || yycheck[yyn] != YYTERROR)
    goto yyerrdefault;

  yyn = yytable[yyn];
  if (yyn < 0)
    {
      if (yyn == YYFLAG)
	goto yyerrpop;
      yyn = -yyn;
      goto yyreduce;
    }
  else if (yyn == 0)
    goto yyerrpop;

  if (yyn == YYFINAL)
    YYACCEPT;

#if YYDEBUG != 0
  if (yydebug)
    fprintf(stderr, "Shifting error token, ");
#endif

  *++yyvsp = yylval;
#ifdef YYLSP_NEEDED
  *++yylsp = yylloc;
#endif

  yystate = yyn;
  goto yynewstate;

 yyacceptlab:
  /* YYACCEPT comes here.  */
  if (yyfree_stacks)
    {
      free (yyss);
      free (yyvs);
#ifdef YYLSP_NEEDED
      free (yyls);
#endif
    }
  return 0;

 yyabortlab:
  /* YYABORT comes here.  */
  if (yyfree_stacks)
    {
      free (yyss);
      free (yyvs);
#ifdef YYLSP_NEEDED
      free (yyls);
#endif
    }
  return 1;
}
#line 738 "parsessh.y"


void
yyerror (const char *msg)
{
  error_at_line (1, 0, sshfilename, sshlineno, msg);
}

/*
 * FIXME: Cover the other relevant types
 */
static void
yyprint (FILE *file, int type, YYSTYPE value)
{
  switch (type) {
  case tBACK_REF:
    fprintf (file, " \\%d", value.integer);
    break;

  case tFFLAGS:
    putc (' ', file);
    fflag_self_print (value.fflags, file);
    break;

  case tFACE:
    fprintf (file, " %s", face_to_string (value.face));
    break;

  case tREGEX:
    fprintf (file, " /%s/", value.pattern->pattern);
    break;

  case tSTRING:
    fprintf (file, " \"%s\"", value.string);
    break;
  }
}

struct style_sheet *
parse_style_sheet (const char * filename)
{
  int res;

  sshfilename = filename;
  sshlineno = 1;
  sshin = xrfopen (sshfilename);

  message (msg_file | msg_sheet | msg_parse,
	   (stderr, "Parsing file `%s'\n", sshfilename));

  sshlex_initialize ();

  if (msg_test (msg_parse))
    yydebug = true;
  res = yyparse ();  /* FIXME: test the result of parsing */

  if (msg_test (msg_sheet)) {
    fprintf (stderr, "---------- Right after parsing of %s\n",
	     parsed_style_sheet->key);
    style_sheet_self_print (parsed_style_sheet, stderr);
    fprintf (stderr, "---------- End of after parsing of %s\n",
	     parsed_style_sheet->key);
  }

  fclose (sshin);
  return parsed_style_sheet;
}
