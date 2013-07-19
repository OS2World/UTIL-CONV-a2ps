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


extern YYSTYPE yylval;
