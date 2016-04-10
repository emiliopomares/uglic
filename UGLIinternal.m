//
//  UGLI_internal.c
//  uglic.macosx_opengl_au
//
//  Created by Flandre Scarlet on 12/10/14.
//  Copyright (c) 2014 Digital Dreams Interactive. All rights reserved.
//

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "UGLIinternal.h"
#include "UGLIAPIBinder.h"

// me pregunto si todo ese rollo de la tabla de símbolos sirve para algo
// o podemos tirar directamente de la estructura....

SWITCH_T *Switch;
int nSwitches;

TYPE_T *Type;
int nTypes;

UNIT_T *unit;
int nUnits;

FIELD_T *unit_function_param;
int unit_nParams;

int curPC;

EVENT_T *tempInstrBuffer0;
EVENT_T *tempInstrBuffer1;
EVENT_T *tempInstrBuffer2;

int tmpVarCounter;

INSTRUCTION_T *lastInstr;

INTSTACK intstack;
extern INTSTACK ifstack;

int scope;
char nameOfLastUnit[128];
char nameOfLastFunction[128];


/* rearchitecturate */



SYMBOL_TABLE_ENTRY *internal_symbol;
int internal_symbol_length;
int internal_symbol_index;


TYPE_TABLE_ENTRY *internal_type;
int internal_type_length;
int internal_type_index;

SYMBOL_TABLE *st_internal;
SYMBOL_TABLE *st_type;
SYMBOL_TABLE *st_state;

#define symbolInitialCapacity 500
#define typeInitialCapacity 100


void internal_initSymbolTable(void) {
    
    internal_symbol = (SYMBOL_TABLE_ENTRY *)malloc(sizeof(SYMBOL_TABLE_ENTRY)*symbolInitialCapacity);
    internal_symbol_length = symbolInitialCapacity;
    internal_symbol_index = 0;
    
    
    
    st_state = (SYMBOL_TABLE *)malloc(sizeof(SYMBOL_TABLE_ENTRY));
    st_state->symbol = (SYMBOL_TABLE_ENTRY *)malloc(sizeof(SYMBOL_TABLE_ENTRY *)*symbolInitialCapacity);
    st_state->symbol_length = symbolInitialCapacity;
    st_state->symbol_index = 0;
    
    
}

void internal_addSymbol(char *name, char *type, int dim) {
    
    if(internal_symbol_index == internal_symbol_length) {
        
        SYMBOL_TABLE_ENTRY *newmemory;
        int newlength;
        
        newlength = internal_symbol_length + symbolInitialCapacity;
        newmemory = (SYMBOL_TABLE_ENTRY *)malloc(sizeof(SYMBOL_TABLE_ENTRY)*newlength);
        memcpy(newmemory, internal_symbol, sizeof(SYMBOL_TABLE_ENTRY)*internal_symbol_length);
        free(internal_symbol);
        internal_symbol = newmemory;
        internal_symbol_length = newlength;
    }
    
    strcpy(internal_symbol[internal_symbol_index].name, name);
    strcpy(internal_symbol[internal_symbol_index].typename, type);
    internal_symbol[internal_symbol_index].arrayDimension = dim;
    
    ++internal_symbol_index;
    
}

void internal_retrieveSymbolInfo(char *name, SYMBOL_TABLE_ENTRY *info) {
    
    int i;
    for(i=0; i<internal_symbol_index; ++i) {
        
        if(!strcmp(internal_symbol[i].name, name)) break;
        
    }
    if(i==internal_symbol_index) {
        
        info->name[0] = 0;
        info->typename[0] = 0;
        info->arrayDimension = -1;
        return;
        
    }
    
    strcpy(info->name, internal_symbol[i].name);
    strcpy(info->typename, internal_symbol[i].typename);
    info->arrayDimension = internal_symbol[i].arrayDimension;
    
}

void internal_symTableResetTable(SYMBOL_TABLE *t) {
    
    t->symbol_index = 0;
    
}

