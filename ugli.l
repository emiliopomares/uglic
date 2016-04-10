%{
    #include <stdio.h>
    #include <strings.h>
    #include "y.tab.h"
    #include "UGLIinternal.h"
    

%}

%%

:UNIT:                              return UNIT_RES; // _RES means Reserved word
:TYPE:                              return TYPE_RES;
:SWITCH:                            return SWITCH_RES;
:GROUP:                             return GROUP_RES;
:END\ SWITCH:                         return ENDSWITCH_RES;
:END\ TYPE:                           return ENDTYPE_RES;
:END\ UNIT:                           return ENDUNT_RES;
behaviour                           return BEHAVIOUR_RES;
behavior                            return BEHAVIOUR_RES;
slot                                return SLOT_RES;
state                               return STATE_RES;
goto                                return GOTO_RES;
if                                  return IF_RES;
[0-9]+                              yylval.Integer=atoi(yytext); return INTEGER;
[0-9]*\.[0-9]+                       yylval.Float=atof(yytext); return FLOAT;
on                                  return ON_RES;
event                               return EVENT_RES;
inlet                               return INLET_RES;
outlet                              return OUTLET_RES;
\{                                  return CBRACKET_OPEN;
\}                                  return CBRACKET_CLOSE;
:                                    return COLON;
;                                    return SEMICOLON;
for                                  return FOR_RES;
,                                    return COMMA;
\.                                   return DOT;
while                                return WHILE_RES;
immediate                            return IMMEDIATE_RES;
function                             return FUNCTION_RES;
action								 return ACTION_RES;
\[                                   return BRACKET_OPEN;
\]                                   return BRACKET_CLOSE;
==                                   yylval.Integer = COMPARE_EQUALS; return COMPARE;
!=                                   yylval.Integer = COMPARE_NOT_EQUAL; return COMPARE;
\+=                                  return PLUSASSIGN;
-=                                   return MINUSASSIGN;
\*=                                  return MULTASSIGN;
\/=                                  return DIVASSIGN;
\+                                   return PLUS;
\*                                   return MULT;
=                                    return ASSIGN;
\++                                  return INCOP;
--                                   return DECOP;
byte                                 strcpy(yylval.str, yytext);  return BASIC_TYPE;
short                                strcpy(yylval.str, yytext);  return BASIC_TYPE;
int                                  strcpy(yylval.str, yytext);  return BASIC_TYPE;
float                                strcpy(yylval.str, yytext);  return BASIC_TYPE;
double                               strcpy(yylval.str, yytext);  return BASIC_TYPE;
handle                               strcpy(yylval.str, yytext);  return BASIC_TYPE;
string                               strcpy(yylval.str, yytext);  return BASIC_TYPE;
\"(\\.|[^"])*\"                       strcpy(yylval.str, yytext); return STRING;
self                                 return SELF_RES;
_*[a-zA-Z]+[a-zA-Z_0-9]*            strcpy(yylval.str,yytext); return ID;
#                                   return INHERITS;
of\ type                            return OFTYPE_RES;
\<                                   return LESSTHAN;
\>                                   return GREATERTHAN;
\(                                    return PARENTH_OPEN;
\)                                    return PARENTH_CLOSE;

\n              // Ignore
[ \t]+          // Ignore

%%
