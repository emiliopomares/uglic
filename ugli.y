/*
 Características que vamos a dejar para una versión de UGLI > 1.0
     - staticall
     - Punteros a objetos (aparte de handle)
 */

/* UGLI 1.0 grammar definition
   2014 by Emilio Pomares
 */

%{
    
    #define VERSION "1.0"
    
    #include <stdio.h>
    #include <string.h>
    #include "UGLI_internal.h"
    #include "translator.h"
    #include <stdlib.h>
    
    extern int  yylineno;
    extern char* yytext[];
    extern FILE* outFile_p;
    extern FILE* yyin;
    int noerror=1;
    int typeOfLastConstant;
    int curContext;
    char tempVarNames[128];
    char tempTextBuffer[2048];
    char currentUnitName[2048];
    int indexOfInitial;
    int targetChanged;
    
    SYMBOL_TABLE_ENTRY symInfo;
    
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
        targetChanged = 0;
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
        outt = fopen("/Users/flandre/Dropbox/codigo/UGLI2014/uglic.macosx_opengl_au/uglic.macosx_opengl_au/out.m", "w");
        flushToOutSource_objc(VERSION, outt);
        fclose(outt);
        outt = fopen("/Users/flandre/Dropbox/codigo/UGLI2014/uglic.macosx_opengl_au/uglic.macosx_opengl_au/out.v", "w");
        flushToVCode(VERSION, outt);
        fclose(outt);
        
    }
    
    %}

%union { // atención, cambio drástico
    
    struct {
        char str[1024]; // max string length 1024 chars. You can make the compiler hang just by making a 1024+ longer string!!! not very safe!
        int Integer;
        float Float;
        int dim;
        int type;
    } info;
}

%token UNIT_RES INHERITS SWITCH_RES GROUP_RES TYPE_RES INLET_RES OUTLET_RES
%token STATE_RES COMMA
%token SLOT_RES PARENTH_OPEN PARENTH_CLOSE CBRACKET_OPEN CBRACKET_CLOSE
%token BRACKET_OPEN BRACKET_CLOSE BEHAVIOUR_RES AT PLUS DOT
%token MINUSASSIGN MULTASSIGN GOTO_RES MINUS MULT
%token DIVASSIGN NOTASSIGN PLUSASSIGN ON_RES EVENT_RES
%token FOR_RES WHILE_RES IMMEDIATEFOR_RES IMMEDIATEWHILE_RES
%token IMMEDIATE_RES OFTYPE_RES ENDTYPE_RES
%token ENDUNT_RES INCOP DECOP GREATER_THAN LESS_THAN
%token COLON SEMICOLON ASSIGN DEFAULT_RES IF_RES
%token LESSTHAN GREATERTHAN COMPARE NOTIFY_RES EID_RES
%token ENDSWITCH_RES FUNCTION_RES SELF_RES
%token <info> STRING
%token <info> ID
%token <info> INTEGER
%token <info> BASIC_TYPE
%token <info> FLOAT
%token <info> COMPARE

%type <info> arraydeclaration
%type <info> arraydimension

%left ASSIGN
%left COMPARE
%left PLUS MINUS
%left MULT DIV

%type <info> basictype

%type <info> expconstant
%type <info> constant
%type <info> functioncall
%type <info> variableref
%type <info> expression
%type <info> assign
%type <info> incassign
%type <info> decassign

%type <info> compare

%type <info> forloop

%type <info> type

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
    | INHERITS ID { internal_setUnitSuper($2.str);
    }
;

basictype:
BASIC_TYPE { printf("basic type detected: ");
    switch($1.Integer) {
        case TYPE_INT:
        printf("int");
        strcpy($$.str, "UGLIint");
        break;
        case TYPE_FLOAT:
        printf("float");
        strcpy($$.str, "UGLIfloat");
        break;
        case TYPE_STRING:
        printf("string");
        strcpy($$.str, "string");
        break;
        case TYPE_HANDLE:
        printf("handle");
        strcpy($$.str, "UGLIhandle");
        break;
    }
    printf("\n");
    
};


type:
  basictype
| ID { printf("compound type detected: %s \n", $1.str); strcpy($$.str, $1.str); }
;