void internal_symTableAddSymbol(SYMBOL_TABLE *t, char *name, char *type, int dim) {
    
    if(t->symbol_index == t->symbol_length) {
        
        SYMBOL_TABLE_ENTRY *newmemory;
        int newlength;
        
        newlength = internal_symbol_length + symbolInitialCapacity;
        newmemory = (SYMBOL_TABLE_ENTRY *)malloc(sizeof(SYMBOL_TABLE_ENTRY)*newlength);
        memcpy(newmemory, t->symbol, sizeof(SYMBOL_TABLE_ENTRY)*t->symbol_length);
        free(t->symbol);
        t->symbol = newmemory;
        t->symbol_length = newlength;
    }
    
    strcpy(t->symbol[internal_symbol_index].name, name);
    strcpy(t->symbol[internal_symbol_index].typename, type);
    t->symbol[internal_symbol_index].arrayDimension = dim;
    
    ++t->symbol_index;
    
}

void internal_symTableRetrieveSymbolInfo(SYMBOL_TABLE *t, char *name, SYMBOL_TABLE_ENTRY *info) {
    
    int i;
    for(i=0; i<t->symbol_index; ++i) {
        
        if(!strcmp(t->symbol[i].name, name)) break;
        
    }
    if(i==t->symbol_index) {
        
        info->name[0] = 0;
        info->typename[0] = 0;
        info->arrayDimension = -1;
        return;
        
    }
    
    strcpy(info->name, t->symbol[i].name);
    strcpy(info->typename, t->symbol[i].typename);
    info->arrayDimension = t->symbol[i].arrayDimension;
    
}


void internal_initTypeTable(void) {
    
    internal_type = (TYPE_TABLE_ENTRY *)malloc(sizeof(TYPE_TABLE_ENTRY)*typeInitialCapacity);
    internal_type_length = typeInitialCapacity;
    internal_type_index = 0;
    
}

void internal_addType(char *name) {
    
    if(internal_type_index == internal_type_length) {
        
        TYPE_TABLE_ENTRY *newmemory;
        int newlength;
        
        newlength = internal_type_length + typeInitialCapacity;
        newmemory = (TYPE_TABLE_ENTRY *)malloc(sizeof(TYPE_TABLE_ENTRY)*newlength);
        memcpy(newmemory, internal_type, sizeof(TYPE_TABLE_ENTRY)*internal_type_length);
        free(internal_type);
        internal_type = newmemory;
        internal_type_length = newlength;
    }
    
    strcpy(internal_type[internal_type_index].name, name);
    internal_type[internal_type_index].sizeInBytes = 0;
    
    ++internal_type_index;
    
}

void internal_incTypeSize(int size) {
    
    internal_type[internal_type_index-1].sizeInBytes += size;
    
}

void internal_retrieveTypeInfo(char *name, TYPE_TABLE_ENTRY *info) {
    
    int i;
    for(i=0; i<internal_type_index; ++i) {
        
        if(!strcmp(internal_type[i].name, name)) break;
        
    }
    if(i==internal_type_index) {
        
        info->name[0] = 0;
        info->sizeInBytes = 0;
        return;
        
    }
    
    strcpy(info->name, internal_type[i].name);
    info->sizeInBytes = internal_type[i].sizeInBytes;
    
}


void resetTempInstrBuffer0(void) {
    
    tempInstrBuffer0->nInstructions = 0;
    tempInstrBuffer0->firstInstruction = NULL;
    tempInstrBuffer0->lastInstruction = NULL;

}
void resetTempInstrBuffer1(void) {
    
    tempInstrBuffer0->nInstructions = 0;
    tempInstrBuffer0->firstInstruction = NULL;
    tempInstrBuffer0->lastInstruction = NULL;
    
}
void resetTempInstrBuffer2(void) {
    
    tempInstrBuffer0->nInstructions = 0;
    tempInstrBuffer0->firstInstruction = NULL;
    tempInstrBuffer0->lastInstruction = NULL;
    
}

void internal_pushInt(int v) {
    
    if(intstack.index<intstack.size) {
        intstack.stack[intstack.index++] = v;
    }
    else return; // stack nothing. should grow buffer
    
}

int internal_popInt(void) {
    
    if(intstack.index<0) return -1;
    else return intstack.stack[intstack.index--];
    
}

void internal_pushIf(void) {
    
    if(ifstack.index<ifstack.size) {
        ifstack.index++;
    }
    else return; // stack nothing. should grow buffer
    
}

int internal_popIf(void) {
    
    if(ifstack.index<0) return -1;
    else return ifstack.index--;
    
}


