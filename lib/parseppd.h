typedef union
{
  char * string;
  uchar * ustring;
  struct ppd * ppd;
} YYSTYPE;
#define	EOL	257
#define	tDefaultFont	258
#define	tFont	259
#define	tModelName	260
#define	tNickName	261
#define	STRING	262
#define	SYMBOL	263
#define	USTRING	264


extern YYSTYPE yylval;
