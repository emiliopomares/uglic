//
//  UGLI_internal.h
//  uglic.macosx_opengl_au
//
//  Created by Flandre Scarlet on 12/10/14.
//  Copyright (c) 2014 Digital Dreams Interactive. All rights reserved.
//

#ifndef uglic_macosx_opengl_au_UGLI_internal_h
#define uglic_macosx_opengl_au_UGLI_internal_h

/* a UNIT is clearly a class, so */

#define c_string char[128];

#define TYPE_BYTE 0
#define TYPE_SHORT 1
#define TYPE_INT 2
#define TYPE_FLOAT 3
#define TYPE_DOUBLE 4
#define TYPE_STRING 5
#define TYPE_HANDLE 100
#define TYPE_COMPOUND -1

#define INSTR_ASSIGN            0
#define INSTR_INC               1
#define INSTR_DEC               2
#define INSTR_SUM               3
#define INSTR_SUB               4
#define INSTR_MULT              5
#define INSTR_DIV               6
#define INSTR_GOTO              7
#define INSTR_COMPARE           8
#define INSTR_ADD               9
#define INSTR_EOI               10
#define INSTR_TARGET            11
#define INSTR_CALLFUNC          12
#define INSTR_DEFPARAM          13
#define INSTR_PREINC            14
#define INSTR_POSTINC           15
#define INSTR_CLEARTARGET       16
#define INSTR_SETTARGET         17
#define INSTR_EOP               18
#define INSTR_NEWSTATE          19
#define INSTR_IF                20
#define INSTR_ENDIF             21
#define INSTR_BREAK             22
#define INSTR_LT                23
#define INSTR_GT                24
#define INSTR_EQUALS            25
#define INSTR_NOT_EQUAL         26
#define INSTR_LTE               27
#define INSTR_GTE               28
#define INSTR_IMFORINITIAL      29
#define INSTR_IMFORCONDIT       30
#define INSTR_IMFORBODY         31
#define INSTR_IMFORACTION       32
#define INSTR_ENDOFIMFOR        33
#define INSTR_IMWHILEINITIAL    34
#define INSTR_IMWHILEBODY       35
#define INSTR_ENDOFIMWHILE      36
#define INSTR_TEMPASSIGN        37
#define INSTR_PARENTH           38
#define INSTR_DECLRPARAM        39

#define COMPARE_EQUALS 0
#define COMPARE_GREATER_THAN 1
#define COMPARE_LESS_THAN 2
#define COMPARE_GREATER_OR_EQUAL 3
#define COMPARE_LESS_OR_EQUAL 4
#define COMPARE_NOT_EQUAL 5

#define SRC_VAR 0
#define SRC_IMMEDIATE 1


#define CONTEXT_STATE 0
#define CONTEXT_EVENTHANDLER 1
#define CONTEXT_FUNCTION 2
#define CONTEXT_TEMP_0 3
#define CONTEXT_TEMP_1 4
#define CONTEXT_TEMP_2 5

#define UGLI_MAXSTR 1024

typedef struct {
    
    char name[80];
    char typename[80];
    int arrayDimension; // 0 for scalar, 1 for vec, 2 matrix...
    
} SYMBOL_TABLE_ENTRY;

typedef struct {
    
    SYMBOL_TABLE_ENTRY *symbol;
    int symbol_length;
    int symbol_index;
    
} SYMBOL_TABLE;

typedef struct {
    
    char name[80];
    int sizeInBytes;
    
} TYPE_TABLE_ENTRY;

typedef struct {
    
    int instOp;
    char dest[128];
    char src1[128];
    int isImmediate1;
    char src2[128];
    int isImmediate2;
    int PC;
    
    void *next;
    
} INSTRUCTION_T;

typedef struct {
    
    char name[128];
    int nInstructions;
    
    INSTRUCTION_T *firstInstruction;
    INSTRUCTION_T *lastInstruction;
    void *next;
    
} EVENT_T;

typedef struct {
    
    INSTRUCTION_T *firstInstruction;
    INSTRUCTION_T *lastInstruction;
    void *next;
    
} EVENT_T_TRAILER;

typedef struct {
    
    char name[128];
    int isInitial;
    int statePC; // number of PC values (typically 1, more if there are fors and whiles)
    int index;
    
    INSTRUCTION_T *firstInstruction;
    INSTRUCTION_T *lastInstruction;
    int nInstructions;
    
    void *next;
    
} STATE_T;

typedef struct {
    
    char name[128];
    int nStates;
    int index;
    
    int initialIndex;
    
    STATE_T *state;
    void *next;
    
} SLOT_T;

typedef struct {
    
    STATE_T *state;
    void *next;
    
} SLOT_T_TRAILER;

typedef struct {
    
    int isSimpleType;
    int simpleType; // 0: char  1: short  2: int  3: float  4: double
    void *comlexType; // a pointer to another TYPE_T
    char nameOfComplexType[128];
    char name[128];
    
    void *next;
    
} FIELD_T;

typedef struct {
    
    char name[128];
    int nFields;
    FIELD_T *field;
    
    void *next;
    
} TYPE_T;