void internal_init(void) {
    
    nTypes = 0;
    Type = NULL;
    
    nSwitches = 0;
    Switch = NULL;
    
    nUnits = 0;
    unit = NULL;
    
    scope = 0;
    nameOfLastUnit[0] = 0;
    nameOfLastFunction[0] = 0;
    
    curPC = 0;
    
    tmpVarCounter = 0;
    
    tempInstrBuffer0 = (EVENT_T *)malloc(sizeof(EVENT_T));
    tempInstrBuffer1 = (EVENT_T *)malloc(sizeof(EVENT_T));
    tempInstrBuffer2 = (EVENT_T *)malloc(sizeof(EVENT_T));
    resetTempInstrBuffer0();
    resetTempInstrBuffer1();
    resetTempInstrBuffer2();
    
    intstack.stack = (int *)malloc(sizeof(int)*100);
    intstack.size = 100;
    intstack.index = 0;
    
    ifstack.stack = (int *)malloc(sizeof(int)*100);
    ifstack.size = 100;
    ifstack.index = 0;
    
    internal_initSymbolTable();
    
    _UGLI_initAPIBinding();
    
    unit_function_param = nil;
    unit_nParams = 0;
    
}

int basicTypeFromName(char *type) {
    
    if(!strcmp(type, "byte")) return TYPE_BYTE;
    if(!strcmp(type, "short")) return TYPE_SHORT;
    if(!strcmp(type, "int")) return TYPE_INT;
    if(!strcmp(type, "float")) return TYPE_FLOAT;
    if(!strcmp(type, "double")) return TYPE_DOUBLE;
    if(!strcmp(type, "handle")) return TYPE_HANDLE;
    
    return TYPE_COMPOUND;
}

void incScope(void) {
    
    ++scope;
}

void decScope(void) {
    
    --scope;
    
}

void resetTmpVarCounter(void) {
    
    tmpVarCounter = 0;
    
}

void internal_generateNewTempVarName(char *dest) {
    
    sprintf(dest, "&t%d", tmpVarCounter++);
    
}

void internal_setUnitSuper(char *super) {
    
    strcpy(unit->superName, super);
    
    printf("which inherits from %s\n", super);
}

void internal_addNewVariable(char *name, char *type) { // context?? int context: add to Unit, to Func, suelta...
    
    VARIABLE_T *nv;
    int t;
    
    nv = (VARIABLE_T *)malloc(sizeof(VARIABLE_T));
    
    strcpy(nv->name, name);
    strcpy(nv->nameOfComplexType, type);
    
    if(scope==0) { strcpy(nv->scope, ".root"); }
    if(scope==1) { strcpy(nv->scope, nameOfLastUnit); }
    if(scope==2) { strcpy(nv->scope, nameOfLastFunction); }
    
    nv->isSimpleType = 0;
    nv->simpleType = TYPE_COMPOUND;
    t = basicTypeFromName(type);
    if(t!=TYPE_COMPOUND) {
        nv->isSimpleType = 1;
        nv->simpleType = t;
    }
    
        
    nv->next = unit->variable;
    unit->variable = nv;
    
    
    ++unit->nVariables;
    
}