unit: UNIT_RES ID { internal_addNewUnit($2.str); strcpy(currentUnitName, $2.str); incScope(); } inheritance unitbody ENDUNT_RES {printf("A complete UNIT\n"); decScope(); };



typedeclr: TYPE_RES ID { internal_addNewType(); internal_setTypeName($2.str);
    internal_addType($2.str);
} typebody ENDTYPE_RES { printf("A complete Type declared!");  }
;

switch:
   SWITCH_RES { internal_addNewSwitch(); }
   ID { internal_setSwitchName($3.str);
    }
   OFTYPE_RES ID { internal_setCurrentSwitchTypeName($6.str);
    }
   switchbody
   ENDSWITCH_RES
   { printf("A complete Switch declared!"); }
;

group: GROUP_RES groupbody
;

variables: variable /*nothing*/
    | variables variable;

variable: basictype ID { internal_addBasicVarToCurrentType($1.str, $2.str);
                          internal_incTypeSize(getSizeOfType($1.str));
                    } SEMICOLON
| ID ID { internal_addCompoundVarToCurrentType($1.str, $2.str);
        internal_incTypeSize(getSizeOfType($1.str)); } SEMICOLON
;

typebody:

   //CBRACKET_OPEN

    variables

   //CBRACKET_CLOSE
;

switchinlet:
  INLET_RES ID SEMICOLON { internal_addNewInletToSwitch(); internal_setCurrentSwitchInletName($2.str); }
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
ID COLON type {
    
    internal_addNewInstruction(curContext);
    internal_setInstructionOp(INSTR_DECLRPARAM);
    internal_setSrc1($1.str, SRC_VAR);
    internal_setSrc2($3.str, SRC_VAR);
    internal_functionAddParameter($1, $3);
    
};

function:
  nonvoidfunction
| voidfunction
;

nonvoidfunction:
FUNCTION_RES  ID PARENTH_OPEN parameters PARENTH_CLOSE COLON type
    { curContext = CONTEXT_FUNCTION;
        internal_addNewFunction();
        internal_setFunctionName($2.str);
        internal_setFunctionReturnType($7.str); }
    block
    { printf("Congrats: a new function is born!\n"); }
;

voidfunction:
FUNCTION_RES ID PARENTH_OPEN parameters PARENTH_CLOSE COLON PARENTH_OPEN PARENTH_CLOSE
    { curContext = CONTEXT_FUNCTION;
        internal_addNewFunction();
        internal_setFunctionName($2.str);
        internal_setFunctionReturnType("void"); }
    block
    { printf("Congrats: a new -void- function is born!\n"); }
;

block:
    CBRACKET_OPEN
        sentences
    CBRACKET_CLOSE;

whileloop:
WHILE_RES PARENTH_OPEN {
        internal_incrementStatePC();
        internal_incrementStatePC();
        internal_addNewInstruction(curContext);
        internal_setInstructionOp(INSTR_NEWSTATE);
        printf("While loop commenced!....\n\n");
    } expression {
        internal_addNewInstruction(curContext);
        internal_setInstructionOp(INSTR_IF);
        internal_setSrc1($4.str, SRC_VAR);
        internal_setSrc2("1", SRC_IMMEDIATE); // the number of instructions to skip
        resetTmpVarCounter();
        printf("... expression parsed!.... \n\n");
    }
    PARENTH_CLOSE sentence {
        internal_addNewInstruction(curContext);
        internal_setInstructionOp(INSTR_BREAK);
        internal_addNewInstruction(curContext);
        internal_setInstructionOp(INSTR_ENDIF);
        internal_addNewInstruction(curContext);
        internal_setInstructionOp(INSTR_NEWSTATE);
        printf("... action parsed!.... WHILELOOP finished!!!\n\n");
    };


