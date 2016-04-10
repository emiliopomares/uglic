/* A Bison parser, made by GNU Bison 3.0.2.  */

/* Bison implementation for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2013 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* C LALR(1) parser skeleton written by Richard Stallman, by
   simplifying the original so-called "semantic" parser.  */

/* All symbols defined below should begin with yy or YY, to avoid
   infringing on user name space.  This should be done even for local
   variables, as they might otherwise be expanded by user macros.
   There are some unavoidable exceptions within include files to
   define necessary library symbols; they are noted "INFRINGES ON
   USER NAME SPACE" below.  */

/* Identify Bison output.  */
#define YYBISON 1

/* Bison version.  */
#define YYBISON_VERSION "3.0.2"

/* Skeleton name.  */
#define YYSKELETON_NAME "yacc.c"

/* Pure parsers.  */
#define YYPURE 0

/* Push parsers.  */
#define YYPUSH 0

/* Pull parsers.  */
#define YYPULL 1




/* Copy the first part of user declarations.  */
#line 5 "ugli.y" /* yacc.c:339  */

    
    #define VERSION "1.0"
    
    #include <stdio.h>
    #include <string.h>
    #include "UGLIinternal.h"
    
    extern int  yylineno;
    extern char* yytext[];
    extern FILE* outFile_p;
    extern FILE* yyin;
    int noerror=1;
    int typeOfLastConstant;
    int curContext;
    char tempVarNames[128];
    
    //int yydebug=1;
    
    
    void yyerror(const char *str)
    {
        fprintf(stderr,"error: %s\n",str);
    }
    
    int yywrap()
    {
        return 1;
    }
    
    main()
    {
        
        FILE *outt;
        
        internal_init();
        curContext = 0;
        yyin = fopen("/Users/flandre/Dropbox/codigo/UGLI2014/uglic.macosx_opengl_au/uglic.macosx_opengl_au/test.u", "r");
        if(!yyin) {
            yyin = fopen("/Users/remilia/Dropbox/codigo/UGLI2014/uglic.macosx_opengl_au/uglic.macosx_opengl_au/test.u", "r");
            if(!yyin) {
            printf("error reading"); exit(-1);
            }
        }
        yyparse();
        printf("yyparseado\n");
        outt = fopen("./out.m", "w");
        flushToOutSource_objc(VERSION, outt);
        
    }
    
    

#line 120 "y.tab.c" /* yacc.c:339  */

# ifndef YY_NULLPTR
#  if defined __cplusplus && 201103L <= __cplusplus
#   define YY_NULLPTR nullptr
#  else
#   define YY_NULLPTR 0
#  endif
# endif

/* Enabling verbose error messages.  */
#ifdef YYERROR_VERBOSE
# undef YYERROR_VERBOSE
# define YYERROR_VERBOSE 1
#else
# define YYERROR_VERBOSE 0
#endif

/* In a future release of Bison, this section will be replaced
   by #include "y.tab.h".  */
#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    UNIT_RES = 258,
    INHERITS = 259,
    SWITCH_RES = 260,
    GROUP_RES = 261,
    TYPE_RES = 262,
    INLET_RES = 263,
    OUTLET_RES = 264,
    STATE_RES = 265,
    COMMA = 266,
    SLOT_RES = 267,
    PARENTH_OPEN = 268,
    PARENTH_CLOSE = 269,
    CBRACKET_OPEN = 270,
    CBRACKET_CLOSE = 271,
    BRACKET_OPEN = 272,
    BRACKET_CLOSE = 273,
    BEHAVIOUR_RES = 274,
    AT = 275,
    PLUS = 276,
    DOT = 277,
    MINUSASSIGN = 278,
    MULTASSIGN = 279,
    GOTO_RES = 280,
    MINUS = 281,
    MULT = 282,
    DIVASSIGN = 283,
    NOTASSIGN = 284,
    PLUSASSIGN = 285,
    ON_RES = 286,
    EVENT_RES = 287,
    FOR_RES = 288,
    WHILE_RES = 289,
    IMMEDIATEFOR_RES = 290,
    IMMEDIATEWHILE_RES = 291,
    IMMEDIATE_RES = 292,
    OFTYPE_RES = 293,
    ENDTYPE_RES = 294,
    ENDUNT_RES = 295,
    INCOP = 296,
    DECOP = 297,
    COLON = 298,
    SEMICOLON = 299,
    COMPARATOR = 300,
    ASSIGN = 301,
    DEFAULT_RES = 302,
    IF_RES = 303,
    LESSTHAN = 304,
    GREATERTHAN = 305,
    COMPARE = 306,
    NOTIFY_RES = 307,
    EID_RES = 308,
    ENDSWITCH_RES = 309,
    ACTION_RES = 310,
    FUNCTION_RES = 311,
    SELF_RES = 312,
    STRING = 313,
    ID = 314,
    INTEGER = 315,
    BASIC_TYPE = 316,
    FLOAT = 317,
    DIV = 318
  };
#endif
/* Tokens.  */
#define UNIT_RES 258
#define INHERITS 259
#define SWITCH_RES 260
#define GROUP_RES 261
#define TYPE_RES 262
#define INLET_RES 263
#define OUTLET_RES 264
#define STATE_RES 265
#define COMMA 266
#define SLOT_RES 267
#define PARENTH_OPEN 268
#define PARENTH_CLOSE 269
#define CBRACKET_OPEN 270
#define CBRACKET_CLOSE 271
#define BRACKET_OPEN 272
#define BRACKET_CLOSE 273
#define BEHAVIOUR_RES 274
#define AT 275
#define PLUS 276
#define DOT 277
#define MINUSASSIGN 278
#define MULTASSIGN 279
#define GOTO_RES 280
#define MINUS 281
#define MULT 282
#define DIVASSIGN 283
#define NOTASSIGN 284
#define PLUSASSIGN 285
#define ON_RES 286
#define EVENT_RES 287
#define FOR_RES 288
#define WHILE_RES 289
#define IMMEDIATEFOR_RES 290
#define IMMEDIATEWHILE_RES 291
#define IMMEDIATE_RES 292
#define OFTYPE_RES 293
#define ENDTYPE_RES 294
#define ENDUNT_RES 295
#define INCOP 296
#define DECOP 297
#define COLON 298
#define SEMICOLON 299
#define COMPARATOR 300
#define ASSIGN 301
#define DEFAULT_RES 302
#define IF_RES 303
#define LESSTHAN 304
#define GREATERTHAN 305
#define COMPARE 306
#define NOTIFY_RES 307
#define EID_RES 308
#define ENDSWITCH_RES 309
#define ACTION_RES 310
#define FUNCTION_RES 311
#define SELF_RES 312
#define STRING 313
#define ID 314
#define INTEGER 315
#define BASIC_TYPE 316
#define FLOAT 317
#define DIV 318

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef union YYSTYPE YYSTYPE;
union YYSTYPE
{
#line 58 "ugli.y" /* yacc.c:355  */

    
    char str[128];
    int Integer;
    float Float;

#line 293 "y.tab.c" /* yacc.c:355  */
};
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */

/* Copy the second part of user declarations.  */

#line 308 "y.tab.c" /* yacc.c:358  */

#ifdef short
# undef short
#endif

#ifdef YYTYPE_UINT8
typedef YYTYPE_UINT8 yytype_uint8;
#else
typedef unsigned char yytype_uint8;
#endif

#ifdef YYTYPE_INT8
typedef YYTYPE_INT8 yytype_int8;
#else
typedef signed char yytype_int8;
#endif

#ifdef YYTYPE_UINT16
typedef YYTYPE_UINT16 yytype_uint16;
#else
typedef unsigned short int yytype_uint16;
#endif

#ifdef YYTYPE_INT16
typedef YYTYPE_INT16 yytype_int16;
#else
typedef short int yytype_int16;
#endif

#ifndef YYSIZE_T
# ifdef __SIZE_TYPE__
#  define YYSIZE_T __SIZE_TYPE__
# elif defined size_t
#  define YYSIZE_T size_t
# elif ! defined YYSIZE_T
#  include <stddef.h> /* INFRINGES ON USER NAME SPACE */
#  define YYSIZE_T size_t
# else
#  define YYSIZE_T unsigned int
# endif
#endif

#define YYSIZE_MAXIMUM ((YYSIZE_T) -1)

#ifndef YY_
# if defined YYENABLE_NLS && YYENABLE_NLS
#  if ENABLE_NLS
#   include <libintl.h> /* INFRINGES ON USER NAME SPACE */
#   define YY_(Msgid) dgettext ("bison-runtime", Msgid)
#  endif
# endif
# ifndef YY_
#  define YY_(Msgid) Msgid
# endif
#endif

#ifndef YY_ATTRIBUTE
# if (defined __GNUC__                                               \
      && (2 < __GNUC__ || (__GNUC__ == 2 && 96 <= __GNUC_MINOR__)))  \
     || defined __SUNPRO_C && 0x5110 <= __SUNPRO_C
#  define YY_ATTRIBUTE(Spec) __attribute__(Spec)
# else
#  define YY_ATTRIBUTE(Spec) /* empty */
# endif
#endif

#ifndef YY_ATTRIBUTE_PURE
# define YY_ATTRIBUTE_PURE   YY_ATTRIBUTE ((__pure__))
#endif

#ifndef YY_ATTRIBUTE_UNUSED
# define YY_ATTRIBUTE_UNUSED YY_ATTRIBUTE ((__unused__))
#endif

#if !defined _Noreturn \
     && (!defined __STDC_VERSION__ || __STDC_VERSION__ < 201112)
