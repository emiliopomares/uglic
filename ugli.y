/* UGLI 1.0 grammar definition
   2014 by Emilio Pomares
 */

%{
    
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
    
    %}

%union {
    
    char str[128];
    int Integer;
    float Float;
}

%token UNIT_RES INHERITS SWITCH_RES GROUP_RES TYPE_RES INLET_RES OUTLET_RES
%token STATE_RES COMMA
%token SLOT_RES PARENTH_OPEN PARENTH_CLOSE CBRACKET_OPEN CBRACKET_CLOSE
%token BRACKET_OPEN BRACKET_CLOSE BEHAVIOUR_RES AT PLUS DOT
%token MINUSASSIGN MULTASSIGN GOTO_RES MINUS MULT
%token DIVASSIGN NOTASSIGN PLUSASSIGN ON_RES EVENT_RES
%token FOR_RES WHILE_RES IMMEDIATEFOR_RES IMMEDIATEWHILE_RES
%token IMMEDIATE_RES OFTYPE_RES ENDTYPE_RES
%token ENDUNT_RES INCOP DECOP
%token COLON SEMICOLON COMPARATOR ASSIGN DEFAULT_RES IF_RES
%token LESSTHAN GREATERTHAN COMPARE NOTIFY_RES EID_RES
%token ENDSWITCH_RES ACTION_RES FUNCTION_RES SELF_RES
%token <str> STRING
%token <str> ID
%token <Integer> INTEGER
%token <str> BASIC_TYPE
%token <Float> FLOAT

%left ASSIGN
%left COMPARE
%left PLUS MINUS
%left MULT DIV

%type <str> expconstant
%type <str> variableref
%type <str> expression
%type <str> assign
%type <str> incassign
%type <str> decassign

%type <str> type

%start ugliprogram

%%

ugliprogram:/* nothing */

| ugliprogram declaration

;

declaration: unit |
typedeclr |
switch |
group
;

inheritance:
    | INHERITS ID { internal_setUnitSuper($2);
    }
;