forloop:
FOR_RES PARENTH_OPEN {
        internal_incrementStatePC();
        internal_incrementStatePC();
        printf("Commencing for loop! ... \n");
    }
    assign {
        internal_addNewInstruction(curContext);
        internal_setInstructionOp(INSTR_EOI);
        internal_setSrc1($4.str);
        //resetTmpVarCounter();
        
         internal_addNewInstruction(curContext);
         internal_setInstructionOp(INSTR_NEWSTATE);
         internal_pushInt(curContext);
         printf("          -> saving context %d\n", curContext);
         curContext = CONTEXT_TEMP_0;
         printf("... an assignation  ...\n");
        
    }
    SEMICOLON expression {
        //internal_addNewInstruction(CONTEXT_TEMP_0);
        //internal_setInstructionOp(INSTR_EOI);
        //internal_setSrc1($7);
        //resetTmpVarCounter();
        curContext = CONTEXT_TEMP_1;
        printf("... an expression ...\n");
    }
    SEMICOLON expression {
        internal_addNewInstruction(CONTEXT_TEMP_1);
        internal_setInstructionOp(INSTR_EOI);
        internal_setSrc1($10.str);
        resetTmpVarCounter();
        curContext = internal_popInt();
        printf("            -> recovering context %d\n", curContext);
        printf("... another expression ... \n");
    }
    PARENTH_CLOSE {
    
        internal_copyInstructionsFromBuffer(curContext, 0);
        internal_addNewInstruction(curContext);
        internal_setInstructionOp(INSTR_IF);
        internal_setSrc1($7.str, SRC_VAR);
        internal_setSrc2("1", SRC_IMMEDIATE); // the number of instructions to skip
        resetTmpVarCounter();
    
    } sentence {
        
        internal_copyInstructionsFromBuffer(curContext, 1);
        internal_addNewInstruction(curContext);
        internal_setInstructionOp(INSTR_BREAK);
        internal_addNewInstruction(curContext);
        internal_setInstructionOp(INSTR_ENDIF);
        internal_addNewInstruction(curContext);
        internal_setInstructionOp(INSTR_NEWSTATE);
        internal_addNewInstruction(curContext);
        
        printf("FINISHED FOR LOOP CONSTRUCT!!!\n\n");
        
    }
;


compare:
    COMPARE { $$.Integer = $1.Integer; }
| LESS_THAN { $$.Integer = COMPARE_LESS_THAN; }
| GREATER_THAN { $$.Integer = COMPARE_GREATER_THAN; }
;



immediateforloop:
IMMEDIATE_RES FOR_RES { printf("\n\n\nIMMEDIATE FOR BEGINSSSSSSSSSS\n\n\n ");
            internal_addNewInstruction(curContext);
            internal_setInstructionOp(INSTR_IMFORINITIAL);
        } PARENTH_OPEN assign {
            resetTmpVarCounter();
            internal_addNewInstruction(curContext);
            internal_setInstructionOp(INSTR_IMFORCONDIT);
            internal_setSrc1($5.str);
            
        } SEMICOLON expression {
            resetTmpVarCounter();
            internal_addNewInstruction(curContext);
            internal_setInstructionOp(INSTR_IMFORACTION);
            internal_setSrc1($8.str);
        
        } SEMICOLON expression {
            resetTmpVarCounter();
            internal_addNewInstruction(curContext);
            internal_setInstructionOp(INSTR_IMFORBODY);
            internal_setSrc1($11.str);

        } PARENTH_CLOSE sentence {
            internal_addNewInstruction(curContext);
            internal_setInstructionOp(INSTR_ENDOFIMFOR);
        };



immediatewhileloop:
    IMMEDIATE_RES WHILE_RES PARENTH_OPEN {
        internal_addNewInstruction(curContext);
        internal_setInstructionOp(INSTR_IMWHILEINITIAL);
    } expression PARENTH_CLOSE {
        resetTmpVarCounter();
        internal_addNewInstruction(curContext);
        internal_setInstructionOp(INSTR_IMWHILEBODY);
        internal_setSrc1($5.str);
    } sentence {
        internal_addNewInstruction(curContext);
        internal_setInstructionOp(INSTR_ENDOFIMWHILE);

    };


if:
IF_RES PARENTH_OPEN {printf("if detected...\n");} expression {
        internal_addNewInstruction(curContext);
        internal_setInstructionOp(INSTR_IF);
        internal_setSrc1($4.str, SRC_VAR);
        internal_setSrc2("1", SRC_IMMEDIATE); // the number of instructions to skip
        printf("... IF expression (condition) parsed ....\n");
        resetTmpVarCounter();
    } PARENTH_CLOSE sentence {
        printf("... IF body parsed ....\n");
        internal_addNewInstruction(curContext);
        internal_setInstructionOp(INSTR_ENDIF);
    };