# if defined _MSC_VER && 1200 <= _MSC_VER
#  define _Noreturn __declspec (noreturn)
# else
#  define _Noreturn YY_ATTRIBUTE ((__noreturn__))
# endif
#endif

/* Suppress unused-variable warnings by "using" E.  */
#if ! defined lint || defined __GNUC__
# define YYUSE(E) ((void) (E))
#else
# define YYUSE(E) /* empty */
#endif

#if defined __GNUC__ && 407 <= __GNUC__ * 100 + __GNUC_MINOR__
/* Suppress an incorrect diagnostic about yylval being uninitialized.  */
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN \
    _Pragma ("GCC diagnostic push") \
    _Pragma ("GCC diagnostic ignored \"-Wuninitialized\"")\
    _Pragma ("GCC diagnostic ignored \"-Wmaybe-uninitialized\"")
# define YY_IGNORE_MAYBE_UNINITIALIZED_END \
    _Pragma ("GCC diagnostic pop")
#else
# define YY_INITIAL_VALUE(Value) Value
#endif
#ifndef YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
# define YY_IGNORE_MAYBE_UNINITIALIZED_END
#endif
#ifndef YY_INITIAL_VALUE
# define YY_INITIAL_VALUE(Value) /* Nothing. */
#endif


#if ! defined yyoverflow || YYERROR_VERBOSE

/* The parser invokes alloca or malloc; define the necessary symbols.  */

# ifdef YYSTACK_USE_ALLOCA
#  if YYSTACK_USE_ALLOCA
#   ifdef __GNUC__
#    define YYSTACK_ALLOC __builtin_alloca
#   elif defined __BUILTIN_VA_ARG_INCR
#    include <alloca.h> /* INFRINGES ON USER NAME SPACE */
#   elif defined _AIX
#    define YYSTACK_ALLOC __alloca
#   elif defined _MSC_VER
#    include <malloc.h> /* INFRINGES ON USER NAME SPACE */
#    define alloca _alloca
#   else
#    define YYSTACK_ALLOC alloca
#    if ! defined _ALLOCA_H && ! defined EXIT_SUCCESS
#     include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
      /* Use EXIT_SUCCESS as a witness for stdlib.h.  */
#     ifndef EXIT_SUCCESS
#      define EXIT_SUCCESS 0
#     endif
#    endif
#   endif
#  endif
# endif

# ifdef YYSTACK_ALLOC
   /* Pacify GCC's 'empty if-body' warning.  */
#  define YYSTACK_FREE(Ptr) do { /* empty */; } while (0)
#  ifndef YYSTACK_ALLOC_MAXIMUM
    /* The OS might guarantee only one guard page at the bottom of the stack,
       and a page size can be as small as 4096 bytes.  So we cannot safely
       invoke alloca (N) if N exceeds 4096.  Use a slightly smaller number
       to allow for a few compiler-allocated temporary stack slots.  */
#   define YYSTACK_ALLOC_MAXIMUM 4032 /* reasonable circa 2006 */
#  endif
# else
#  define YYSTACK_ALLOC YYMALLOC
#  define YYSTACK_FREE YYFREE
#  ifndef YYSTACK_ALLOC_MAXIMUM
#   define YYSTACK_ALLOC_MAXIMUM YYSIZE_MAXIMUM
#  endif
#  if (defined __cplusplus && ! defined EXIT_SUCCESS \
       && ! ((defined YYMALLOC || defined malloc) \
             && (defined YYFREE || defined free)))
#   include <stdlib.h> /* INFRINGES ON USER NAME SPACE */
#   ifndef EXIT_SUCCESS
#    define EXIT_SUCCESS 0
#   endif
#  endif
#  ifndef YYMALLOC
#   define YYMALLOC malloc
#   if ! defined malloc && ! defined EXIT_SUCCESS
void *malloc (YYSIZE_T); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
#  ifndef YYFREE
#   define YYFREE free
#   if ! defined free && ! defined EXIT_SUCCESS
void free (void *); /* INFRINGES ON USER NAME SPACE */
#   endif
#  endif
# endif
#endif /* ! defined yyoverflow || YYERROR_VERBOSE */


#if (! defined yyoverflow \
     && (! defined __cplusplus \
         || (defined YYSTYPE_IS_TRIVIAL && YYSTYPE_IS_TRIVIAL)))

/* A type that is properly aligned for any stack member.  */
union yyalloc
{
  yytype_int16 yyss_alloc;
  YYSTYPE yyvs_alloc;
};

/* The size of the maximum gap between one aligned stack and the next.  */
# define YYSTACK_GAP_MAXIMUM (sizeof (union yyalloc) - 1)

/* The size of an array large to enough to hold all stacks, each with
   N elements.  */
# define YYSTACK_BYTES(N) \
     ((N) * (sizeof (yytype_int16) + sizeof (YYSTYPE)) \
      + YYSTACK_GAP_MAXIMUM)

# define YYCOPY_NEEDED 1

/* Relocate STACK from its old location to the new one.  The
   local variables YYSIZE and YYSTACKSIZE give the old and new number of
   elements in the stack, and YYPTR gives the new location of the
   stack.  Advance YYPTR to a properly aligned location for the next
   stack.  */
# define YYSTACK_RELOCATE(Stack_alloc, Stack)                           \
    do                                                                  \
      {                                                                 \
        YYSIZE_T yynewbytes;                                            \
        YYCOPY (&yyptr->Stack_alloc, Stack, yysize);                    \
        Stack = &yyptr->Stack_alloc;                                    \
        yynewbytes = yystacksize * sizeof (*Stack) + YYSTACK_GAP_MAXIMUM; \
        yyptr += yynewbytes / sizeof (*yyptr);                          \
      }                                                                 \
    while (0)

#endif

#if defined YYCOPY_NEEDED && YYCOPY_NEEDED
/* Copy COUNT objects from SRC to DST.  The source and destination do
   not overlap.  */
# ifndef YYCOPY
#  if defined __GNUC__ && 1 < __GNUC__
#   define YYCOPY(Dst, Src, Count) \
      __builtin_memcpy (Dst, Src, (Count) * sizeof (*(Src)))
#  else
#   define YYCOPY(Dst, Src, Count)              \
      do                                        \
        {                                       \
          YYSIZE_T yyi;                         \
          for (yyi = 0; yyi < (Count); yyi++)   \
            (Dst)[yyi] = (Src)[yyi];            \
        }                                       \
      while (0)
#  endif
# endif
#endif /* !YYCOPY_NEEDED */

/* YYFINAL -- State number of the termination state.  */
#define YYFINAL  2
/* YYLAST -- Last index in YYTABLE.  */
#define YYLAST   115

/* YYNTOKENS -- Number of terminals.  */
#define YYNTOKENS  64
/* YYNNTS -- Number of nonterminals.  */
#define YYNNTS  50
/* YYNRULES -- Number of rules.  */
#define YYNRULES  88
/* YYNSTATES -- Number of states.  */
#define YYNSTATES  143

/* YYTRANSLATE[YYX] -- Symbol number corresponding to YYX as returned
   by yylex, with out-of-bounds checking.  */
#define YYUNDEFTOK  2
#define YYMAXUTOK   318

#define YYTRANSLATE(YYX)                                                \
  ((unsigned int) (YYX) <= YYMAXUTOK ? yytranslate[YYX] : YYUNDEFTOK)

/* YYTRANSLATE[TOKEN-NUM] -- Symbol number corresponding to TOKEN-NUM
   as returned by yylex, without out-of-bounds checking.  */
static const yytype_uint8 yytranslate[] =
{
       0,     2,     2,     2,     2,     2,     2,     2,     2,     2,
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
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     2,     2,     2,     2,
       2,     2,     2,     2,     2,     2,     1,     2,     3,     4,
       5,     6,     7,     8,     9,    10,    11,    12,    13,    14,
      15,    16,    17,    18,    19,    20,    21,    22,    23,    24,
      25,    26,    27,    28,    29,    30,    31,    32,    33,    34,
      35,    36,    37,    38,    39,    40,    41,    42,    43,    44,
      45,    46,    47,    48,    49,    50,    51,    52,    53,    54,
      55,    56,    57,    58,    59,    60,    61,    62,    63
};

#if YYDEBUG
  /* YYRLINE[YYN] -- Source line where rule number YYN was defined.  */
static const yytype_uint16 yyrline[] =
{
       0,   101,   101,   103,   107,   108,   109,   110,   113,   114,
     119,   137,   140,   140,   144,   144,   150,   151,   153,   150,
     160,   163,   164,   167,   167,   170,   170,   178,   184,   188,
     190,   209,   214,   219,   220,   221,   222,   225,   233,   234,
     239,   238,   247,   246,   277,   277,   300,   301,   307,   315,
     326,   333,   349,   362,   372,   388,   389,   394,   395,   413,
     414,   415,   416,   417,   425,   433,   441,   449,   457,   465,
     473,   482,   491,   502,   533,   536,   536,   539,   542,   561,
     560,   568,   569,   570,   571,   572,   579,   581,   584
};
#endif

#if YYDEBUG || YYERROR_VERBOSE || 0
/* YYTNAME[SYMBOL-NUM] -- String name of the symbol SYMBOL-NUM.
   First, the terminals, then, starting at YYNTOKENS, nonterminals.  */