void internal_addNewInstruction(int context) {
    
    INSTRUCTION_T *ni;
    
    ni = (INSTRUCTION_T *)malloc(sizeof(INSTRUCTION_T));
    
    ni->next = NULL;
    ni->PC = curPC++;
    
    printf("contexto: %d    ", context);
    printf("New instruction\n");
    
    switch(context) {
            
        case CONTEXT_STATE:
            if(unit->slots->state->lastInstruction) {
                unit->slots->state->lastInstruction->next = ni;
                unit->slots->state->lastInstruction = ni;
                }
            else
                unit->slots->state->lastInstruction = ni;
            if(!unit->slots->state->firstInstruction)
                unit->slots->state->firstInstruction = ni;
            
        
            
            ++unit->slots->state->nInstructions;
            break;
            
        case CONTEXT_EVENTHANDLER:
            if(unit->event->lastInstruction) {
                unit->event->lastInstruction->next = ni;
                unit->event->lastInstruction = ni;
            }
            else
                unit->event->lastInstruction = ni;
            if(!unit->event->firstInstruction)
                unit->event->firstInstruction = ni;
            ++unit->event->nInstructions;
            break;
            
        case CONTEXT_FUNCTION:
            if(unit->function->lastInstruction) {
                unit->function->lastInstruction->next = ni;
                unit->function->lastInstruction = ni;
            }
            else
            unit->function->lastInstruction = ni;
            if(!unit->function->firstInstruction)
            unit->function->firstInstruction = ni;
            ++unit->function->nInstructions;
            break;
            
        case CONTEXT_TEMP_0:
            if(tempInstrBuffer0->lastInstruction) {
                tempInstrBuffer0->lastInstruction->next = ni;
                tempInstrBuffer0->lastInstruction = ni;
            }
            else
                tempInstrBuffer0->lastInstruction = ni;
            if(!tempInstrBuffer0->firstInstruction)
                tempInstrBuffer0->firstInstruction = ni;
            ++tempInstrBuffer0->nInstructions;
            break;
        case CONTEXT_TEMP_1:
            if(tempInstrBuffer1->lastInstruction) {
                tempInstrBuffer1->lastInstruction->next = ni;
                tempInstrBuffer1->lastInstruction = ni;
            }
            else
                tempInstrBuffer1->lastInstruction = ni;
            if(!tempInstrBuffer1->firstInstruction)
                tempInstrBuffer1->firstInstruction = ni;
            ++tempInstrBuffer1->nInstructions;
            break;
        case CONTEXT_TEMP_2:
            if(tempInstrBuffer2->lastInstruction) {
                tempInstrBuffer2->lastInstruction->next = ni;
                tempInstrBuffer2->lastInstruction = ni;
            }
            else
                tempInstrBuffer2->lastInstruction = ni;
            if(!tempInstrBuffer2->firstInstruction)
                tempInstrBuffer2->firstInstruction = ni;
            ++tempInstrBuffer2->nInstructions;
            break;


            
    }
    
    
    
    lastInstr = ni;
    
}

void internal_setSrc1(char *s, int t) {
    
    strcpy(lastInstr->src1, s);
    lastInstr->isImmediate1 = t;
    
}

void internal_setSrc2(char *s, int t) {
    
    strcpy(lastInstr->src2, s);
    lastInstr->isImmediate2 = t;
    
}

void internal_setDest(char *d) {
    
    strcpy(lastInstr->dest, d);
    
}

void internal_setInstructionOp(int op) {
    
    lastInstr->instOp = op;
    printf("... of type ");
    switch(op) {
            case INSTR_ASSIGN:
            printf(" = \n");
            break;
        case INSTR_INC:
            printf(" ++ \n");
            break;
        case INSTR_ADD:
            printf(" + \n");
            break;
        case INSTR_MULT:
            printf(" * \n");
            break;
    }
    
}


 void internal_copyInstructionsFromBuffer(int context, int b) {
 
     EVENT_T *src;
 
     src = NULL;
 
     switch(b) {
 
            case 0:
                src = tempInstrBuffer0;
                break;
 
            case 1:
                src = tempInstrBuffer1;
                break;
 
            case 2:
                src = tempInstrBuffer2;
                break;
 
     }
    
     int i;
     INSTRUCTION_T *curInstr;
 
     if(!src) return;
 
    curInstr = src->firstInstruction;
    for(i=0; i<src->nInstructions; ++i) {
        internal_addNewInstruction(context);
        internal_setInstructionOp(curInstr->instOp);
        internal_setSrc1(curInstr->src1, curInstr->isImmediate1?SRC_IMMEDIATE:SRC_VAR);
        internal_setSrc2(curInstr->src2, curInstr->isImmediate2?SRC_IMMEDIATE:SRC_VAR);
        internal_setDest(curInstr->dest);
        
        curInstr = curInstr->next;
        
    }
 
 }

void internal_addNewUnit(char *name) {
    
    UNIT_T *nu;
    
    nu = (UNIT_T *)malloc(sizeof(UNIT_T));
    
    strcpy(nu->name, name);
    //if(super) {
    
    //    strcpy(nu->superName, super);
    
    
    //}
    //else {
        
        nu->superName[0] = 0;
        
    //}
    nu->super = NULL;
    nu->nInlets = 0;
    nu->nOutlets = 0;
    nu->inlets = NULL;
    nu->outlets = NULL;
    nu->nSlots = 0;
    nu->slots = NULL;
    nu->variable = NULL;
    nu->nVariables = 0;
    nu->event = NULL;
    nu->nEvents = 0;
    

    nu->next = unit;
    unit = nu;
    
    strcpy(nameOfLastUnit, name);
    
    ++nUnits;
    
    printf("added new unit %s", name);
    printf("\n");
    
    unit_function_param = nil;
    unit_nParams = 0;
    
}