sentences:
| sentences sentence;

message:
    NOTIFY_RES handle ID;

//incassign:
//    INCOP variableref {
//        internal_addNewInstruction(curContext);
//        internal_setInstructionOp(INSTR_INC);
//        internal_setDest($2);
//        internal_setSrc1($2, SRC_VAR);
//        //internal_addNewInstruction(curContext);
//        //internal_setInstructionOp(INSTR_EOI); // poner como destino el destino de la instr anterior
//
//        //resetTmpVarCounter();
//        strcpy($$, $2);
//    }
//    | variableref INCOP {
//        internal_addNewInstruction(curContext);
//        internal_setInstructionOp(INSTR_ASSIGN);
//        internal_generateNewTempVarName(tempVarNames);
//        internal_setDest(tempVarNames);
//        internal_setSrc1($1);
//        internal_addNewInstruction(curContext);
//        internal_setInstructionOp(INSTR_INC);
//        internal_setDest($1);
//        internal_setSrc1($1, SRC_VAR); //internal_setSrc2("1", SRC_IMMEDIATE);
//        //internal_addNewInstruction(curContext);
//        //internal_setInstructionOp(INSTR_EOI);
//        //resetTmpVarCounter();
//        strcpy($$, tempVarNames);
//    }
//    ;
incassign:
INCOP variableref {
    internal_addNewInstruction(curContext);
    internal_setInstructionOp(INSTR_PREINC);
    internal_generateNewTempVarName(tempVarNames);
    internal_setDest(tempVarNames);
    internal_setSrc1($2.str, SRC_VAR);
    strcpy($$.str, tempVarNames);
}
| variableref INCOP {
    internal_addNewInstruction(curContext);
    internal_setInstructionOp(INSTR_POSTINC);
    internal_generateNewTempVarName(tempVarNames);
    internal_setDest(tempVarNames);
    internal_setSrc1($1.str, SRC_VAR);
    strcpy($$.str, tempVarNames);
}
;



decassign:
DECOP variableref {
    internal_addNewInstruction(curContext);
    internal_setInstructionOp(INSTR_SUB);
    internal_setDest($2.str);
    internal_setSrc1($2.str, SRC_VAR); internal_setSrc2("1", SRC_IMMEDIATE);
    strcpy($$.str, $2.str);
}
| variableref DECOP {
    internal_addNewInstruction(curContext);
    internal_setInstructionOp(INSTR_ASSIGN);
    internal_generateNewTempVarName(tempVarNames);
    internal_setDest(tempVarNames);
    internal_setSrc1($1.str);
    internal_addNewInstruction(curContext);
    internal_setInstructionOp(INSTR_SUB);
    internal_setDest($1.str);
    internal_setSrc1($1.str, SRC_VAR); internal_setSrc2("1", SRC_IMMEDIATE);
    strcpy($$.str, tempVarNames);
}
;


sentence:
    expression SEMICOLON {
        internal_addNewInstruction(curContext);
        internal_setInstructionOp(INSTR_EOI);
        internal_setSrc1($1.str);
        resetTmpVarCounter();
    }
|   forloop
|   whileloop
|   immediateforloop
|   immediatewhileloop  // poco a poco
|   goto SEMICOLON
|   if
//|   message SEMICOLON
|   block
;

goto:

    GOTO_RES ID {
        internal_addNewInstruction(curContext);
        internal_setInstructionOp(INSTR_GOTO);
        internal_setDest($2.str);
        resetTmpVarCounter();
    }
//|   GOTO_RES ID BRACKET_OPEN ID BRACKET_CLOSE SEMICOLON // this is for first pass
;

assign:
    variableref ASSIGN expression {
        internal_addNewInstruction(curContext);
        internal_setInstructionOp(INSTR_ASSIGN);
        internal_setDest($1.str);
        internal_setSrc1($3.str);
        strcpy($$.str, $1.str);
        
    }