typedef union {
    
    char b;
    short s;
    int i;
    float f;
    double d;
    int h;
    
} storage_u;

typedef struct {
    
    int *stack;
    int size;
    int index;
    
} INTSTACK;



typedef struct { // field and variable are the same!!!
    
    char name[128];
    char scope[128];
    char nameOfComplexType[128];
    
    int isSimpleType;
    int simpleType;
    int hasInitialValue;
    storage_u initialValue;
    storage_u data;
    
    int dimension;
    
    
    TYPE_T *complexType;
    void *next;
    
} VARIABLE_T;

typedef struct {
    
    TYPE_T *complexType;
    void *next;
    
} VARIABLE_T_TRAILER;

typedef struct {
    
    char name[128];
    int nInstructions;
    int nParams;
    char nameOfComplexType[128];
    int isSimpleType;
    
    INSTRUCTION_T *firstInstruction;
    INSTRUCTION_T *lastInstruction;
    FIELD_T *param;
    
    void *next;
    
} FUNCTION_T;

typedef struct {
    
    INSTRUCTION_T *firstInstruction;
    INSTRUCTION_T *lastInstruction;
    FIELD_T *param;
    
    void *next;

} FUNCTION_T_TRAILER;

typedef struct {
    
    char name[128];
    char superName[128];
    int nSlots;
    int nInlets;
    int nOutlets;
    int nVariables;
    int nFunctions;
    int nEvents;
    
    void *super;
    SLOT_T *slots;
    void *inlets;
    void *outlets;
    VARIABLE_T *variable;
    FUNCTION_T *function;
    EVENT_T *event;
    
    void *next;
    
} UNIT_T;

typedef struct {
    
    void *super;
    SLOT_T *slots;
    void *inlets;
    void *outlets;
    VARIABLE_T *variable;
    FUNCTION_T *function;
    EVENT_T *event;
    
    
    void *next;
    
} UNIT_T_TRAILER;

typedef struct {
    
    char name[128];
    char nameOfType[128]; // you look it up on second pass
    TYPE_T *type;
    
    void *next;
    
} INLET_T;

typedef struct {
    
    char name[128];
    char nameOfType[128]; // you look it up later
    TYPE_T *type; // to be resolved later
    void *inlet;
    int nInlets;
    
    void *next;
    
} SWITCH_T;

extern SYMBOL_TABLE *st_internal;
extern SYMBOL_TABLE *st_type;
extern SYMBOL_TABLE *st_state;


void flushToOutObjectCode(FILE *out);



void internal_init(void);
void internal_setUnitSuper(char *super);
void internal_addNewUnit(char *name);
void internal_setCurrentSwitchTypeName(char *t);
char *internal_currentSwitchName(void);
char *internal_currentSwitchNameOfType(void);
INLET_T *internal_createInlet(void);
void internal_addNewFieldToType(void);
void internal_setTypeName(char *n);
void internal_addCompoundVarToCurrentType(char *ctype, char *name);
int basicTypeFromName(char *type);
void internal_unitAddNewVariable(char *name, char *type, int dim);
void internal_unitSetVariableInitialValue_int(int v);
void internal_unitSetVariableInitialValue_float(float v);
void internal_addBasicVarToCurrentType(char * type, char *name);
void internal_addNewType(void);
TYPE_T *internal_createType(void);
void internal_addNewTypeToSwitch(void);
void internal_addNewInletToSwitch(void);
void internal_setCurrentSwitchInletName(char *name);
void internal_addNewSwitch(void);
void internal_setSwitchName(char *name);
void internal_setSwitchType(TYPE_T *t);
void resetTmpVarCounter(void);
void internal_unitAddNewSlot(char *name);
void internal_unitAddNewState(char *name);
void internal_incrementStatePC(void);
void internal_copyInstructionsFromBuffer(int context, int b);
void internal_pushInt(int v);
int internal_popInt(void);
void internal_pushIf(void);
int internal_popIf(void);
void internal_incrementStatePC(void);
void internal_addNewFunction(void);
void internal_setFunctionReturnType(char *type);
void internal_setFunctionName(char *name);
void internal_addSymbol(char *name, char *type, int dim);
void internal_retrieveSymbolInfo(char *name, SYMBOL_TABLE_ENTRY *info);
void internal_addType(char *name);
int getSizeOfType(char *type);
void internal_incTypeSize(int size);
void internal_retrieveTypeInfo(char *name, TYPE_TABLE_ENTRY *info);
int internal_identifyDataTypeFromStringRep(char *str);
void internal_fail(char *format, ...);
char * internal_getCurrentUnitName(void);
void internal_setCurrentSlotInitialIndex();
void internal_symTableResetTable(SYMBOL_TABLE *t);
void internal_symTableAddSymbol(SYMBOL_TABLE *t, char *name, char *type, int n);
void internal_symTableRetrieveSymbolInfo(SYMBOL_TABLE *t, char *name, SYMBOL_TABLE_ENTRY *info);
int internal_currentSlotStateIndex(void);
#endif