static const char *const yytname[] =
{
  "$end", "error", "$undefined", "UNIT_RES", "INHERITS", "SWITCH_RES",
  "GROUP_RES", "TYPE_RES", "INLET_RES", "OUTLET_RES", "STATE_RES", "COMMA",
  "SLOT_RES", "PARENTH_OPEN", "PARENTH_CLOSE", "CBRACKET_OPEN",
  "CBRACKET_CLOSE", "BRACKET_OPEN", "BRACKET_CLOSE", "BEHAVIOUR_RES", "AT",
  "PLUS", "DOT", "MINUSASSIGN", "MULTASSIGN", "GOTO_RES", "MINUS", "MULT",
  "DIVASSIGN", "NOTASSIGN", "PLUSASSIGN", "ON_RES", "EVENT_RES", "FOR_RES",
  "WHILE_RES", "IMMEDIATEFOR_RES", "IMMEDIATEWHILE_RES", "IMMEDIATE_RES",
  "OFTYPE_RES", "ENDTYPE_RES", "ENDUNT_RES", "INCOP", "DECOP", "COLON",
  "SEMICOLON", "COMPARATOR", "ASSIGN", "DEFAULT_RES", "IF_RES", "LESSTHAN",
  "GREATERTHAN", "COMPARE", "NOTIFY_RES", "EID_RES", "ENDSWITCH_RES",
  "ACTION_RES", "FUNCTION_RES", "SELF_RES", "STRING", "ID", "INTEGER",
  "BASIC_TYPE", "FLOAT", "DIV", "$accept", "ugliprogram", "declaration",
  "inheritance", "type", "unit", "$@1", "typedeclr", "$@2", "switch",
  "$@3", "$@4", "$@5", "group", "variables", "variable", "$@6", "$@7",
  "typebody", "switchinlet", "switchinlets", "switchbody", "groupbody",
  "parameters", "parameter", "function", "nonvoidfunction", "$@8",
  "voidfunction", "$@9", "block", "$@12", "sentences", "incassign",
  "decassign", "sentence", "assign", "constant", "expconstant",
  "expression", "variableref", "typedoutletdeclaration",
  "typedinletdeclaration", "$@14", "variabledeclaration",
  "eventdeclaration", "$@15", "property", "properties", "unitbody", YY_NULLPTR
};
#endif

# ifdef YYPRINT
/* YYTOKNUM[NUM] -- (External) token number corresponding to the
   (internal) symbol number NUM (which must be that of a token).  */
static const yytype_uint16 yytoknum[] =
{
       0,   256,   257,   258,   259,   260,   261,   262,   263,   264,
     265,   266,   267,   268,   269,   270,   271,   272,   273,   274,
     275,   276,   277,   278,   279,   280,   281,   282,   283,   284,
     285,   286,   287,   288,   289,   290,   291,   292,   293,   294,
     295,   296,   297,   298,   299,   300,   301,   302,   303,   304,
     305,   306,   307,   308,   309,   310,   311,   312,   313,   314,
     315,   316,   317,   318
};
# endif

#define YYPACT_NINF -91

#define yypact_value_is_default(Yystate) \
  (!!((Yystate) == (-91)))

#define YYTABLE_NINF -1

#define yytable_value_is_error(Yytable_value) \
  0

  /* YYPACT[STATE-NUM] -- Index in YYTABLE of the portion describing
     STATE-NUM.  */
static const yytype_int8 yypact[] =
{
     -91,    21,   -91,   -55,   -91,   -91,   -34,   -91,   -91,   -91,
     -91,   -91,   -91,   -21,   -91,   -91,    11,   -91,    14,   -18,
     -91,     9,     3,    17,    14,   -91,    38,   -91,    -8,    45,
      28,   -91,   -91,   -91,   -91,    39,    40,    58,    32,   -91,
     -91,    33,   -91,   -91,   -91,   -91,   -91,   -91,   -91,   -91,
     -91,   -91,    49,    50,   -91,    22,    36,    83,    23,   -91,
     -91,   -91,    22,    47,   -91,    41,   -91,    24,    90,    48,
      51,    44,    84,    61,     2,   -91,   -91,   -91,    62,    46,
     -91,   -91,    52,    63,   -91,   -91,    22,    41,    65,   -91,
      66,    68,   -91,   -91,   -91,   -91,    -3,   -91,   -91,   -10,
      95,   -91,    -5,   -91,    54,    54,   -91,   -91,   -91,   -91,
     -91,   -91,   -91,   -91,   -91,    19,   -24,   -91,    84,    -7,
     -91,   -91,    12,    12,    12,   -91,    12,   -91,   -91,    -5,
      84,   -91,   -91,   -91,   -91,   -91,   -91,   -91,   -91,   -91,
     -91,     8,   -91
};

  /* YYDEFACT[STATE-NUM] -- Default reduction number in state STATE-NUM.
     Performed when YYTABLE does not specify something else to do.  Zero
     means the default is an error.  */
static const yytype_uint8 yydefact[] =
{
       2,     0,     1,     0,    16,    32,     0,     3,     4,     5,
       6,     7,    12,     0,    20,    14,     8,    17,     0,     0,
      86,     0,     0,     0,    27,    21,     0,     9,    88,     0,
       0,    25,    23,    22,    15,     0,     0,     0,     0,    11,
      10,     0,    85,    38,    39,    83,    82,    81,    84,    87,
      13,    18,     0,     0,    75,     0,     0,     0,     0,    29,
      26,    24,     0,     0,    79,    33,    77,     0,    31,     0,
       0,     0,     0,     0,     0,    35,    55,    56,     0,     0,
      30,    19,     0,     0,    44,    80,     0,     0,     0,    78,
       0,     0,    74,    46,    37,    36,     0,    28,    76,     0,
       0,    40,     0,    45,     0,     0,    73,    57,    58,    53,
      61,    62,    47,    59,    60,     0,    72,    42,     0,     0,
      48,    50,     0,     0,     0,    52,     0,    49,    51,     0,
       0,    41,    71,    65,    66,    67,    68,    69,    70,    63,
      64,    54,    43
};

  /* YYPGOTO[NTERM-NUM].  */
static const yytype_int8 yypgoto[] =
{
     -91,   -91,   -91,   -91,   -53,   -91,   -91,   -91,   -91,   -91,
     -91,   -91,   -91,   -91,   -91,    91,   -91,   -91,   -91,   -91,
     -91,   -91,   -91,   -91,    27,   -91,   -91,   -91,   -91,   -91,
     -88,   -91,   -91,   -91,   -91,   -91,   -91,   -91,   -58,   -90,
     -44,   -91,   -91,   -91,   -91,   -91,   -91,   -91,   -91,   -91
};

  /* YYDEFGOTO[NTERM-NUM].  */
static const yytype_int16 yydefgoto[] =
{
      -1,     1,     7,    20,    41,     8,    16,     9,    18,    10,
      13,    21,    59,    11,    24,    25,    53,    52,    26,    80,
      68,    69,    14,    74,    75,    42,    43,   118,    44,   130,
      85,    93,    99,   110,   111,   112,   113,    78,   114,   115,
     116,    45,    46,    62,    47,    48,    72,    49,    28,    29
};

  /* YYTABLE[YYPACT[STATE-NUM]] -- What to do in state STATE-NUM.  If
     positive, shift that token.  If negative, reduce the rule whose
     number is the opposite.  If YYTABLE_NINF, syntax error.  */
static const yytype_uint8 yytable[] =
{
      35,    36,    63,   102,    12,    84,   103,   132,   102,    70,
     100,   109,   119,    87,   122,    19,    88,   127,   128,   123,
     124,     2,   129,    37,     3,    15,     4,     5,     6,   122,
     131,   104,   105,    94,   123,   124,   104,   105,    17,   141,
     122,    27,   142,   101,   126,   123,   124,    30,    38,   106,
     107,    39,   108,    40,   106,   107,    39,   108,    40,   126,
     120,   121,    31,   125,   133,   135,   137,    66,   139,    67,
     126,   106,   107,    22,   108,    23,    32,    34,   134,   136,
     138,    39,   140,    40,    76,    50,    77,    51,    54,    55,
      56,    57,    58,    60,    61,    64,    65,    71,    79,    84,
      73,    82,    81,    83,    86,    90,    89,    92,    96,   117,
      97,    91,    98,   106,    95,    33
};

static const yytype_uint8 yycheck[] =
{
       8,     9,    55,    13,    59,    15,    16,    14,    13,    62,
      13,    99,   102,    11,    21,     4,    14,    41,    42,    26,
      27,     0,    46,    31,     3,    59,     5,     6,     7,    21,
     118,    41,    42,    86,    26,    27,    41,    42,    59,   129,
      21,    59,   130,    96,    51,    26,    27,    38,    56,    59,
      60,    59,    62,    61,    59,    60,    59,    62,    61,    51,
     104,   105,    59,    44,   122,   123,   124,    44,   126,    46,
      51,    59,    60,    59,    62,    61,    59,    39,   122,   123,
     124,    59,   126,    61,    60,    40,    62,    59,    49,    49,
      32,    59,    59,    44,    44,    59,    13,    50,     8,    15,
      59,    50,    54,    59,    43,    59,    44,    44,    43,    14,
      44,    59,    44,    59,    87,    24
};

  /* YYSTOS[STATE-NUM] -- The (internal number of the) accessing
     symbol of state STATE-NUM.  */