//|   variableref PLUSASSIGN expression
//|   variableref MINUSASSIGN expression
//|   variableref MULTASSIGN expression
//|   variableref DIVASSIGN expression
//|   variableref NOTASSIGN expression
;

constant:
INTEGER { $$.Integer = $1.Integer; typeOfLastConstant = TYPE_INT; printf("... int detected %d\n", $1.Integer); }
|   FLOAT { $$.Float = $1.Float; typeOfLastConstant = TYPE_FLOAT; printf("... float detected %g\n", $1.Float); }
|   STRING { strcpy($$.str, $1.str); typeOfLastConstant = TYPE_STRING; printf("... string detected %s", $1.str); }
;


expconstant:
INTEGER { sprintf($$.str, "%d", $1.Integer); }
| FLOAT { sprintf($$.str, "%f", $1.Float); }
| STRING { sprintf($$.str, "%s", $1.str);  }

;



valuedparameters:

   | valuedparameter
   | valuedparameters COMMA valuedparameter;

valuedparameter:
ID COLON expression {
    internal_addNewInstruction(curContext);
    internal_setInstructionOp(INSTR_DEFPARAM);
    //internal_setDest(tempVarNames);
    internal_setSrc1($1.str, SRC_VAR);
    internal_setSrc2($3.str, SRC_VAR);

} ;

//functioncall:
//    ID PARENTH_OPEN valuedparameters PARENTH_CLOSE
//|   handle DOT ID PARENTH_OPEN valuedparameters PARENTH_CLOSE
//;

functioncall:
handle DOT ID PARENTH_OPEN { printf("the beginning of a functioncall with handle!!!!\n");
    internal_addNewInstruction(curContext);
    internal_setInstructionOp(INSTR_CALLFUNC);
    
    internal_setSrc1($3.str, SRC_VAR); } valuedparameters PARENTH_CLOSE
    { printf("a complete functioncall parsed WITH HANDLEEEEEEEEEEE!!!\n\n\n");
        internal_addNewInstruction(curContext);
        internal_generateNewTempVarName(tempVarNames);
        internal_setDest(tempVarNames);
        internal_setInstructionOp(INSTR_EOP);
        internal_setSrc1("topotamadre", SRC_VAR);
        strcpy($$.str, tempVarNames);

     }
|
ID PARENTH_OPEN { printf("the beginning of a functioncall withOUT handle!!!!\n");
    internal_addNewInstruction(curContext);
    internal_setInstructionOp(INSTR_CALLFUNC);
    internal_generateNewTempVarName(tempVarNames);
    //strcpy($$, tempVarNames);
    internal_setDest(tempVarNames);
    internal_setSrc1($1.str, SRC_VAR); } valuedparameters PARENTH_CLOSE
{ printf("a complete functioncall parsed!!!\n\n\n");
    internal_addNewInstruction(curContext);
    internal_setInstructionOp(INSTR_EOP);
    internal_setSrc1("topotamadre", SRC_VAR);
    strcpy($$.str, tempVarNames);
    }

;

handle: // rewrite handle so that STRING can only be at the beginning
//  emptyhandle { printf("an empty handle detected\n"); }
//|
 SELF_RES
| ID {
    internal_addNewInstruction(curContext); internal_setInstructionOp(INSTR_TARGET); internal_setSrc1($1.str, SRC_VAR); targetChanged = 1; }
| functioncall {  internal_addNewInstruction(curContext); internal_setInstructionOp(INSTR_TARGET); internal_setSrc1($1.str, SRC_VAR); }
| STRING { // "enemy*".getSize()
    internal_addNewInstruction(curContext); internal_setInstructionOp(INSTR_TARGET_FROM_STRING);
        internal_setSrc1($1.str, SRC_VAR); targetChanged = 1;
}
| handle DOT ID {
    internal_addNewInstruction(curContext); internal_setInstruction(INSTR_TARGET);
    internal_setSrc($1.str, SRC_VAR); targetChanged = 1;
}
| handle DOT functioncall
;