void internal_setCurrentSwitchTypeName(char *t) {
    
    printf("... of type %s\n", t);
    strcpy(Switch->nameOfType, t);
}

char *internal_currentSwitchName(void) {
    
    return Switch->name;
    
}

char *internal_currentSwitchNameOfType(void) {
    
    return Switch->nameOfType;
    
}

INLET_T *internal_createInlet(void) {
    
    INLET_T *newInlet;
    
    newInlet = (INLET_T *)malloc(sizeof(INLET_T));
    
    return newInlet;
}

void internal_addNewFieldToType(void) {
    
    
}

void internal_setTypeName(char *n) {
    
    strcpy(Type->name, n);
    
    printf("...with name %s\n", n);
    
}

void internal_addCompoundVarToCurrentType(char *ctype, char *name) {
    
    FIELD_T *f;
    FIELD_T *nf;
    
    nf = (FIELD_T *)malloc(sizeof(FIELD_T));
    nf->isSimpleType = 0;
    strcpy(nf->name, name);
    strcpy(nf->nameOfComplexType, name);
    
    f = Type->field;
    

    nf->next = Type->field;
    Type->field = nf;
        

    
    ++Type->nFields;
    
    printf("... new compount var %s of type %s", name, ctype);
    
}

void internal_unitAddNewVariable(char *name, char *type, int dim) {
    
    int t;
    VARIABLE_T *nv;
    
    nv = (VARIABLE_T *)malloc(sizeof(VARIABLE_T));
    strcpy(nv->name, name);
    strcpy(nv->nameOfComplexType, type);
    nv->complexType = NULL;
    
    t = basicTypeFromName(type);
    
    if(t!=TYPE_COMPOUND) { // basic type
        
        nv->isSimpleType = 1;
        
        
        
        
    }
    else {
        
        nv->isSimpleType = 0;
        
        
    }
    
    
    if(!unit->variable) {
        
        nv->next = NULL;
        unit->variable = nv;
        
    }
    else {
        
        nv->next = unit->variable;
        unit->variable = nv;
        
    }
    
    nv->dimension = dim;
    
    ++unit->nVariables;
    
    printf("... new variable %s of type %s\n", name, type);
    
    
}

void internal_unitSetVariableInitialValue_int(int v) {
    
    switch(unit->variable->simpleType) {
            
        case TYPE_COMPOUND:
            exit(-1); // semantic error
            break;
        
        case TYPE_BYTE:
            unit->variable->data.b = (char)v;
            break;
            
        case TYPE_SHORT:
            unit->variable->data.s = (short)v;
            break;
            
        case TYPE_INT:
            unit->variable->data.i = (int)v;
            break;
            
        case TYPE_FLOAT:
            unit->variable->data.f = (float)v;
            break;
            
        case TYPE_DOUBLE:
            unit->variable->data.d = (double)v;
            break;
            
        case TYPE_HANDLE:
            unit->variable->data.h = (int)v;
            break;
            
            
    }
    
     printf("... with initial variable %d (_int called)\n", v);

}

void internal_unitSetVariableInitialValue_float(float v) {
    
    switch(unit->variable->simpleType) {
            
        case TYPE_COMPOUND:
            exit(-1); // semantic error
            break;
            
        case TYPE_BYTE:
            unit->variable->data.b = (char)v;
            break;
            
        case TYPE_SHORT:
            unit->variable->data.s = (short)v;
            break;
            
        case TYPE_INT:
            unit->variable->data.i = (int)v;
            break;
            
        case TYPE_FLOAT:
            unit->variable->data.f = (float)v;
            break;
            
        case TYPE_DOUBLE:
            unit->variable->data.d = (double)v;
            break;
            
        case TYPE_HANDLE:
            unit->variable->data.h = (int)v;
            break;
            
            
    }
    
    printf("... with initial variable %g (_float called)\n", v);
    
}