static const yytype_uint8 yystos[] =
{
       0,    65,     0,     3,     5,     6,     7,    66,    69,    71,
      73,    77,    59,    74,    86,    59,    70,    59,    72,     4,
      67,    75,    59,    61,    78,    79,    82,    59,   112,   113,
      38,    59,    59,    79,    39,     8,     9,    31,    56,    59,
      61,    68,    89,    90,    92,   105,   106,   108,   109,   111,
      40,    59,    81,    80,    49,    49,    32,    59,    59,    76,
      44,    44,   107,    68,    59,    13,    44,    46,    84,    85,
      68,    50,   110,    59,    87,    88,    60,    62,   101,     8,
      83,    54,    50,    59,    15,    94,    43,    11,    14,    44,
      59,    59,    44,    95,    68,    88,    43,    44,    44,    96,
      13,    68,    13,    16,    41,    42,    59,    60,    62,    94,
      97,    98,    99,   100,   102,   103,   104,    14,    91,   103,
     104,   104,    21,    26,    27,    44,    51,    41,    42,    46,
      93,    94,    14,   102,   104,   102,   104,   102,   104,   102,
     104,   103,    94
};

  /* YYR1[YYN] -- Symbol number of symbol that rule YYN derives.  */
static const yytype_uint8 yyr1[] =
{
       0,    64,    65,    65,    66,    66,    66,    66,    67,    67,
      68,    68,    70,    69,    72,    71,    74,    75,    76,    73,
      77,    78,    78,    80,    79,    81,    79,    82,    83,    84,
      84,    85,    86,    87,    87,    87,    87,    88,    89,    89,
      91,    90,    93,    92,    95,    94,    96,    96,    97,    97,
      98,    98,    99,    99,   100,   101,   101,   102,   102,   103,
     103,   103,   103,   103,   103,   103,   103,   103,   103,   103,
     103,   103,   103,   104,   105,   107,   106,   108,   108,   110,
     109,   111,   111,   111,   111,   111,   112,   112,   113
};

  /* YYR2[YYN] -- Number of symbols on the right hand side of rule YYN.  */
static const yytype_uint8 yyr2[] =
{
       0,     2,     0,     2,     1,     1,     1,     1,     0,     2,
       1,     1,     0,     6,     0,     5,     0,     0,     0,     9,
       2,     1,     2,     0,     4,     0,     4,     1,     3,     0,
       2,     1,     0,     0,     0,     1,     3,     3,     1,     1,
       0,     9,     0,    10,     0,     4,     0,     2,     2,     2,
       2,     2,     2,     1,     3,     1,     1,     1,     1,     1,
       1,     1,     1,     3,     3,     3,     3,     3,     3,     3,
       3,     3,     1,     1,     6,     0,     7,     3,     5,     0,
       5,     1,     1,     1,     1,     1,     0,     2,     1
};


#define yyerrok         (yyerrstatus = 0)
#define yyclearin       (yychar = YYEMPTY)
#define YYEMPTY         (-2)
#define YYEOF           0

#define YYACCEPT        goto yyacceptlab
#define YYABORT         goto yyabortlab
#define YYERROR         goto yyerrorlab


#define YYRECOVERING()  (!!yyerrstatus)

#define YYBACKUP(Token, Value)                                  \
do                                                              \
  if (yychar == YYEMPTY)                                        \
    {                                                           \
      yychar = (Token);                                         \
      yylval = (Value);                                         \
      YYPOPSTACK (yylen);                                       \
      yystate = *yyssp;                                         \
      goto yybackup;                                            \
    }                                                           \
  else                                                          \
    {                                                           \
      yyerror (YY_("syntax error: cannot back up")); \
      YYERROR;                                                  \
    }                                                           \
while (0)

/* Error token number */
#define YYTERROR        1
#define YYERRCODE       256



/* Enable debugging if requested.  */
#if YYDEBUG

# ifndef YYFPRINTF
#  include <stdio.h> /* INFRINGES ON USER NAME SPACE */
#  define YYFPRINTF fprintf
# endif

# define YYDPRINTF(Args)                        \
do {                                            \
  if (yydebug)                                  \
    YYFPRINTF Args;                             \
} while (0)

/* This macro is provided for backward compatibility. */
#ifndef YY_LOCATION_PRINT
# define YY_LOCATION_PRINT(File, Loc) ((void) 0)
#endif


# define YY_SYMBOL_PRINT(Title, Type, Value, Location)                    \
do {                                                                      \
  if (yydebug)                                                            \
    {                                                                     \
      YYFPRINTF (stderr, "%s ", Title);                                   \
      yy_symbol_print (stderr,                                            \
                  Type, Value); \
      YYFPRINTF (stderr, "\n");                                           \
    }                                                                     \
} while (0)


/*----------------------------------------.
| Print this symbol's value on YYOUTPUT.  |
`----------------------------------------*/

static void
yy_symbol_value_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
{
  FILE *yyo = yyoutput;
  YYUSE (yyo);
  if (!yyvaluep)
    return;
# ifdef YYPRINT
  if (yytype < YYNTOKENS)
    YYPRINT (yyoutput, yytoknum[yytype], *yyvaluep);
# endif
  YYUSE (yytype);
}


/*--------------------------------.
| Print this symbol on YYOUTPUT.  |
`--------------------------------*/

static void
yy_symbol_print (FILE *yyoutput, int yytype, YYSTYPE const * const yyvaluep)
{
  YYFPRINTF (yyoutput, "%s %s (",
             yytype < YYNTOKENS ? "token" : "nterm", yytname[yytype]);

  yy_symbol_value_print (yyoutput, yytype, yyvaluep);
  YYFPRINTF (yyoutput, ")");
}

/*------------------------------------------------------------------.
| yy_stack_print -- Print the state stack from its BOTTOM up to its |
| TOP (included).                                                   |
`------------------------------------------------------------------*/

static void
yy_stack_print (yytype_int16 *yybottom, yytype_int16 *yytop)
{
  YYFPRINTF (stderr, "Stack now");
  for (; yybottom <= yytop; yybottom++)
    {
      int yybot = *yybottom;
      YYFPRINTF (stderr, " %d", yybot);
    }
  YYFPRINTF (stderr, "\n");
}

# define YY_STACK_PRINT(Bottom, Top)                            \
do {                                                            \
  if (yydebug)                                                  \
    yy_stack_print ((Bottom), (Top));                           \
} while (0)


/*------------------------------------------------.
| Report that the YYRULE is going to be reduced.  |
`------------------------------------------------*/

static void
yy_reduce_print (yytype_int16 *yyssp, YYSTYPE *yyvsp, int yyrule)
{
  unsigned long int yylno = yyrline[yyrule];
  int yynrhs = yyr2[yyrule];
  int yyi;
  YYFPRINTF (stderr, "Reducing stack by rule %d (line %lu):\n",
             yyrule - 1, yylno);
  /* The symbols being reduced.  */
  for (yyi = 0; yyi < yynrhs; yyi++)
    {
      YYFPRINTF (stderr, "   $%d = ", yyi + 1);
      yy_symbol_print (stderr,
                       yystos[yyssp[yyi + 1 - yynrhs]],
                       &(yyvsp[(yyi + 1) - (yynrhs)])
                                              );
      YYFPRINTF (stderr, "\n");
    }
}

# define YY_REDUCE_PRINT(Rule)          \
do {                                    \
  if (yydebug)                          \
    yy_reduce_print (yyssp, yyvsp, Rule); \
} while (0)

/* Nonzero means print parse trace.  It is left uninitialized so that
   multiple parsers can coexist.  */
int yydebug;
#else /* !YYDEBUG */
# define YYDPRINTF(Args)
# define YY_SYMBOL_PRINT(Title, Type, Value, Location)
# define YY_STACK_PRINT(Bottom, Top)
# define YY_REDUCE_PRINT(Rule)
#endif /* !YYDEBUG */


/* YYINITDEPTH -- initial size of the parser's stacks.  */
#ifndef YYINITDEPTH
# define YYINITDEPTH 200
#endif

/* YYMAXDEPTH -- maximum size the stacks can grow to (effective only
   if the built-in stack extension method is used).

   Do not make this value too large; the results are undefined if
   YYSTACK_ALLOC_MAXIMUM < YYSTACK_BYTES (YYMAXDEPTH)
   evaluated with infinite-precision integer arithmetic.  */

#ifndef YYMAXDEPTH
# define YYMAXDEPTH 10000
#endif


#if YYERROR_VERBOSE

# ifndef yystrlen
#  if defined __GLIBC__ && defined _STRING_H
#   define yystrlen strlen
#  else
/* Return the length of YYSTR.  */
static YYSIZE_T
yystrlen (const char *yystr)
{
  YYSIZE_T yylen;
  for (yylen = 0; yystr[yylen]; yylen++)
    continue;
  return yylen;
}
#  endif
# endif

# ifndef yystpcpy
#  if defined __GLIBC__ && defined _STRING_H && defined _GNU_SOURCE
#   define yystpcpy stpcpy
#  else
/* Copy YYSRC to YYDEST, returning the address of the terminating '\0' in
   YYDEST.  */
static char *
yystpcpy (char *yydest, const char *yysrc)
{
  char *yyd = yydest;
  const char *yys = yysrc;

  while ((*yyd++ = *yys++) != '\0')
    continue;

  return yyd - 1;
}
#  endif
# endif

# ifndef yytnamerr
/* Copy to YYRES the contents of YYSTR after stripping away unnecessary
   quotes and backslashes, so that it's suitable for yyerror.  The
   heuristic is that double-quoting is unnecessary unless the string
   contains an apostrophe, a comma, or backslash (other than
   backslash-backslash).  YYSTR is taken from yytname.  If YYRES is
   null, do not copy; instead, return the length of what the result
   would have been.  */