// Let's do dynacall only for now
/// what about
//
// self.Player.getClosestEnemies().damage(amount: self.Child.getStrength(version: 1));
//
//  · clear target // target can clear automatically on every EOI, so no need to explicite it...
//  · set target ("Player") -> variable must be type "handle"
//  · call getClosestEnemies
//  · EOP -> $t0 // we have to create handleStorages on the fly...
//  · set target ("$t0")
//  · call damage
//  · clear target
//  · set target ("Child")
//  · call getStrength
//  · add parameter ("version") ("1")
//  · EOP -> $t1
//  · add parameter ("amount") ("$t1")
//  · EOP -> $t2 -----------------------------> I think that's the winner scheme
//
// with dynacall and dynaccess only:
//   a = F2(a:5, b:1.0); // por cada funcion, crear un typedef con su def de parametros
//    // tambien hay que registrar los valores por defecto
//   se hace:
//      add parameter a: 5
//      add parameter b: 1.0
//      set target ("self") -> meaning ugli runtime will use current entity
/////////////      Unit###_F2_params uf2p; // cada entidad tiene uno de estos prealojado
/////////////      Unit###_F2_returnValue  uf2rv;
/////////////      UGLIRuntime.setTarget(UGLI_SELF);
/////////////      uf2p.a = 5;
/////////////      uf2p.b = 1.0; // or get default vales
/////////////      UGLIRuntime.invokeMethodByName("F2", &uf2p, &uf2rv); // can potentially generate several return values (vector)
/////////////       void * _UGLI_accumulator; points to last &out param pointer automatically
/////////////
/////////////      UGLIRuntime.setTarget(UGLI_SELF);
/////////////      UGLIRuntime.setVarByName("a", _UGLI_accumulator);
/////////////           a = (type of <a> cast)*_UGLI_accumulator; // statiassign
/////////////   wait fuckers, me estoy dando cuenta de que no hace falta llamar a invokeMethodByName, se puede arreglar con un Cast...??? Se puede? a lo mejor no, se puede devolver un handle a un tipo no conocido, por ejemplo, getClosestEntity(), no se sabe en tiempo de compilación lo métodos que tiene, así que hay que llamar a invokeMethodByName()
//
//
// with staticall:
// se hace:
//    a = F2(5, 1.0);
//
// las variables pueden ser de tipo: handle (dynacall forced, multiples returns allowed)
//   o de tipo <unit>: (staticall, single return value)
//
//
// una asignación:
//
//    var.reference = expression       máximo redux
//
//      cada lado tiene una dimensión, y cada lado puede ser estático o dinámico
//       recordemos que la asignación es una expresión per-se
//   I have a rather nice idea: what it arrays are like handles???
//
//  Cuándo se romple una cadena de staticall?
//
//   a<static> = self.f2(4, 5)
// static types: all basic, all classes
// dynamic types: handles
//
//
// veamos esto:
//   variable:  int a[]; // internamente a es un handle
//
//
//   a = UGLI_getClosestEnemiesId(max: 5); // returns 5 int values
//
//////////// UGLI_vecAssign(a, UGLI_getClosestEnemiesId(5));  // staticall version
////////////
//
//
// All combinations:
//
//    scalar = scalar :      a = UGLI_func();
//    scalar = vector :      a = UGLI_vecGetElement(UGLI_func(), 0);
//    vector = scalar :      UGLI_vecAssign(a, UGLI_makeConstantVec(UGLI_func()));
//    vector = vector :      UGLI_vecAssign(a, UGLI_func());
//
//      cuando se emite EOI,  UGLI_clearTempStorage();
//
//     cuando llamamos a una función del estilo UGLI_getClosestEnemies() devuelve un handle, y hay que alojar HandleStorage... cuándo se desaloja????
//          a) let it live forever: memory leaks (could be severe)
//          b) Destroy temp storage after the sentence (;), if data are not copied, they
//              are lost... FOREVER!!!!!
//
//   -> UGLI must manage its own memory:
//       create storage, if storage runs low, alloc more RAM and move
//       parametro: block size, creo que 10 es un buen tamaño
//
//
//////  a ver, los $tx sólo sirven para el reconstructor (staticall)
//////  en dynacall


expression:
    assign { strcpy($$.str, $1.str);  }