void internal_addBasicVarToCurrentType(char * type, char *name) {
    
    FIELD_T *f;
    FIELD_T *nf;
    char ttt[128];
    
    nf = (FIELD_T *)malloc(sizeof(FIELD_T));
    nf->isSimpleType = 1;
    //nf->simpleType = type;
    strcpy(nf->name, name);
    
    
    f = Type->field;
    
    if(!f) { // first field
        Type->field = nf;
        nf->next = NULL;
    }
    else {
        
        nf->next = Type->field;
        Type->field = nf;
        
    }
    
    ++Type->nFields;
    
    /*switch(type) {
            
        case 0:
            strcpy(ttt, "byte");
            strcpy(nf->nameOfComplexType, "UGLIbyte");
            break;
            
        case 1:
            strcpy(ttt, "short");
            strcpy(nf->nameOfComplexType, "UGLIshort");
            break;
            
        case 2:
            strcpy(ttt, "int");
            strcpy(nf->nameOfComplexType, "UGLIint");
            break;
            
        case 3:
            strcpy(ttt, "float");
            strcpy(nf->nameOfComplexType, "UGLIfloat");
            break;
            
        case 4:
            strcpy(ttt, "double");
            strcpy(nf->nameOfComplexType, "UGLIdouble");
            break;
            
        case 100:
            strcpy(ttt, "entity[] (handle)");
            strcpy(nf->nameOfComplexType, "UGLIhandle");
            break;
            
        default:
            strcpy(ttt, "unknown");
            break;
    }*/
    
    strcpy(nf->nameOfComplexType, type);
    printf("... new basic var %s of type %s\n", name, ttt);
    
}

void internal_addNewType(void) {
    
    TYPE_T *newType;
    
    newType = (TYPE_T *)malloc(sizeof(TYPE_T));
    strcpy(newType->name, "");
    newType->nFields = 0;
    newType->field = NULL;
    
    if(!newType) {
        exit(-1); // Should not happen!!!
    }
    
    if (!Type) {
        
        Type = newType;
        newType->next = NULL;
        
    }
    else {
        
        newType->next = Type;
        Type = newType;
        
    }
    
    ++nTypes;
    
    printf("New type added\n");
    
}




TYPE_T *internal_createType(void) {
    
    TYPE_T *newType;
    
    newType = (TYPE_T *)malloc(sizeof(TYPE_T));
    
    return newType;
}

void internal_addNewTypeToSwitch(void) {
    
    TYPE_T *n;
    
    n = internal_createType();
    
    Switch->type = n;
    
}

void internal_addNewInletToSwitch(void) {
    
    INLET_T *ni;
    
    ni = internal_createInlet();
    strcpy(ni->nameOfType, internal_currentSwitchNameOfType());
    
    printf("Adding inlet to switch %s\n", internal_currentSwitchName());
    printf("... of type %s\n", ni->nameOfType);
    
    if(!Switch->inlet) {
        
        Switch->inlet = ni;
        ni->next = NULL;
    }
    else {
        
        ni->next = Switch->inlet;
        Switch->inlet = ni;
        
    }
    
    Switch->nInlets++;
    printf("for a total of %d inlets in switch %s\n", Switch->nInlets, Switch->name);
}

void internal_unitAddNewSlot(char *name) {
    
    SLOT_T *ns;
    ns = (SLOT_T *)malloc(sizeof(SLOT_T));
    
    strcpy(ns->name, name);
    
    ns->nStates = 0;
    ns->index = unit->nSlots;
    
    ns->next = unit->slots;
    unit->slots = ns;
    
    ++unit->nSlots;
    
}

void internal_incrementStatePC(void) {
    
    unit->slots->state->statePC++;
    
}

void internal_unitAddNewState(char *name) {
    
    STATE_T *ns;
    
    ns = (STATE_T *)malloc(sizeof(STATE_T));
    
    ns->index = unit->slots->nStates;
    ns->statePC = 1;
    
    ns->next = unit->slots->state;
    unit->slots->state = ns;
    
    ++((unit->slots)->nStates);
    
    strcpy(ns->name, name);
    
    
}

void internal_setCurrentSwitchInletName(char *name) {
    
    strcpy(((INLET_T *)Switch->inlet)->name, name);
    printf("... inlet named %s\n", name);
    
}

void internal_setEventName(char *s) {
 
    strcpy(unit->event->name, s);
    
}

void internal_setFunctionName(char *s) {
    
    strcpy(unit->function->name, s);
    
    
}

void internal_functionAddParameter(char *pname, char *ptype) {

    // let's insert parameters in order
    FIELD_T *np, *curParam;
    
    np = (FIELD_T *)malloc(sizeof(FIELD_T));
    strcpy(np->name, pname);
    strcpy(np->nameOfComplexType, ptype);
    
    if(unit_function_param==nil) { // first
        unit_function_param = np;
    }
    else {
        
        curParam = unit_function_param;
        while(curParam->next) {
            curParam = curParam->next;
        }
        curParam->next = np;
        
    }
    
    ++unit_nParams;
    
}