static YYSIZE_T
yytnamerr (char *yyres, const char *yystr)
{
  if (*yystr == '"')
    {
      YYSIZE_T yyn = 0;
      char const *yyp = yystr;

      for (;;)
        switch (*++yyp)
          {
          case '\'':
          case ',':
            goto do_not_strip_quotes;

          case '\\':
            if (*++yyp != '\\')
              goto do_not_strip_quotes;
            /* Fall through.  */
          default:
            if (yyres)
              yyres[yyn] = *yyp;
            yyn++;
            break;

          case '"':
            if (yyres)
              yyres[yyn] = '\0';
            return yyn;
          }
    do_not_strip_quotes: ;
    }

  if (! yyres)
    return yystrlen (yystr);

  return yystpcpy (yyres, yystr) - yyres;
}
# endif

/* Copy into *YYMSG, which is of size *YYMSG_ALLOC, an error message
   about the unexpected token YYTOKEN for the state stack whose top is
   YYSSP.

   Return 0 if *YYMSG was successfully written.  Return 1 if *YYMSG is
   not large enough to hold the message.  In that case, also set
   *YYMSG_ALLOC to the required number of bytes.  Return 2 if the
   required number of bytes is too large to store.  */
static int
yysyntax_error (YYSIZE_T *yymsg_alloc, char **yymsg,
                yytype_int16 *yyssp, int yytoken)
{
  YYSIZE_T yysize0 = yytnamerr (YY_NULLPTR, yytname[yytoken]);
  YYSIZE_T yysize = yysize0;
  enum { YYERROR_VERBOSE_ARGS_MAXIMUM = 5 };
  /* Internationalized format string. */
  const char *yyformat = YY_NULLPTR;
  /* Arguments of yyformat. */
  char const *yyarg[YYERROR_VERBOSE_ARGS_MAXIMUM];
  /* Number of reported tokens (one for the "unexpected", one per
     "expected"). */
  int yycount = 0;

  /* There are many possibilities here to consider:
     - If this state is a consistent state with a default action, then
       the only way this function was invoked is if the default action
       is an error action.  In that case, don't check for expected
       tokens because there are none.
     - The only way there can be no lookahead present (in yychar) is if
       this state is a consistent state with a default action.  Thus,
       detecting the absence of a lookahead is sufficient to determine
       that there is no unexpected or expected token to report.  In that
       case, just report a simple "syntax error".
     - Don't assume there isn't a lookahead just because this state is a
       consistent state with a default action.  There might have been a
       previous inconsistent state, consistent state with a non-default
       action, or user semantic action that manipulated yychar.
     - Of course, the expected token list depends on states to have
       correct lookahead information, and it depends on the parser not
       to perform extra reductions after fetching a lookahead from the
       scanner and before detecting a syntax error.  Thus, state merging
       (from LALR or IELR) and default reductions corrupt the expected
       token list.  However, the list is correct for canonical LR with
       one exception: it will still contain any token that will not be
       accepted due to an error action in a later state.
  */
  if (yytoken != YYEMPTY)
    {
      int yyn = yypact[*yyssp];
      yyarg[yycount++] = yytname[yytoken];
      if (!yypact_value_is_default (yyn))
        {
          /* Start YYX at -YYN if negative to avoid negative indexes in
             YYCHECK.  In other words, skip the first -YYN actions for
             this state because they are default actions.  */
          int yyxbegin = yyn < 0 ? -yyn : 0;
          /* Stay within bounds of both yycheck and yytname.  */
          int yychecklim = YYLAST - yyn + 1;
          int yyxend = yychecklim < YYNTOKENS ? yychecklim : YYNTOKENS;
          int yyx;

          for (yyx = yyxbegin; yyx < yyxend; ++yyx)
            if (yycheck[yyx + yyn] == yyx && yyx != YYTERROR
                && !yytable_value_is_error (yytable[yyx + yyn]))
              {
                if (yycount == YYERROR_VERBOSE_ARGS_MAXIMUM)
                  {
                    yycount = 1;
                    yysize = yysize0;
                    break;
                  }
                yyarg[yycount++] = yytname[yyx];
                {
                  YYSIZE_T yysize1 = yysize + yytnamerr (YY_NULLPTR, yytname[yyx]);
                  if (! (yysize <= yysize1
                         && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
                    return 2;
                  yysize = yysize1;
                }
              }
        }
    }

  switch (yycount)
    {
# define YYCASE_(N, S)                      \
      case N:                               \
        yyformat = S;                       \
      break
      YYCASE_(0, YY_("syntax error"));
      YYCASE_(1, YY_("syntax error, unexpected %s"));
      YYCASE_(2, YY_("syntax error, unexpected %s, expecting %s"));
      YYCASE_(3, YY_("syntax error, unexpected %s, expecting %s or %s"));
      YYCASE_(4, YY_("syntax error, unexpected %s, expecting %s or %s or %s"));
      YYCASE_(5, YY_("syntax error, unexpected %s, expecting %s or %s or %s or %s"));
# undef YYCASE_
    }

  {
    YYSIZE_T yysize1 = yysize + yystrlen (yyformat);
    if (! (yysize <= yysize1 && yysize1 <= YYSTACK_ALLOC_MAXIMUM))
      return 2;
    yysize = yysize1;
  }

  if (*yymsg_alloc < yysize)
    {
      *yymsg_alloc = 2 * yysize;
      if (! (yysize <= *yymsg_alloc
             && *yymsg_alloc <= YYSTACK_ALLOC_MAXIMUM))
        *yymsg_alloc = YYSTACK_ALLOC_MAXIMUM;
      return 1;
    }

  /* Avoid sprintf, as that infringes on the user's name space.
     Don't have undefined behavior even if the translation
     produced a string with the wrong number of "%s"s.  */
  {
    char *yyp = *yymsg;
    int yyi = 0;
    while ((*yyp = *yyformat) != '\0')
      if (*yyp == '%' && yyformat[1] == 's' && yyi < yycount)
        {
          yyp += yytnamerr (yyp, yyarg[yyi++]);
          yyformat += 2;
        }
      else
        {
          yyp++;
          yyformat++;
        }
  }
  return 0;
}
#endif /* YYERROR_VERBOSE */

/*-----------------------------------------------.
| Release the memory associated to this symbol.  |
`-----------------------------------------------*/

static void
yydestruct (const char *yymsg, int yytype, YYSTYPE *yyvaluep)
{
  YYUSE (yyvaluep);
  if (!yymsg)
    yymsg = "Deleting";
  YY_SYMBOL_PRINT (yymsg, yytype, yyvaluep, yylocationp);

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  YYUSE (yytype);
  YY_IGNORE_MAYBE_UNINITIALIZED_END
}




/* The lookahead symbol.  */
int yychar;

/* The semantic value of the lookahead symbol.  */
YYSTYPE yylval;
/* Number of syntax errors so far.  */
int yynerrs;


/*----------.
| yyparse.  |
`----------*/

int
yyparse (void)
{
    int yystate;
    /* Number of tokens to shift before error messages enabled.  */
    int yyerrstatus;

    /* The stacks and their tools:
       'yyss': related to states.
       'yyvs': related to semantic values.

       Refer to the stacks through separate pointers, to allow yyoverflow
       to reallocate them elsewhere.  */

    /* The state stack.  */
    yytype_int16 yyssa[YYINITDEPTH];
    yytype_int16 *yyss;
    yytype_int16 *yyssp;

    /* The semantic value stack.  */
    YYSTYPE yyvsa[YYINITDEPTH];
    YYSTYPE *yyvs;
    YYSTYPE *yyvsp;

    YYSIZE_T yystacksize;

  int yyn;
  int yyresult;
  /* Lookahead token as an internal (translated) token number.  */
  int yytoken = 0;
  /* The variables used to return semantic value and location from the
     action routines.  */
  YYSTYPE yyval;

#if YYERROR_VERBOSE
  /* Buffer for error messages, and its allocated size.  */
  char yymsgbuf[128];
  char *yymsg = yymsgbuf;
  YYSIZE_T yymsg_alloc = sizeof yymsgbuf;
#endif

#define YYPOPSTACK(N)   (yyvsp -= (N), yyssp -= (N))

  /* The number of symbols on the RHS of the reduced rule.
     Keep to zero when no symbol should be popped.  */
  int yylen = 0;

  yyssp = yyss = yyssa;
  yyvsp = yyvs = yyvsa;
  yystacksize = YYINITDEPTH;

  YYDPRINTF ((stderr, "Starting parse\n"));

  yystate = 0;
  yyerrstatus = 0;
  yynerrs = 0;
  yychar = YYEMPTY; /* Cause a token to be read.  */
  goto yysetstate;

/*------------------------------------------------------------.
| yynewstate -- Push a new state, which is found in yystate.  |
`------------------------------------------------------------*/
 yynewstate:
  /* In all cases, when you get here, the value and location stacks
     have just been pushed.  So pushing a state here evens the stacks.  */
  yyssp++;

 yysetstate:
  *yyssp = yystate;

  if (yyss + yystacksize - 1 <= yyssp)
    {
      /* Get the current used size of the three stacks, in elements.  */
      YYSIZE_T yysize = yyssp - yyss + 1;

#ifdef yyoverflow
      {
        /* Give user a chance to reallocate the stack.  Use copies of
           these so that the &'s don't force the real ones into
           memory.  */
        YYSTYPE *yyvs1 = yyvs;
        yytype_int16 *yyss1 = yyss;

        /* Each stack pointer address is followed by the size of the
           data in use in that stack, in bytes.  This used to be a
           conditional around just the two extra args, but that might
           be undefined if yyoverflow is a macro.  */
        yyoverflow (YY_("memory exhausted"),
                    &yyss1, yysize * sizeof (*yyssp),
                    &yyvs1, yysize * sizeof (*yyvsp),
                    &yystacksize);

        yyss = yyss1;
        yyvs = yyvs1;
      }
#else /* no yyoverflow */
# ifndef YYSTACK_RELOCATE
      goto yyexhaustedlab;
# else
      /* Extend the stack our own way.  */
      if (YYMAXDEPTH <= yystacksize)
        goto yyexhaustedlab;
      yystacksize *= 2;
      if (YYMAXDEPTH < yystacksize)
        yystacksize = YYMAXDEPTH;

      {
        yytype_int16 *yyss1 = yyss;
        union yyalloc *yyptr =
          (union yyalloc *) YYSTACK_ALLOC (YYSTACK_BYTES (yystacksize));
        if (! yyptr)
          goto yyexhaustedlab;
        YYSTACK_RELOCATE (yyss_alloc, yyss);
        YYSTACK_RELOCATE (yyvs_alloc, yyvs);
#  undef YYSTACK_RELOCATE
        if (yyss1 != yyssa)
          YYSTACK_FREE (yyss1);
      }
# endif
#endif /* no yyoverflow */

      yyssp = yyss + yysize - 1;
      yyvsp = yyvs + yysize - 1;

      YYDPRINTF ((stderr, "Stack size increased to %lu\n",
                  (unsigned long int) yystacksize));

      if (yyss + yystacksize - 1 <= yyssp)
        YYABORT;
    }

  YYDPRINTF ((stderr, "Entering state %d\n", yystate));

  if (yystate == YYFINAL)
    YYACCEPT;

  goto yybackup;

/*-----------.
| yybackup.  |
`-----------*/
yybackup:

  /* Do appropriate processing given the current state.  Read a
     lookahead token if we need one and don't already have one.  */

  /* First try to decide what to do without reference to lookahead token.  */
  yyn = yypact[yystate];
  if (yypact_value_is_default (yyn))
    goto yydefault;

  /* Not known => get a lookahead token if don't already have one.  */

  /* YYCHAR is either YYEMPTY or YYEOF or a valid lookahead symbol.  */
  if (yychar == YYEMPTY)
    {
      YYDPRINTF ((stderr, "Reading a token: "));
      yychar = yylex ();
    }

  if (yychar <= YYEOF)
    {
      yychar = yytoken = YYEOF;
      YYDPRINTF ((stderr, "Now at end of input.\n"));
    }
  else
    {
      yytoken = YYTRANSLATE (yychar);
      YY_SYMBOL_PRINT ("Next token is", yytoken, &yylval, &yylloc);
    }

  /* If the proper action on seeing token YYTOKEN is to reduce or to
     detect an error, take that action.  */
  yyn += yytoken;
  if (yyn < 0 || YYLAST < yyn || yycheck[yyn] != yytoken)
    goto yydefault;
  yyn = yytable[yyn];
  if (yyn <= 0)
    {
      if (yytable_value_is_error (yyn))
        goto yyerrlab;
      yyn = -yyn;
      goto yyreduce;
    }

  /* Count tokens shifted since error; after three, turn off error
     status.  */
  if (yyerrstatus)
    yyerrstatus--;

  /* Shift the lookahead token.  */
  YY_SYMBOL_PRINT ("Shifting", yytoken, &yylval, &yylloc);

  /* Discard the shifted token.  */
  yychar = YYEMPTY;

  yystate = yyn;
  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END

  goto yynewstate;


/*-----------------------------------------------------------.
| yydefault -- do the default action for the current state.  |
`-----------------------------------------------------------*/
yydefault:
  yyn = yydefact[yystate];
  if (yyn == 0)
    goto yyerrlab;
  goto yyreduce;


/*-----------------------------.
| yyreduce -- Do a reduction.  |
`-----------------------------*/
yyreduce:
  /* yyn is the number of a rule to reduce with.  */
  yylen = yyr2[yyn];

  /* If YYLEN is nonzero, implement the default value of the action:
     '$$ = $1'.

     Otherwise, the following line sets YYVAL to garbage.
     This behavior is undocumented and Bison
     users should not rely upon it.  Assigning to YYVAL
     unconditionally makes the parser a bit smaller, and it avoids a
     GCC warning that YYVAL may be used uninitialized.  */
  yyval = yyvsp[1-yylen];


  YY_REDUCE_PRINT (yyn);
  switch (yyn)
    {
        case 9:
#line 114 "ugli.y" /* yacc.c:1646  */
    { internal_setUnitSuper((yyvsp[0].str));
    }
#line 1501 "y.tab.c" /* yacc.c:1646  */
    break;

  case 10:
#line 119 "ugli.y" /* yacc.c:1646  */
    { printf("basic type detected: ");
      /*switch($1) {
          case TYPE_INT:
          printf("int");
          strcpy($$, "int");
          break;
          case TYPE_FLOAT:
          printf("float");
          strcpy($$, "float");
          break;
          case TYPE_STRING:
          printf("string");
          strcpy($$, "string");
          break;
      }*/
      printf("\n");
      
  }
#line 1524 "y.tab.c" /* yacc.c:1646  */
    break;

  case 11:
#line 137 "ugli.y" /* yacc.c:1646  */
    { printf("compound type detected: %s \n", (yyvsp[0].str)); strcpy((yyval.str), (yyvsp[0].str)); }
#line 1530 "y.tab.c" /* yacc.c:1646  */
    break;

  case 12:
#line 140 "ugli.y" /* yacc.c:1646  */
    { internal_addNewUnit((yyvsp[0].str)); incScope(); }
#line 1536 "y.tab.c" /* yacc.c:1646  */
    break;

  case 13:
#line 140 "ugli.y" /* yacc.c:1646  */
    {printf("A complete UNIT\n"); decScope(); }
#line 1542 "y.tab.c" /* yacc.c:1646  */
    break;

  case 14:
#line 144 "ugli.y" /* yacc.c:1646  */
    { internal_addNewType(); internal_setTypeName((yyvsp[0].str));  }
#line 1548 "y.tab.c" /* yacc.c:1646  */
    break;

  case 15:
#line 146 "ugli.y" /* yacc.c:1646  */
    { printf("A complete Type declared!");  }
#line 1554 "y.tab.c" /* yacc.c:1646  */
    break;

  case 16:
#line 150 "ugli.y" /* yacc.c:1646  */
    { internal_addNewSwitch(); }
#line 1560 "y.tab.c" /* yacc.c:1646  */
    break;

  case 17:
#line 151 "ugli.y" /* yacc.c:1646  */
    { internal_setSwitchName((yyvsp[0].str));
    }
#line 1567 "y.tab.c" /* yacc.c:1646  */
    break;

  case 18:
#line 153 "ugli.y" /* yacc.c:1646  */
    { internal_setCurrentSwitchTypeName((yyvsp[0].str));
    }
#line 1574 "y.tab.c" /* yacc.c:1646  */
    break;

  case 19:
#line 157 "ugli.y" /* yacc.c:1646  */
    { printf("A complete Switch declared!"); }
#line 1580 "y.tab.c" /* yacc.c:1646  */
    break;

  case 23:
#line 167 "ugli.y" /* yacc.c:1646  */
    { //printf("Basic type var: %s\n\n\n", $1);
    internal_addBasicVarToCurrentType((yyvsp[-1].str), (yyvsp[0].str));
}
#line 1588 "y.tab.c" /* yacc.c:1646  */
    break;

  case 25:
#line 170 "ugli.y" /* yacc.c:1646  */
    { internal_addCompoundVarToCurrentType((yyvsp[-1].str), (yyvsp[0].str)); }
#line 1594 "y.tab.c" /* yacc.c:1646  */
    break;

  case 28:
#line 184 "ugli.y" /* yacc.c:1646  */
    { internal_addNewInletToSwitch(); internal_setCurrentSwitchInletName((yyvsp[-1].str)); }
#line 1600 "y.tab.c" /* yacc.c:1646  */
    break;

  case 40:
#line 239 "ugli.y" /* yacc.c:1646  */
    { curContext = CONTEXT_FUNCTION;
        internal_addNewFunction(); }
#line 1607 "y.tab.c" /* yacc.c:1646  */
    break;

  case 41:
#line 242 "ugli.y" /* yacc.c:1646  */
    { printf("Congrats: a new function is born!\n"); }
#line 1613 "y.tab.c" /* yacc.c:1646  */
    break;

  case 42:
#line 247 "ugli.y" /* yacc.c:1646  */
    { curContext = CONTEXT_FUNCTION;
        internal_addNewFunction(); }
#line 1620 "y.tab.c" /* yacc.c:1646  */
    break;

  case 43:
#line 250 "ugli.y" /* yacc.c:1646  */
    { printf("Congrats: a new -void- function is born!\n"); }
#line 1626 "y.tab.c" /* yacc.c:1646  */
    break;

  case 44:
#line 277 "ugli.y" /* yacc.c:1646  */
    { printf("cbracket open   "); }
#line 1632 "y.tab.c" /* yacc.c:1646  */
    break;

  case 45:
#line 279 "ugli.y" /* yacc.c:1646  */
    { printf("cbracket close   "); }
#line 1638 "y.tab.c" /* yacc.c:1646  */
    break;

  case 48:
#line 307 "ugli.y" /* yacc.c:1646  */
    {
        internal_addNewInstruction(curContext);
        internal_setInstructionOp(INSTR_PREINC);
        internal_generateNewTempVarName(tempVarNames);
        internal_setDest(tempVarNames);
        internal_setSrc1((yyvsp[0].str), SRC_VAR);
        strcpy((yyval.str), tempVarNames);
    }
#line 1651 "y.tab.c" /* yacc.c:1646  */
    break;

  case 49:
#line 315 "ugli.y" /* yacc.c:1646  */
    {
        internal_addNewInstruction(curContext);
        internal_setInstructionOp(INSTR_POSTINC);
        internal_generateNewTempVarName(tempVarNames);
        internal_setDest(tempVarNames);
        internal_setSrc1((yyvsp[-1].str), SRC_VAR);
        strcpy((yyval.str), tempVarNames);
    }
#line 1664 "y.tab.c" /* yacc.c:1646  */
    break;

  case 50:
#line 326 "ugli.y" /* yacc.c:1646  */
    {
    internal_addNewInstruction(curContext);
    internal_setInstructionOp(INSTR_SUB);
    internal_setDest((yyvsp[0].str));
    internal_setSrc1((yyvsp[0].str), SRC_VAR); internal_setSrc2("1", SRC_IMMEDIATE);
    strcpy((yyval.str), (yyvsp[0].str));
}
#line 1676 "y.tab.c" /* yacc.c:1646  */
    break;

  case 51:
#line 333 "ugli.y" /* yacc.c:1646  */
    {
    internal_addNewInstruction(curContext);
    internal_setInstructionOp(INSTR_ASSIGN);
    internal_generateNewTempVarName(tempVarNames);
    internal_setDest(tempVarNames);
    internal_setSrc1((yyvsp[-1].str));
    internal_addNewInstruction(curContext);
    internal_setInstructionOp(INSTR_SUB);
    internal_setDest((yyvsp[-1].str));
    internal_setSrc1((yyvsp[-1].str), SRC_VAR); internal_setSrc2("1", SRC_IMMEDIATE);
    strcpy((yyval.str), tempVarNames);
}
#line 1693 "y.tab.c" /* yacc.c:1646  */
    break;

  case 52:
#line 349 "ugli.y" /* yacc.c:1646  */
    {
        internal_addNewInstruction(curContext);
        internal_setInstructionOp(INSTR_EOI);
        internal_setSrc1((yyvsp[-1].str));
        resetTmpVarCounter();
    }
#line 1704 "y.tab.c" /* yacc.c:1646  */
    break;

  case 54:
#line 372 "ugli.y" /* yacc.c:1646  */
    {
        internal_addNewInstruction(curContext);
        internal_setInstructionOp(INSTR_ASSIGN);
        internal_setDest((yyvsp[-2].str));
        internal_setSrc1((yyvsp[0].str));
        strcpy((yyval.str), (yyvsp[-2].str));
        
    }
#line 1717 "y.tab.c" /* yacc.c:1646  */
    break;

  case 55:
#line 388 "ugli.y" /* yacc.c:1646  */
    { (yyval.Integer) = (yyvsp[0].Integer); typeOfLastConstant = TYPE_INT; printf("... int detected %d\n", (yyvsp[0].Integer)); }
#line 1723 "y.tab.c" /* yacc.c:1646  */
    break;

  case 56:
#line 389 "ugli.y" /* yacc.c:1646  */
    { (yyval.Float) = (yyvsp[0].Float); typeOfLastConstant = TYPE_FLOAT; printf("... float detected %g\n", (yyvsp[0].Float)); }
#line 1729 "y.tab.c" /* yacc.c:1646  */
    break;

  case 57:
#line 394 "ugli.y" /* yacc.c:1646  */
    { sprintf((yyval.str), "%d", (yyvsp[0].Integer)); }
#line 1735 "y.tab.c" /* yacc.c:1646  */
    break;

  case 58:
#line 395 "ugli.y" /* yacc.c:1646  */
    { sprintf((yyval.str), "%g", (yyvsp[0].Float)); }
#line 1741 "y.tab.c" /* yacc.c:1646  */
    break;

  case 59:
#line 413 "ugli.y" /* yacc.c:1646  */
    { strcpy((yyval.str), (yyvsp[0].str));  }
#line 1747 "y.tab.c" /* yacc.c:1646  */
    break;

  case 60:
#line 414 "ugli.y" /* yacc.c:1646  */
    { strcpy((yyval.str), (yyvsp[0].str)); }
#line 1753 "y.tab.c" /* yacc.c:1646  */
    break;

  case 61:
#line 415 "ugli.y" /* yacc.c:1646  */
    { strcpy((yyval.str), (yyvsp[0].str)); }
#line 1759 "y.tab.c" /* yacc.c:1646  */
    break;

  case 62:
#line 416 "ugli.y" /* yacc.c:1646  */
    { strcpy((yyval.str), (yyvsp[0].str)); }
#line 1765 "y.tab.c" /* yacc.c:1646  */
    break;

  case 63:
#line 417 "ugli.y" /* yacc.c:1646  */
    {
        internal_addNewInstruction(curContext);
        internal_setInstructionOp(INSTR_COMPARE);
        internal_generateNewTempVarName(tempVarNames);
        internal_setDest(tempVarNames);
        internal_setSrc1((yyvsp[-2].str), SRC_VAR); internal_setSrc2((yyvsp[0].str), SRC_IMMEDIATE);
        strcpy((yyval.str), tempVarNames);
    }
#line 1778 "y.tab.c" /* yacc.c:1646  */
    break;

  case 64:
#line 425 "ugli.y" /* yacc.c:1646  */
    {
        internal_addNewInstruction(curContext);
        internal_setInstructionOp(INSTR_COMPARE);
        internal_generateNewTempVarName(tempVarNames);
        internal_setDest(tempVarNames);
        internal_setSrc1((yyvsp[-2].str), SRC_VAR); internal_setSrc2((yyvsp[0].str), SRC_VAR);
        strcpy((yyval.str), tempVarNames);
    }
#line 1791 "y.tab.c" /* yacc.c:1646  */
    break;

  case 65:
#line 433 "ugli.y" /* yacc.c:1646  */
    {
        internal_addNewInstruction(curContext);
        internal_setInstructionOp(INSTR_ADD);
        internal_generateNewTempVarName(tempVarNames);
        internal_setDest(tempVarNames);
        internal_setSrc1((yyvsp[-2].str), SRC_VAR); internal_setSrc2((yyvsp[0].str), SRC_IMMEDIATE);
        strcpy((yyval.str), tempVarNames);
    }
#line 1804 "y.tab.c" /* yacc.c:1646  */
    break;

  case 66:
#line 441 "ugli.y" /* yacc.c:1646  */
    {
        internal_addNewInstruction(curContext);
        internal_setInstructionOp(INSTR_ADD);
        internal_generateNewTempVarName(tempVarNames);
        internal_setDest(tempVarNames);
        internal_setSrc1((yyvsp[-2].str), SRC_VAR); internal_setSrc2((yyvsp[0].str), SRC_VAR);
        strcpy((yyval.str), tempVarNames);
    }
#line 1817 "y.tab.c" /* yacc.c:1646  */
    break;

  case 67:
#line 449 "ugli.y" /* yacc.c:1646  */
    {
        internal_addNewInstruction(curContext);
        internal_setInstructionOp(INSTR_SUB);
        internal_generateNewTempVarName(tempVarNames);
        internal_setDest(tempVarNames);
        internal_setSrc1((yyvsp[-2].str), SRC_VAR); internal_setSrc2((yyvsp[0].str), SRC_IMMEDIATE);
        strcpy((yyval.str), tempVarNames);
    }
#line 1830 "y.tab.c" /* yacc.c:1646  */
    break;

  case 68:
#line 457 "ugli.y" /* yacc.c:1646  */
    {
        internal_addNewInstruction(curContext);
        internal_setInstructionOp(INSTR_SUB);
        internal_generateNewTempVarName(tempVarNames);
        internal_setDest(tempVarNames);
        internal_setSrc1((yyvsp[-2].str), SRC_VAR); internal_setSrc2((yyvsp[0].str), SRC_VAR);
        strcpy((yyval.str), tempVarNames);
    }
#line 1843 "y.tab.c" /* yacc.c:1646  */
    break;

  case 69:
#line 465 "ugli.y" /* yacc.c:1646  */
    {
        internal_addNewInstruction(curContext);
        internal_setInstructionOp(INSTR_MULT);
        internal_generateNewTempVarName(tempVarNames);
        internal_setDest(tempVarNames);
        internal_setSrc1((yyvsp[-2].str), SRC_VAR); internal_setSrc2((yyvsp[0].str), SRC_IMMEDIATE);
        strcpy((yyval.str), tempVarNames);
    }
#line 1856 "y.tab.c" /* yacc.c:1646  */
    break;

  case 70:
#line 473 "ugli.y" /* yacc.c:1646  */
    {
        internal_addNewInstruction(curContext);
        internal_setInstructionOp(INSTR_MULT);
        internal_generateNewTempVarName(tempVarNames);
        internal_setDest(tempVarNames);
        internal_setSrc1((yyvsp[-2].str), SRC_VAR); internal_setSrc2((yyvsp[0].str), SRC_VAR);
        strcpy((yyval.str), tempVarNames);
    }
#line 1869 "y.tab.c" /* yacc.c:1646  */
    break;

  case 71:
#line 482 "ugli.y" /* yacc.c:1646  */
    {
        internal_addNewInstruction(curContext);
        internal_setInstructionOp(INSTR_ASSIGN);
        internal_generateNewTempVarName(tempVarNames);
        internal_setDest(tempVarNames);
        internal_setSrc1((yyvsp[-1].str), SRC_VAR);
        strcpy((yyval.str), tempVarNames);
    }
#line 1882 "y.tab.c" /* yacc.c:1646  */
    break;

  case 72:
#line 491 "ugli.y" /* yacc.c:1646  */
    { strcpy((yyval.str), (yyvsp[0].str)); }
#line 1888 "y.tab.c" /* yacc.c:1646  */
    break;

  case 73:
#line 502 "ugli.y" /* yacc.c:1646  */
    { printf("Reference to variable detected\n"); strcpy((yyval.str), (yyvsp[0].str)); }
#line 1894 "y.tab.c" /* yacc.c:1646  */
    break;

  case 74:
#line 533 "ugli.y" /* yacc.c:1646  */
    {printf("A typed outlet\n"); }
#line 1900 "y.tab.c" /* yacc.c:1646  */
    break;

  case 75:
#line 536 "ugli.y" /* yacc.c:1646  */
    {printf("inlet <\n");}
#line 1906 "y.tab.c" /* yacc.c:1646  */
    break;

  case 76:
#line 536 "ugli.y" /* yacc.c:1646  */
    {printf("A typed inlet\n"); }
#line 1912 "y.tab.c" /* yacc.c:1646  */
    break;

  case 77:
#line 539 "ugli.y" /* yacc.c:1646  */
    { internal_unitAddNewVariable((yyvsp[-1].str), (yyvsp[-2].str), 1);
    }
#line 1919 "y.tab.c" /* yacc.c:1646  */
    break;

  case 78:
#line 542 "ugli.y" /* yacc.c:1646  */
    {
        printf("Type of last constant: %d ", typeOfLastConstant);
        internal_unitAddNewVariable((yyvsp[-3].str), (yyvsp[-4].str), 1);
       switch(typeOfLastConstant) {
            case TYPE_INT:
              printf("and value of $<Integer>4: %d\n", (yyvsp[-1].Integer));
                internal_unitSetVariableInitialValue_int((yyvsp[-1].Integer));
                break;
            case TYPE_FLOAT:
               printf("and value of $<Float>4: %g\n", (yyvsp[-1].Float));
                internal_unitSetVariableInitialValue_float((yyvsp[-1].Float));
                break;
        }
    }
#line 1938 "y.tab.c" /* yacc.c:1646  */
    break;

  case 79:
#line 561 "ugli.y" /* yacc.c:1646  */
    {printf("event detected\n"); curContext = CONTEXT_EVENTHANDLER;
        internal_addNewEvent();
        internal_setEventName((yyvsp[0].str));
        incScope(); }
#line 1947 "y.tab.c" /* yacc.c:1646  */
    break;

  case 80:
#line 565 "ugli.y" /* yacc.c:1646  */
    { printf("Event terminado\n"); decScope();}
#line 1953 "y.tab.c" /* yacc.c:1646  */
    break;


#line 1957 "y.tab.c" /* yacc.c:1646  */
      default: break;
    }
  /* User semantic actions sometimes alter yychar, and that requires
     that yytoken be updated with the new translation.  We take the
     approach of translating immediately before every use of yytoken.
     One alternative is translating here after every semantic action,
     but that translation would be missed if the semantic action invokes
     YYABORT, YYACCEPT, or YYERROR immediately after altering yychar or
     if it invokes YYBACKUP.  In the case of YYABORT or YYACCEPT, an
     incorrect destructor might then be invoked immediately.  In the
     case of YYERROR or YYBACKUP, subsequent parser actions might lead
     to an incorrect destructor call or verbose syntax error message
     before the lookahead is translated.  */
  YY_SYMBOL_PRINT ("-> $$ =", yyr1[yyn], &yyval, &yyloc);

  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);

  *++yyvsp = yyval;

  /* Now 'shift' the result of the reduction.  Determine what state
     that goes to, based on the state we popped back to and the rule
     number reduced by.  */

  yyn = yyr1[yyn];

  yystate = yypgoto[yyn - YYNTOKENS] + *yyssp;
  if (0 <= yystate && yystate <= YYLAST && yycheck[yystate] == *yyssp)
    yystate = yytable[yystate];
  else
    yystate = yydefgoto[yyn - YYNTOKENS];

  goto yynewstate;


/*--------------------------------------.
| yyerrlab -- here on detecting error.  |
`--------------------------------------*/
yyerrlab:
  /* Make sure we have latest lookahead translation.  See comments at
     user semantic actions for why this is necessary.  */
  yytoken = yychar == YYEMPTY ? YYEMPTY : YYTRANSLATE (yychar);

  /* If not already recovering from an error, report this error.  */
  if (!yyerrstatus)
    {
      ++yynerrs;
#if ! YYERROR_VERBOSE
      yyerror (YY_("syntax error"));
#else
# define YYSYNTAX_ERROR yysyntax_error (&yymsg_alloc, &yymsg, \
                                        yyssp, yytoken)
      {
        char const *yymsgp = YY_("syntax error");
        int yysyntax_error_status;
        yysyntax_error_status = YYSYNTAX_ERROR;
        if (yysyntax_error_status == 0)
          yymsgp = yymsg;
        else if (yysyntax_error_status == 1)
          {
            if (yymsg != yymsgbuf)
              YYSTACK_FREE (yymsg);
            yymsg = (char *) YYSTACK_ALLOC (yymsg_alloc);
            if (!yymsg)
              {
                yymsg = yymsgbuf;
                yymsg_alloc = sizeof yymsgbuf;
                yysyntax_error_status = 2;
              }
            else
              {
                yysyntax_error_status = YYSYNTAX_ERROR;
                yymsgp = yymsg;
              }
          }
        yyerror (yymsgp);
        if (yysyntax_error_status == 2)
          goto yyexhaustedlab;
      }
# undef YYSYNTAX_ERROR
#endif
    }



  if (yyerrstatus == 3)
    {
      /* If just tried and failed to reuse lookahead token after an
         error, discard it.  */

      if (yychar <= YYEOF)
        {
          /* Return failure if at end of input.  */
          if (yychar == YYEOF)
            YYABORT;
        }
      else
        {
          yydestruct ("Error: discarding",
                      yytoken, &yylval);
          yychar = YYEMPTY;
        }
    }

  /* Else will try to reuse lookahead token after shifting the error
     token.  */
  goto yyerrlab1;


/*---------------------------------------------------.
| yyerrorlab -- error raised explicitly by YYERROR.  |
`---------------------------------------------------*/
yyerrorlab:

  /* Pacify compilers like GCC when the user code never invokes
     YYERROR and the label yyerrorlab therefore never appears in user
     code.  */
  if (/*CONSTCOND*/ 0)
     goto yyerrorlab;

  /* Do not reclaim the symbols of the rule whose action triggered
     this YYERROR.  */
  YYPOPSTACK (yylen);
  yylen = 0;
  YY_STACK_PRINT (yyss, yyssp);
  yystate = *yyssp;
  goto yyerrlab1;


/*-------------------------------------------------------------.
| yyerrlab1 -- common code for both syntax error and YYERROR.  |
`-------------------------------------------------------------*/
yyerrlab1:
  yyerrstatus = 3;      /* Each real token shifted decrements this.  */

  for (;;)
    {
      yyn = yypact[yystate];
      if (!yypact_value_is_default (yyn))
        {
          yyn += YYTERROR;
          if (0 <= yyn && yyn <= YYLAST && yycheck[yyn] == YYTERROR)
            {
              yyn = yytable[yyn];
              if (0 < yyn)
                break;
            }
        }

      /* Pop the current state because it cannot handle the error token.  */
      if (yyssp == yyss)
        YYABORT;


      yydestruct ("Error: popping",
                  yystos[yystate], yyvsp);
      YYPOPSTACK (1);
      yystate = *yyssp;
      YY_STACK_PRINT (yyss, yyssp);
    }

  YY_IGNORE_MAYBE_UNINITIALIZED_BEGIN
  *++yyvsp = yylval;
  YY_IGNORE_MAYBE_UNINITIALIZED_END


  /* Shift the error token.  */
  YY_SYMBOL_PRINT ("Shifting", yystos[yyn], yyvsp, yylsp);

  yystate = yyn;
  goto yynewstate;


/*-------------------------------------.
| yyacceptlab -- YYACCEPT comes here.  |
`-------------------------------------*/
yyacceptlab:
  yyresult = 0;
  goto yyreturn;

/*-----------------------------------.
| yyabortlab -- YYABORT comes here.  |
`-----------------------------------*/
yyabortlab:
  yyresult = 1;
  goto yyreturn;

#if !defined yyoverflow || YYERROR_VERBOSE
/*-------------------------------------------------.
| yyexhaustedlab -- memory exhaustion comes here.  |
`-------------------------------------------------*/
yyexhaustedlab:
  yyerror (YY_("memory exhausted"));
  yyresult = 2;
  /* Fall through.  */
#endif

yyreturn:
  if (yychar != YYEMPTY)
    {
      /* Make sure we have latest lookahead translation.  See comments at
         user semantic actions for why this is necessary.  */
      yytoken = YYTRANSLATE (yychar);
      yydestruct ("Cleanup: discarding lookahead",
                  yytoken, &yylval);
    }
  /* Do not reclaim the symbols of the rule whose action triggered
     this YYABORT or YYACCEPT.  */
  YYPOPSTACK (yylen);
  YY_STACK_PRINT (yyss, yyssp);
  while (yyssp != yyss)
    {
      yydestruct ("Cleanup: popping",
                  yystos[*yyssp], yyvsp);
      YYPOPSTACK (1);
    }
#ifndef yyoverflow
  if (yyss != yyssa)
    YYSTACK_FREE (yyss);
#endif
#if YYERROR_VERBOSE
  if (yymsg != yymsgbuf)
    YYSTACK_FREE (yymsg);
#endif
  return yyresult;
}