|   expconstant { strcpy($$.str, $1.str); } // no hay que dar dimensión y tipo???
|   incassign { strcpy($$.str, $1.str); }
|   decassign { strcpy($$.str, $1.str); }
|   expression compare expconstant {
        internal_addNewInstruction(curContext);
        switch($2.Integer) {
            case COMPARE_LESS_THAN:
                internal_setInstructionOp(INSTR_LT);
                break;
            case COMPARE_GREATER_THAN:
                internal_setInstructionOp(INSTR_GT);
                break;
            case COMPARE_EQUALS:
                internal_setInstructionOp(INSTR_EQUALS);
                break;
            case COMPARE_NOT_EQUAL:
                internal_setInstructionOp(INSTR_NOT_EQUAL);
                break;
        }
        internal_generateNewTempVarName(tempVarNames);
        internal_setDest(tempVarNames);
        internal_setSrc1($1.str, SRC_VAR); internal_setSrc2($3.str, SRC_IMMEDIATE);
        strcpy($$.str, tempVarNames);
    }
|   expression compare variableref {
        internal_addNewInstruction(curContext);
        switch($2.Integer) {
            case COMPARE_LESS_THAN:
            internal_setInstructionOp(INSTR_LT);
            break;
            case COMPARE_GREATER_THAN:
            internal_setInstructionOp(INSTR_GT);
            break;
            case COMPARE_EQUALS:
            internal_setInstructionOp(INSTR_EQUALS);
            break;
            case COMPARE_NOT_EQUAL:
            internal_setInstructionOp(INSTR_NOT_EQUAL);
            break;
        }
        internal_generateNewTempVarName(tempVarNames);
        internal_setDest(tempVarNames);
        internal_setSrc1($1.str, SRC_VAR); internal_setSrc2($3.str, SRC_VAR);
        strcpy($$.str, tempVarNames);
    }
|   expression PLUS expconstant {
        internal_addNewInstruction(curContext);
        internal_setInstructionOp(INSTR_ADD);
        internal_generateNewTempVarName(tempVarNames);
        internal_setDest(tempVarNames);
        internal_setSrc1($1.str, SRC_VAR); internal_setSrc2($3.str, SRC_IMMEDIATE);
        strcpy($$.str, tempVarNames);
    }
|   expression PLUS variableref  {
        internal_addNewInstruction(curContext);
        internal_setInstructionOp(INSTR_ADD);
        internal_generateNewTempVarName(tempVarNames);
        internal_setDest(tempVarNames);
        internal_setSrc1($1.str, SRC_VAR); internal_setSrc2($3.str, SRC_VAR);
        strcpy($$.str, tempVarNames);
    }
|   expression MINUS expconstant  {
        internal_addNewInstruction(curContext);
        internal_setInstructionOp(INSTR_SUB);
        internal_generateNewTempVarName(tempVarNames);
        internal_setDest(tempVarNames);
        internal_setSrc1($1.str, SRC_VAR); internal_setSrc2($3.str, SRC_IMMEDIATE);
        strcpy($$.str, tempVarNames);
    }
|   expression MINUS variableref   {
        internal_addNewInstruction(curContext);
        internal_setInstructionOp(INSTR_SUB);
        internal_generateNewTempVarName(tempVarNames);
        internal_setDest(tempVarNames);
        internal_setSrc1($1.str, SRC_VAR); internal_setSrc2($3.str, SRC_VAR);
        strcpy($$.str, tempVarNames);
    }
|   expression MULT expconstant  {
        internal_addNewInstruction(curContext);
        internal_setInstructionOp(INSTR_MULT);
        internal_generateNewTempVarName(tempVarNames);
        internal_setDest(tempVarNames);
        internal_setSrc1($1.str, SRC_VAR); internal_setSrc2($3.str, SRC_IMMEDIATE);
        strcpy($$.str, tempVarNames);
    }
|   expression MULT variableref  {
        internal_addNewInstruction(curContext);
        internal_setInstructionOp(INSTR_MULT);
        internal_generateNewTempVarName(tempVarNames);
        internal_setDest(tempVarNames);
        internal_setSrc1($1.str, SRC_VAR); internal_setSrc2($3.str, SRC_VAR);
        strcpy($$.str, tempVarNames);
    }