void internal_setFunctionReturnType(char *type) {
    
    strcpy(unit->function->nameOfComplexType, type);
    
}

void internal_addNewFunction(void) {
    
    // functions can be declared on root context as well, but for
    // now we'll leave it to unit context
    
    FUNCTION_T *nf;
    
    nf = (FUNCTION_T *)malloc(sizeof(FUNCTION_T));
    
    nf->nInstructions = 0;
    nf->firstInstruction = nf->lastInstruction = NULL;
    
    nf->next = unit->function;
    unit->function = nf;
    
    ++unit->nFunctions;
    
    unit->function->param = unit_function_param;
    unit->function->nParams = unit_nParams;
    
    unit_function_param = nil;
    unit_nParams = 0;
    
}

void internal_addNewEvent(void) {
    
    EVENT_T *ne;
    
    ne = (EVENT_T *)malloc(sizeof(EVENT_T));
    
    ne->nInstructions = 0;
    ne->firstInstruction = ne->lastInstruction = NULL;
    
    ne->next = unit->event;
    unit->event = ne;
    
    ++unit->nEvents;
    
}

void internal_addNewSwitch(void) {
    
    SWITCH_T *newSwitch;
    
    printf("New switch added!\n");
    
    newSwitch = (SWITCH_T *) malloc (sizeof(SWITCH_T));
    
    newSwitch->type = NULL;
    newSwitch->nameOfType[0] = 0;
    newSwitch->inlet = NULL;
    newSwitch->nInlets = 0;
    
    if(!newSwitch) {
        exit(-1); // Should not happen!!!
    }
    
    if (!Switch) {
        
        Switch = newSwitch;
        newSwitch->next = NULL;
    
    }
    else {
        
        newSwitch->next = Switch;
        Switch = newSwitch;
        
    }
    
    ++nSwitches;
    
}

void internal_setSwitchName(char *name) {
    
    printf("... with name %s\n", name);
    
    strcpy(Switch->name, name);
    
}

void internal_setSwitchType(TYPE_T *t) {
    
    Switch->type = t;
    
}



void internal_resolveSymbols(void) {
    
    
}

int getSizeOfType(char *t) {
    
    if(!strcmp(t, "UGLIint")) return sizeof(int);
    if(!strcmp(t, "UGLIbyte")) return sizeof(unsigned char);
    if(!strcmp(t, "UGLIfloat")) return sizeof(float);
    if(!strcmp(t, "UGLIdouble")) return sizeof(double);
    if(!strcmp(t, "UGLIhandle")) return sizeof(unsigned int);
    if(!strcmp(t, "string")) return sizeof(char [80]);
    
    TYPE_TABLE_ENTRY info;
    
    internal_retrieveTypeInfo(t, &info);
    if(info.name[0]) {
        
        return info.sizeInBytes;
        
    }
    
    return 0;
    
}

int internal_identifyDataTypeFromStringRep(char *str) {
    
    // first decide if it's constant or symbol
    int nQuotes, nDigits, nDots;
    int i, l;
    
    // check if it is a constant
        
        nDots = nQuotes = nDigits = 0;
        l = strlen(str);
        for(i=0; i<l; ++i) {
            
            if(str[i]=='.') ++nDots;
            if(str[i]=='\"') ++nQuotes;
            if(str[i]>='0' && str[i]<='9') ++nDigits;
            
        }
        
        if((nQuotes == 0) && (nDigits == l-1) && (nDots == 1)) return TYPE_FLOAT;
        if((nQuotes == 2) && (str[0]=='\"') && (str[l-1]=='\"')) return TYPE_STRING;
        if(nDigits == l) return TYPE_INT;
        
    
    
    return 0;
    
}

void internal_fail(char *format, ...)
{
    va_list args;
    
    va_start(args, format);
    vprintf(format, args);
    va_end(args);
    
    exit(0);
}

char * internal_getCurrentUnitName(void) {
    
    return unit->name;
    
}

void internal_setCurrentSlotInitialIndex(void) {
    
    unit->slots->initialIndex = unit->slots->nStates;
    
}

int internal_currentSlotStateIndex(void) {
    
    return unit->slots->nStates;
    
}

