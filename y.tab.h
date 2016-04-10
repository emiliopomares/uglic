/* A Bison parser, made by GNU Bison 3.0.2.  */

/* Bison interface for Yacc-like parsers in C

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
#line 58 "ugli.y" /* yacc.c:1909  */

    
    char str[128];
    int Integer;
    float Float;

#line 187 "y.tab.h" /* yacc.c:1909  */
};
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