type:
  BASIC_TYPE { printf("basic type detected: ");
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
| ID { printf("compound type detected: %s \n", $1); strcpy($$, $1); }
;

unit: UNIT_RES ID { internal_addNewUnit($2); incScope(); } inheritance unitbody ENDUNT_RES {printf("A complete UNIT\n"); decScope(); };



typedeclr: TYPE_RES ID { internal_addNewType(); internal_setTypeName($2);  }
    typebody
    ENDTYPE_RES { printf("A complete Type declared!");  }
;

switch:
   SWITCH_RES { internal_addNewSwitch(); }
   ID { internal_setSwitchName($3);
    }
   OFTYPE_RES ID { internal_setCurrentSwitchTypeName($6);
    }
   switchbody
   ENDSWITCH_RES
   { printf("A complete Switch declared!"); }
;

group: GROUP_RES groupbody
;

variables: variable /*nothing*/
    | variables variable;

variable:
BASIC_TYPE ID  { //printf("Basic type var: %s\n\n\n", $1);
    internal_addBasicVarToCurrentType($1, $2);
} SEMICOLON
| ID ID { internal_addCompoundVarToCurrentType($1, $2); } SEMICOLON

;

typebody:

   //CBRACKET_OPEN

    variables

   //CBRACKET_CLOSE
;

switchinlet:
  INLET_RES ID SEMICOLON { internal_addNewInletToSwitch(); internal_setCurrentSwitchInletName($2); }
;


switchinlets: /*nothing*/
    |
    switchinlets switchinlet;

//outlet:
//    OUTLET_RES ID SEMICOLON;
//;

//outlets:
//    |
//    outlets outlet;

switchbody:


//   switchinlets

//    DEFAULT_RES ID

//|

    switchinlets


;

groupbody: ;

string:
   STRING;

parameters:
|
| parameter
| parameters COMMA parameter;

parameter:
ID COLON type;

action:
  nonvoidaction
| voidaction
;

function:
  nonvoidfunction
| voidfunction
;

nonvoidfunction:
FUNCTION_RES  ID PARENTH_OPEN parameters PARENTH_CLOSE COLON type
    { curContext = CONTEXT_FUNCTION;
        internal_addNewFunction(); }
    block
    { printf("Congrats: a new function is born!\n"); }
;

voidfunction:
FUNCTION_RES ID PARENTH_OPEN parameters PARENTH_CLOSE COLON PARENTH_OPEN PARENTH_CLOSE
    { curContext = CONTEXT_FUNCTION;
        internal_addNewFunction(); }
    block
    { printf("Congrats: a new -void- function is born!\n"); }
;

nonvoidaction:
ACTION_RES ID PARENTH_OPEN parameters PARENTH_CLOSE COLON type
{ curContext = CONTEXT_FUNCTION;
    internal_addNewAction(); } //Function(); }
block
{ printf("Congrats: a new function is born!\n"); }
;

voidaction:
ACTION_RES ID PARENTH_OPEN parameters PARENTH_CLOSE COLON PARENTH_OPEN PARENTH_CLOSE
{ curContext = CONTEXT_FUNCTION;
    internal_addNewAction(); } //Function(); }
block
{ printf("Congrats: a new -void- function is born!\n"); }
;

forloop:
FOR_RES PARENTH_OPEN assign SEMICOLON condition SEMICOLON assign PARENTH_CLOSE sentence
;

whileloop:
WHILE_RES 

block:
    CBRACKET_OPEN { printf("cbracket open   "); }
        sentences
    CBRACKET_CLOSE { printf("cbracket close   "); }
;

condition:
    expression COMPARATOR expression;

immediateforloop:
  IMMEDIATEFOR_RES PARENTH_OPEN assign SEMICOLON condition SEMICOLON assign sentence;

forloop:
   FOR_RES PARENTH_OPEN assign SEMICOLON condition SEMICOLON assign sentence;

immediatewhileloop:
   IMMEDIATEWHILE_RES PARENTH_OPEN condition PARENTH_CLOSE sentence;

whileloop:
   WHILE_RES PARENTH_OPEN condition PARENTH_CLOSE sentence;

if:
    IF_RES PARENTH_OPEN condition PARENTH_CLOSE sentence;

sentences:
| sentences sentence;

message:
    NOTIFY_RES handle ID;

incassign:
    INCOP variableref {
        internal_addNewInstruction(curContext);
        internal_setInstructionOp(INSTR_PREINC);
        internal_generateNewTempVarName(tempVarNames);
        internal_setDest(tempVarNames);
        internal_setSrc1($2, SRC_VAR);
        strcpy($$, tempVarNames);
    }
    | variableref INCOP {
        internal_addNewInstruction(curContext);
        internal_setInstructionOp(INSTR_POSTINC);
        internal_generateNewTempVarName(tempVarNames);
        internal_setDest(tempVarNames);
        internal_setSrc1($1, SRC_VAR);
        strcpy($$, tempVarNames);
    }
    ;

decassign:
DECOP variableref {
    internal_addNewInstruction(curContext);
    internal_setInstructionOp(INSTR_SUB);
    internal_setDest($2);
    internal_setSrc1($2, SRC_VAR); internal_setSrc2("1", SRC_IMMEDIATE);
    strcpy($$, $2);
}
| variableref DECOP {
    internal_addNewInstruction(curContext);
    internal_setInstructionOp(INSTR_ASSIGN);
    internal_generateNewTempVarName(tempVarNames);
    internal_setDest(tempVarNames);
    internal_setSrc1($1);
    internal_addNewInstruction(curContext);
    internal_setInstructionOp(INSTR_SUB);
    internal_setDest($1);
    internal_setSrc1($1, SRC_VAR); internal_setSrc2("1", SRC_IMMEDIATE);
    strcpy($$, tempVarNames);
}
;


sentence:
    expression SEMICOLON {
        internal_addNewInstruction(curContext);
        internal_setInstructionOp(INSTR_EOI);
        internal_setSrc1($1);
        resetTmpVarCounter();
    }
//|   forloop
//|   whileloop
//|   immediateforloop
//|   immediatewhileloop  // poco a poco
//|   goto SEMICOLON
//|   if
//|   message SEMICOLON
|   block
;

goto:

    GOTO_RES ID SEMICOLON
|   GOTO_RES ID BRACKET_OPEN ID BRACKET_CLOSE SEMICOLON
;

assign:
    variableref ASSIGN expression {
        internal_addNewInstruction(curContext);
        internal_setInstructionOp(INSTR_ASSIGN);
        internal_setDest($1);
        internal_setSrc1($3);
        strcpy($$, $1);
        
    }
//|   variableref PLUSASSIGN expression
//|   variableref MINUSASSIGN expression
//|   variableref MULTASSIGN expression
//|   variableref DIVASSIGN expression
//|   variableref NOTASSIGN expression
;

constant:
INTEGER { $<Integer>$ = $1; typeOfLastConstant = TYPE_INT; printf("... int detected %d\n", $1); }
|   FLOAT { $<Float>$ = $1; typeOfLastConstant = TYPE_FLOAT; printf("... float detected %g\n", $1); }
;


expconstant:
INTEGER { sprintf($$, "%d", $1); }
| FLOAT { sprintf($$, "%g", $1); }
;



valuedparameters:
   |
    valuedparameters COMMA valuedparameter;

valuedparameter:
    ID COLON expression;

functioncall:
    ID PARENTH_OPEN valuedparameters PARENTH_CLOSE
|   handle DOT ID PARENTH_OPEN valuedparameters PARENTH_CLOSE
;

expression:
    assign { strcpy($$, $1);  }
|   expconstant { strcpy($$, $1); }
|   incassign { strcpy($$, $1); }
|   decassign { strcpy($$, $1); }
|   expression COMPARE expconstant {
        internal_addNewInstruction(curContext);
        internal_setInstructionOp(INSTR_COMPARE);
        internal_generateNewTempVarName(tempVarNames);
        internal_setDest(tempVarNames);
        internal_setSrc1($1, SRC_VAR); internal_setSrc2($3, SRC_IMMEDIATE);
        strcpy($$, tempVarNames);
    }
|   expression COMPARE variableref {
        internal_addNewInstruction(curContext);
        internal_setInstructionOp(INSTR_COMPARE);
        internal_generateNewTempVarName(tempVarNames);
        internal_setDest(tempVarNames);
        internal_setSrc1($1, SRC_VAR); internal_setSrc2($3, SRC_VAR);
        strcpy($$, tempVarNames);
    }
|   expression PLUS expconstant {
        internal_addNewInstruction(curContext);
        internal_setInstructionOp(INSTR_ADD);
        internal_generateNewTempVarName(tempVarNames);
        internal_setDest(tempVarNames);
        internal_setSrc1($1, SRC_VAR); internal_setSrc2($3, SRC_IMMEDIATE);
        strcpy($$, tempVarNames);
    }
|   expression PLUS variableref  {
        internal_addNewInstruction(curContext);
        internal_setInstructionOp(INSTR_ADD);
        internal_generateNewTempVarName(tempVarNames);
        internal_setDest(tempVarNames);
        internal_setSrc1($1, SRC_VAR); internal_setSrc2($3, SRC_VAR);
        strcpy($$, tempVarNames);
    }
|   expression MINUS expconstant  {
        internal_addNewInstruction(curContext);
        internal_setInstructionOp(INSTR_SUB);
        internal_generateNewTempVarName(tempVarNames);
        internal_setDest(tempVarNames);
        internal_setSrc1($1, SRC_VAR); internal_setSrc2($3, SRC_IMMEDIATE);
        strcpy($$, tempVarNames);
    }
|   expression MINUS variableref   {
        internal_addNewInstruction(curContext);
        internal_setInstructionOp(INSTR_SUB);
        internal_generateNewTempVarName(tempVarNames);
        internal_setDest(tempVarNames);
        internal_setSrc1($1, SRC_VAR); internal_setSrc2($3, SRC_VAR);
        strcpy($$, tempVarNames);
    }
|   expression MULT expconstant  {
        internal_addNewInstruction(curContext);
        internal_setInstructionOp(INSTR_MULT);
        internal_generateNewTempVarName(tempVarNames);
        internal_setDest(tempVarNames);
        internal_setSrc1($1, SRC_VAR); internal_setSrc2($3, SRC_IMMEDIATE);
        strcpy($$, tempVarNames);
    }
|   expression MULT variableref  {
        internal_addNewInstruction(curContext);
        internal_setInstructionOp(INSTR_MULT);
        internal_generateNewTempVarName(tempVarNames);
        internal_setDest(tempVarNames);
        internal_setSrc1($1, SRC_VAR); internal_setSrc2($3, SRC_VAR);
        strcpy($$, tempVarNames);
    }

|   PARENTH_OPEN expression PARENTH_CLOSE {
        internal_addNewInstruction(curContext);
        internal_setInstructionOp(INSTR_ASSIGN);
        internal_generateNewTempVarName(tempVarNames);
        internal_setDest(tempVarNames);
        internal_setSrc1($2, SRC_VAR);
        strcpy($$, tempVarNames);
    }
//|   functioncall
|   variableref { strcpy($$, $1); }
;

handle: // handle to a node
    string
   | EID_RES ASSIGN INTEGER
   | ID
;


variableref:
  ID { printf("Reference to variable detected\n"); strcpy($$, $1); }
//|   ID BRACKET_OPEN INTEGER BRACKET_CLOSE
;

state:
    STATE_RES ID CBRACKET_OPEN  { curContext = CONTEXT_STATE; }
        sentences
    CBRACKET_CLOSE
|
    STATE_RES ID BRACKET_OPEN AT INTEGER BRACKET_CLOSE CBRACKET_OPEN
        sentences
    CBRACKET_CLOSE
;

//state:
//    STATE_RES ID block;

states: state /* at lease a state is required, the initial state */
   |
    states state;

slot:
    SLOT_RES ID CBRACKET_OPEN
        states
    CBRACKET_CLOSE
;

slots: slot /* at least a slot is required */
| slots slot;

typedoutletdeclaration:
OUTLET_RES LESSTHAN type GREATERTHAN ID SEMICOLON {printf("A typed outlet\n"); };

typedinletdeclaration:
INLET_RES LESSTHAN {printf("inlet <\n");} type GREATERTHAN ID SEMICOLON {printf("A typed inlet\n"); };

variabledeclaration:
    type ID SEMICOLON { internal_unitAddNewVariable($2, $1, 1);
    }
  |
    type ID ASSIGN constant SEMICOLON {
        printf("Type of last constant: %d ", typeOfLastConstant);
        internal_unitAddNewVariable($2, $1, 1);
       switch(typeOfLastConstant) {
            case TYPE_INT:
              printf("and value of $<Integer>4: %d\n", $<Integer>4);
                internal_unitSetVariableInitialValue_int($<Integer>4);
                break;
            case TYPE_FLOAT:
               printf("and value of $<Float>4: %g\n", $<Float>4);
                internal_unitSetVariableInitialValue_float($<Float>4);
                break;
        }
    }
;

eventdeclaration:

    ON_RES EVENT_RES ID
    {printf("event detected\n"); curContext = CONTEXT_EVENTHANDLER;
        internal_addNewEvent();
        internal_setEventName($3);
        incScope(); }
    block { printf("Event terminado\n"); decScope();};

property:
    variabledeclaration
  |   typedinletdeclaration
  |   typedoutletdeclaration  // to be implemented little by little
  |   eventdeclaration
  |   function
;

behaviour:
    BEHAVIOUR_RES COLON slots
;

properties:
    |
    properties property;

unitbody:
    properties
    //behaviour // to be implemented later
;