|   PARENTH_OPEN expression PARENTH_CLOSE {
        internal_addNewInstruction(curContext);
        internal_setInstructionOp(INSTR_PARENTH);
        internal_generateNewTempVarName(tempVarNames);
        internal_setDest(tempVarNames);
        internal_setSrc1($2.str, SRC_VAR);
        strcpy($$.str, tempVarNames);
    }
|   functioncall {
        internal_addNewInstruction(curContext);
        internal_setInstructionOp(INSTR_TEMPASSIGN);
        internal_generateNewTempVarName(tempVarNames);
        internal_setDest(tempVarNames);
        internal_setSrc1($1.str, SRC_VAR);
        strcpy($$.str, tempVarNames);
    }
|   variableref { strcpy($$.str, $1.str); }
;

//handle: // handle to a node
//    string
//   | EID_RES ASSIGN INTEGER
//   | ID
//;


variableref:
  ID { printf("Reference to variable detected\n"); strcpy($$.str, $1.str); }
//|   ID BRACKET_OPEN INTEGER BRACKET_CLOSE
| handle DOT ID
;

state:
    STATE_RES ID CBRACKET_OPEN  {
            curContext = CONTEXT_STATE;
            if(!strcmp($2.str, "initial")) {
                internal_setCurrentSlotInitialIndex();
                indexOfInitial = 1;
            }
            sprintf(tempTextBuffer, "%s.%s", currentUnitName, $2.str);
            internal_symTableAddSymbol(st_state, tempTextBuffer, "", internal_currentSlotStateIndex());
            internal_unitAddNewState($2.str);
        }
        sentences
    CBRACKET_CLOSE
;

//state:
//    STATE_RES ID block;

states: state /* at lease a state is required, the initial state */
   |
    states state;

slot:
SLOT_RES ID {printf("commencing new slot %s\n", $2.str); } CBRACKET_OPEN { internal_unitAddNewSlot($2.str);
     indexOfInitial = -1;
    }
    states {
        if(indexOfInitial==-1) { internal_fail("Semantic error: slot %s.%s has no initial state", internal_getCurrentUnitName(), $2.str); }
    }
    CBRACKET_CLOSE
;

slots: slot /* at least a slot is required */
| slots slot;

typedoutletdeclaration:
OUTLET_RES LESSTHAN type GREATERTHAN ID SEMICOLON {printf("A typed outlet\n"); };

typedinletdeclaration:
INLET_RES LESS_THAN {printf("inlet <\n");} type GREATER_THAN ID SEMICOLON {printf("A typed inlet\n"); };

arraydeclaration:
BRACKET_OPEN  BRACKET_CLOSE { $$.Integer = 1; }
;

arraydimension:
arraydeclaration { $$.Integer = $1.Integer; }
| arraydimension arraydeclaration { $$.Integer = $1.Integer + $2.Integer; } ;


variabledeclaration:
    type ID SEMICOLON { internal_unitAddNewVariable($2.str, $1.str, 0);
        internal_addSymbol($2.str, $1.str, 0);
    }
  | type ID arraydimension SEMICOLON { internal_unitAddNewVariable($2.str, $1.str, $3.Integer);
      internal_addSymbol($2.str, $1.str, $3.Integer);
  }
  |
    type ID ASSIGN constant SEMICOLON {
        printf("Type of last constant: %d ", typeOfLastConstant);
        internal_unitAddNewVariable($2.str, $1.str, 0);
       switch(typeOfLastConstant) {
            case TYPE_INT:
              printf("and value of $<Integer>4: %d\n", $4.Integer);
                internal_unitSetVariableInitialValue_int($4.Integer);
                break;
            case TYPE_FLOAT:
               printf("and value of $<Float>4: %g\n", $4.Float);
                internal_unitSetVariableInitialValue_float($4.Float);
                break;
        }
    }
;

eventdeclaration:

    ON_RES EVENT_RES ID
    {printf("event detected\n"); curContext = CONTEXT_EVENTHANDLER;
        internal_addNewEvent();
        internal_setEventName($3.str);
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
    BEHAVIOUR_RES COLON { printf("Begin of behaviour block:\n"); } slots
;

properties:
    |
    properties property;

unitbody:
    properties
    behaviour
;








