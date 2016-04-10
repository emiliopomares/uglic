//
//  translator.c
//  uglic.iOS_swift_metal_au
//
//  Created by Flandre Scarlet on 06/10/14.
//  Copyright (c) 2014 Digital Dreams Interactive. All rights reserved.
//

// translator module for the iOS_swift_metal_au target

#include <stdio.h>
#include "UGLIinternal.h"
#include <string.h>
#include <stdlib.h>
#include "UGLIAPIBinder.h"

#import <Foundation/Foundation.h>

extern SWITCH_T *Switch;
extern int nSwitches;

extern UNIT_T *unit;
extern int nUnits;

extern TYPE_T *Type;
extern int nTypes;

INTSTACK ifstack;

// this module will write out all gathered UGLI
// features as Swift code

/* :UNIT: player # UGLI.Character2D

    inlet xPos; // these are like variables to some extent
    inlet yPos;
 
    on event timeout {
 
        self.setState(slot: 1, state: dying);
 
    }
 
    handle enemy;
 
 behaviour:
 
slot 1 {
 
    state initial:
 
        goto walking;
 
    state walking:
 
    state dying:
 
        enemy = UGLI.getEntityByName("enemy*");
        enemy.event(timeout); // send timeout event to all
 
 }
 
 slot guacamole {
 
    state initial:
 
 }
 
*/



void flushToOutObjectCode(FILE *out) {
    
    /* the format of the object code */
}

/* how would a switch look like in swift 

struct myControlType {
 
     float x;
     float y;
     int a, b, c;
 
 }
 
class mySwitch {
 
    let nChannels = 3;
 
    var curChannel = 0;
 
    var input: [myControlType?];
 
    var output
 
    init() {
 
        input = [nil, nil, nil]
 
    }
 
    func setChannel (channel: Int) -> () {
 
        output = input[channel]
        curChannel = channel
 
    }
 
    func connect (in: myControlType) -> () {
 
        input[curChannel] = in
 
    }
 
 
 
 }
 
 */

int private_isNumber(char c) {
    
    if(c<'0') return 0;
    if(c>'9') return 0;
    return 1;
    
}


int isTempVariable(char *name) {
    
    if(!name) return 0;
    return name[0]=='&';
    
}

int intFromTempName(char *name) {
    
    int i;
    while(!private_isNumber(name[i++]));
    --i;
    return atoi(name+i);
    
}

typedef struct {
    
    char instrBuffer[128][8192]; char nameof[128][128];
    int nEntries;
    
} ASSIST_TEMPVAR_BUFFER_T;


void addTempVarEntry(ASSIST_TEMPVAR_BUFFER_T *b, char *name, char *contents) {
    
    strcpy(b->nameof[b->nEntries], name);
    strcpy(b->instrBuffer[b->nEntries], contents);
    ++b->nEntries;
    
}

char *private_getNextEmptyVarEntry(ASSIST_TEMPVAR_BUFFER_T *b, char *name) {
    
    ++b->nEntries;
    strcpy(b->nameof[(b->nEntries)-1], name);
    return b->instrBuffer[(b->nEntries)-1];
    
}

char *private_getTempVarEntry(ASSIST_TEMPVAR_BUFFER_T *b, char *name) {
    
    int i;
    
    for(i=0; i<b->nEntries; ++i) {
        
        if(!strcmp(b->nameof[i], name)) return b->instrBuffer[i];
        
    }
    
    return NULL;
    
}




void private_initTempVarBuffer(ASSIST_TEMPVAR_BUFFER_T *b) {
    
    int i;
    
    b->nEntries = 0;
    
    for(i=0; i<128; ++i) {
        
        b->nameof[i][0]=0;
        
    }
    
}



void flushSourceInstructions(INSTRUCTION_T *inst, int nInstr, FILE *out, int tabLevel, int slotIndex, int stateIndex, char *unitName) {
    
    ASSIST_TEMPVAR_BUFFER_T buf;
    char *writeTo;
    char *destiny, *source1, *source2;
    int tab;
    
    INSTRUCTION_T *curInstr;
    
    int i, j;
    
    private_initTempVarBuffer(&buf);
    
    curInstr = inst;
    for(j=0; j<nInstr; ++j) {
        
        
        
        
        
        if(private_getTempVarEntry(&buf, curInstr->src1))
            //source1 = buf.instrBuffer[intFromTempName(curInstr->src1)];
            source1 = private_getTempVarEntry(&buf, curInstr->src1);
        else source1 = curInstr->src1;
        
        if(private_getTempVarEntry(&buf, curInstr->src2))
            //source2 = buf.instrBuffer[intFromTempName(curInstr->src2)];
            source2 = private_getTempVarEntry(&buf, curInstr->src2);
        else source2 = curInstr->src2;
        
        if(!private_getTempVarEntry(&buf, curInstr->dest))
            //destiny = buf.instrBuffer[intFromTempName(curInstr->dest)];
            destiny = private_getNextEmptyVarEntry(&buf, curInstr->dest);
        else destiny = curInstr->dest;
        
        tab = tabLevel + ifstack.index;
        
        UGLI_PassedParam pp;
        SYMBOL_TABLE_ENTRY info;
        NSString *code;
        int usingUGLIAPINameSpace;
        char tmpString[80];
        int typete;
        
        usingUGLIAPINameSpace = 0;
        
        switch(curInstr->instOp) {
                
            case INSTR_TARGET:
                if(!strcmp(source1, "UGLI")) {
                    usingUGLIAPINameSpace = 1;
                    for(i=0; i<tab; ++i) fprintf(out, "\t");
                    fprintf(out, "[_UGLI_Runtime setTarget: UGLI_TARGET];");
                }
                else {
                    for(i=0; i<tab; ++i) fprintf(out, "\t");
                    fprintf(out, "[_UGLI_Runtime setTarget: %s];", source1);
                }
                
                break;
                
            case INSTR_IMWHILEINITIAL:
                for(i=0; i<tab; ++i) fprintf(out, "\t");
                fprintf(out, "while(");
                break;
                
            case INSTR_IMWHILEBODY:
                fprintf(out, "%s) {\n", source1);
                private_initTempVarBuffer(&buf);
                internal_pushIf();
                break;
                
            case INSTR_ENDOFIMWHILE:
                internal_popIf();
                for(i=0; i<tab-1; ++i) fprintf(out, "\t");
                fprintf(out, "}\n");
                break;
                
            case INSTR_IMFORINITIAL:
                for(i=0; i<tab; ++i) fprintf(out, "\t");
                fprintf(out, "for(");
                break;
                
            case INSTR_IMFORCONDIT:
                fprintf(out, "%s ; ", source1);
                private_initTempVarBuffer(&buf);
                break;
                
            case INSTR_IMFORACTION:
                fprintf(out, "%s ; ", source1);
                private_initTempVarBuffer(&buf);
                break;
                
            case INSTR_IMFORBODY:
                fprintf(out, "%s) {\n", source1);
                private_initTempVarBuffer(&buf);
                internal_pushIf();
                break;
                
            case INSTR_ENDOFIMFOR:
                internal_popIf();
                for(i=0; i<tab-1; ++i) fprintf(out, "\t");
                fprintf(out, "}\n");
                break;
                
            case INSTR_BREAK:
                for(i=0; i<tab; ++i) fprintf(out, "\t");
                fprintf(out, "goto _%s_slot%d;\n", unitName, slotIndex+1);
                break;
                
            case INSTR_GOTO:
                
                for(i=0; i<tab; ++i) fprintf(out, "\t");
                fprintf(out, "PC[%d] = %d;\n", slotIndex, atoi(destiny));
                break;
                
            case INSTR_IF:
                for(i=0; i<tab; ++i) fprintf(out, "\t");
                fprintf(out, "if(%s) {\n", source1);
                private_initTempVarBuffer(&buf);
                internal_pushIf();
                break;
                
            case INSTR_ENDIF:
                for(i=0; i<tab-1; ++i) fprintf(out, "\t");
                fprintf(out, "}\n");
                internal_popIf();
                break;
                
            case INSTR_NEWSTATE:
                for(i=0; i<tab; ++i) fprintf(out, "\t");
                fprintf(out, "--PC[%d];\n\n", slotIndex);
                for(i=0; i<tab-1; ++i) fprintf(out, "\t");
                fprintf(out, "}\n\n");
                for(i=0; i<tab-1; ++i) fprintf(out, "\t");
                fprintf(out, "if(PC[%d]==%d) {\n\n", slotIndex, stateIndex);
                break;
                
            case INSTR_ASSIGN:
                
                // statiassign
                sprintf(destiny, "%s = %s", curInstr->dest, source1);
                break;
                
            case INSTR_PARENTH:
                sprintf(destiny, "(%s)", source1);
                break;
                
            case INSTR_TEMPASSIGN:
                sprintf(destiny, "%s", source1);
                break;
                
            case INSTR_LT:
                sprintf(destiny, "%s < %s", source1, source2);
                break;
                
            case INSTR_GT:
                sprintf(destiny, "%s > %s", source1, source2);
                break;
                
            case INSTR_EQUALS:
                sprintf(destiny, "%s == %s", source1, source2);
                break;
                
            case INSTR_NOT_EQUAL:
                sprintf(destiny, "%s != %s", source1, source2);
                break;
                
            case INSTR_ADD:
                
                sprintf(destiny, "%s + %s", source1, source2);
                break;
                
            case INSTR_PREINC:
                sprintf(destiny, "++%s", source1);
                break;
                
            case INSTR_POSTINC:
                sprintf(destiny, "%s++", source1);
                break;
                
            case INSTR_DEC:
                sprintf(destiny, "--%s", source1);
                break;
                
            case INSTR_EOI:
                for(i=0; i<tab; ++i) fprintf(out, "\t");
                fprintf(out, "%s;\n", source1); // flush out entire instruction
                
                private_initTempVarBuffer(&buf); // initialize buffer
                
                break;
                
            case INSTR_CLEARTARGET:
                usingUGLIAPINameSpace = 0;
                for(i=0; i<tab; ++i) fprintf(out, "\t");
                fprintf(out, "[_UGLIRuntime setTarget: UGLI_SELF];\n");
                break;
                
            /*case INSTR_GOTO:
                fprintf(out, "PC[%d] = %d", slotIndex, );
                break;*/
                
            case INSTR_CALLFUNC:
                //strcpy(tmpString, "UGLI_");
                //staticall:
                //[_UGLI_APIBinder selectFunctionByName:strcat(tmpString, source1)];
                
                // dynacall:
                for(i=0; i<tab; ++i) fprintf(out, "\t");
                fprintf(out, "[_UGLI_Runtime selectFunctionByName: %s];\n", source1);
                
                
                //NSString *res;
                //res = [_UGLI_APIBinder getCode];
                //NSLog(res);
                //sprintf(destiny, "%s(", [str cStringUsingEncoding:NSUTF8StringEncoding]);
                break;
                
           /* case INSTR_DECLRPARAM:
                fprintf(out, "%s:")
                break;*/
                
            case INSTR_DEFPARAM:
                // first have to resolve...ds
                //UGLI_PassedParam p;
                
                // dynacall parameter passing:
                fprintf(out, "[_UGLI_Runtime addParameter:%s valueFromStringRep: %s];", source1, source2);
                
                
                
                //staticall
                /*
                strcpy(pp.name, source1);
                internal_retrieveSymbolInfo(source2, &info);
                if(info.arrayDimension == -1) {
                    typete = internal_identifyDataTypeFromStringRep(source2);
                    if(typete == TYPE_INT) {
                        pp.intValue = atoi(source2);
                        pp.type = TYPE_INT;
                    }
                    if(typete == TYPE_FLOAT) {
                        pp.floatValue = atof(source2);
                        pp.type = TYPE_FLOAT;
                    }
                    if(typete == TYPE_STRING) {
                        strcpy(pp.stringValue, source2);
                        pp.type = TYPE_STRING;
                    }
                }
                else {
                    pp.type = basicTypeFromName(info.typename);
                
                }
                [_UGLI_APIBinder addParameter:&pp];
                 */
                /*[_UGLI_APIBinder execute];
                
                p.floatValue = 0.75;
                p.type = TYPE_FLOAT;
                [_UGLI_APIBinder addParameter:&p];
                strcpy(p.name, "g");
                p.floatValue = 0.28;
                p.type = TYPE_FLOAT;
                [_UGLI_APIBinder addParameter:&p];
                NSLog([_UGLI_APIBinder getCode]);*/
                break;
                
            case INSTR_EOP:
                // look for function definition and fill params in correct order
                //sprintf(destiny+strlen(destiny), "%s)", source1);
                // staticall:
                //code = [_UGLI_APIBinder getCode];
                //sprintf(destiny, "%s", [code cStringUsingEncoding:NSUTF8StringEncoding]);
                
                
                // Dynacall:
                fprintf(out, "[_UGLI_Runtime executeFunction];\n");
                //     output (pointer format, whatever is it) goes to _UGLI_Accumulator
                
                break;
             
                
        }
        curInstr = (INSTRUCTION_T *)curInstr->next;
        
    }
    
    
}

void flushVCodeInstructions(INSTRUCTION_T *inst, int nInstr, FILE *out) {
    
    INSTRUCTION_T *curInstr;
    
    int j;
    
    curInstr = inst;
    for(j=0; j<nInstr; ++j) {
        
        fwrite(curInstr, 1, sizeof(curInstr)-sizeof(void *), out);
        curInstr = (INSTRUCTION_T *)curInstr->next;
        
    }
    
    
}


void flushToOutSource_cPlusPlus(char *version, FILE *out) {
    
    
}

void flushToVCode(char *version, FILE *out) {
    
    int k, j, s;
    UNIT_T *curUnit;
    UNIT_T *superUnit;
    
    SWITCH_T *curSwitch;
    TYPE_T *swType;
    
    TYPE_T *curType;
    FIELD_T *curField;
    
    EVENT_T *curEvent;
    
    struct {
        
        char version[20];
        int nTypes;
        int nUnits;
        
    } header;
    
    strcpy(header.version, "UGLIVCODE");
    strcat(header.version, version);
    header.nTypes = nTypes;
    header.nUnits = nUnits;
    
    fwrite(&header, 1, sizeof(header), out);
    
    curType = Type;
    for(k=0; k<nTypes; ++k) {
        
        fwrite(curType->name, 1, sizeof(curType)-sizeof(void *), out);
        
        curField = curType->field;
        for(j=0; j<curType->nFields; ++j) {
            
            fwrite(curField, 1, sizeof(curField)-sizeof(void *), out);
            curField = (FIELD_T *)curField->next;
        }
        
        curType = (TYPE_T *)curType->next;

        
    }
    
    for(k=0; k<nUnits; ++k) {
        
        
        curUnit = &unit[k];
        fwrite(curUnit, 1, sizeof(curUnit)-sizeof(UNIT_T_TRAILER), out);
        
        // print out unit properties & variables here //
        VARIABLE_T *cv;
        cv = curUnit->variable;
        for(j=0; j<curUnit->nVariables; ++j) {
            
            fwrite(cv, 1, sizeof(cv)-sizeof(VARIABLE_T_TRAILER), out);
            cv = cv->next;
            
        }
                
        curEvent = curUnit->event;
        for(j=0; j<curUnit->nEvents; ++j) {
            
            
            fwrite(curEvent, 1, sizeof(curEvent)-sizeof(EVENT_T_TRAILER), out);
            flushVCodeInstructions(curEvent->firstInstruction, curEvent->nInstructions, out);
            
            curEvent = (EVENT_T *)curEvent->next;
            
        }
        
        SLOT_T *curSlot;
        curSlot = curUnit->slots;
        for(j=0; j<curUnit->nSlots; ++j) {
            
            fwrite(curSlot, 1, sizeof(curSlot)-sizeof(SLOT_T_TRAILER), out);
            
            
        }
        

        
    }
    
}

void flushToOutSource_objc(char *version, FILE *out) {  // Objective-C language output

    int k, j, s, p;
    UNIT_T *curUnit;
    UNIT_T *superUnit;
    
    SWITCH_T *curSwitch;
    TYPE_T *swType;
    
    TYPE_T *curType;
    FIELD_T *curField;
    
    EVENT_T *curEvent;
    
    SLOT_T *curSlot;
    STATE_T *curState;
    
    
    char initValue[128];
    
    fprintf(out, "// Generated by uglicV%s Objective-C output\n\n", version);
    fprintf(out, "#include <UGLI.h>\n\n\n");
    
    // Flush out types
    
    
    curType = Type;
    for(k=0; k<nTypes; ++k) {
        
        fprintf(out, "typedef struct {\n\n");
        
        curField = curType->field;
        for(j=0; j<curType->nFields; ++j) {
            
            fprintf(out, "\t%s %s;\n", curField->nameOfComplexType, curField->name);
            curField = (FIELD_T *)curField->next;
        }
        
        fprintf(out, "} _user_%s;\n\n", curType->name);
        curType = (TYPE_T *)curType->next;
        
    }

    // print out all units
    
    for(k=0; k<nUnits; ++k) { // print out all units as classes
        
        curUnit = &unit[k];
        if(curUnit->super) {
            superUnit = curUnit->super;
            fprintf(out, "@interface _entity_%s: %s {\n", curUnit->name,
                    superUnit->name);
        }
        else if(curUnit->superName[0]) {
            fprintf(out, "@interface _entity_%s: %s {\n", curUnit->name,
                    curUnit->superName);
        }
        else { // no inheritance
            fprintf(out, "@interface _entity_%s {\n\n", curUnit->name);
        }
        
        // print out unit properties & variables here //
        VARIABLE_T *cv;
        cv = curUnit->variable;
        for(j=0; j<curUnit->nVariables; ++j) {
            
            SYMBOL_TABLE_ENTRY info;
            internal_retrieveSymbolInfo(cv->name, &info);
            // let's not handle impossible conditions for now
            
            if(info.arrayDimension>0) { // array
                fprintf(out, "\tUGLI_Array *%s;\n", cv->name);
            }
            else {
                if(!strcmp("string", cv->nameOfComplexType)) {
                    fprintf(out, "\tchar %s[%d];\n", cv->name, UGLI_MAXSTR);
                }
                else {
                    fprintf(out, "\t%s %s;\n", cv->nameOfComplexType, cv->name);
                }
            }
            cv = cv->next;
            
        }
        
        fprintf(out, "}\n");
        fprintf(out, "@end\n\n");
        fprintf(out, "@implementation _entity_%s\n", curUnit->name);
        
        fprintf(out, "-(id)init {\n\n");
        fprintf(out, "\t[super init];\n");
        cv = curUnit->variable;
        for(j=0; j<curUnit->nVariables; ++j) {
            
            SYMBOL_TABLE_ENTRY info;
            internal_retrieveSymbolInfo(cv->name, &info);
            // let's not handle impossible conditions for now
            
            if(info.arrayDimension>0) { // array
                int s = getSizeOfType(cv->nameOfComplexType);
                fprintf(out, "\t%s = [[UGLI_Array alloc] initWithElementSize: %d];\n", cv->name, s);
            }
            
            cv = cv->next;
            
        }
        
        curSlot = curUnit->slots;
        for(j=0; j<curUnit->nSlots; ++j) {
            
            curState = curSlot->state;
            int p = 0;
            for(s=0; s<curSlot->nStates; ++s) {
                p+=curState->statePC;
                curState = curState->next;
            }

            fprintf(out, "\tPC[%d] = %d; // %s.initial\n", j, p-curSlot->initialIndex-1, curSlot->name);
            curSlot = curSlot->next;
            
        }
        fprintf(out, "\treturn self;\n");
        fprintf(out, "}\n\n");
        
        curEvent = curUnit->event;
        for(j=0; j<curUnit->nEvents; ++j) {
            
            
            
            fprintf(out, "-(void) _eventHandler_%s {\n\n", curEvent->name);
            
            flushSourceInstructions(curEvent->firstInstruction, curEvent->nInstructions, out, 2, -1, -1, curUnit->name);
            
            fprintf(out, "\n}\n\n");
            curEvent = (EVENT_T *)curEvent->next;
            
        }
        
        // printout all functions
        FUNCTION_T *curFunc;
        FIELD_T *curParam;
        curFunc = curUnit->function;
        while(curFunc) {
            fprintf(out, "-(%s) _userFunction_%s", curFunc->nameOfComplexType, curFunc->name);
            
            curParam = curFunc->param;
            while(curParam) {
                fprintf(out, "%s: (%s)%s ", curParam->name, curParam->nameOfComplexType, curParam->name);
                curParam = curParam->next;
            }
            fprintf(out, " {\n\n");
            flushSourceInstructions(curFunc->firstInstruction, curFunc->nInstructions, out, 2, -1, -1, curUnit->name);
            fprintf(out, "}\n\n");
            curFunc = curFunc->next;
        }
        
        // printout all slots
        fprintf(out, "-(void) _ugli_implicit_update {\n\n");
        
        curSlot = curUnit->slots;
        int slotState;
        for(j=0; j<curUnit->nSlots; ++j) {

        
        curState = curSlot->state;
        slotState = 0;
            p = 0;
            for(s=0; s<curSlot->nStates; ++s) {
                p+=curState->statePC;
                curState = curState->next;
            }
            curState = curSlot->state;
            for(s=0; s<curSlot->nStates; ++s) {
                //for(p=0; p<curState->statePC; ++p) {

                    fprintf(out, "\tif(PC[%d]==%d) {\n\n", j, p-1);
                    flushSourceInstructions(curState->firstInstruction, curState->nInstructions, out, 2, j, slotState, curUnit->name);
                    
                    
                //}
                slotState += curState->statePC;
                p -= curState->statePC;
                fprintf(out, "\t\tgoto _%s_slot%d;\n\t}\n\n\n", curUnit->name, j+1);
                curState = curState->next;
            }
            fprintf(out, "_%s_slot%d: \n\n", curUnit->name, j+1);
            
            curSlot = curSlot->next;
        }
        fprintf(out, "}\n\n");
        
        
        fprintf(out, "@end\n\n");
        
       // fprintf(out, "}\n");
        
    }

    
}

/*
void flushToOutSource_swift(char* version, FILE *out) { // Swift language output
    
    int k, j;
    UNIT_T *curUnit;
    UNIT_T *superUnit;
    
    SWITCH_T *curSwitch;
    TYPE_T *swType;
    
    TYPE_T *curType;
    FIELD_T *curField;
    
    EVENT_T *curEvent;
    
    
    char initValue[128];
    
    fprintf(out, "// Generated by uglicV%s Swift output\n\n", version);
    
    
    // Flush out types
    
    
    curType = Type;
    for(k=0; k<nTypes; ++k) {
        
        fprintf(out, "struct %s%s {\n\n", "_user_", curType->name);
        
        curField = curType->field;
        for(j=0; j<curType->nFields; ++j) {
            
            fprintf(out, "\tvar %s: %s\n", curField->name, curField->nameOfComplexType);
            curField = (FIELD_T *)curField->next;
        }
        
        fprintf(out, "\tinit () {\n\n");
        
        curField = curType->field;
        for(j=0; j<curType->nFields; ++j) {
            
            if(curField->isSimpleType) {
                switch(curField->simpleType) {
                    case TYPE_BYTE:
                    case TYPE_SHORT:
                    case TYPE_INT:
                        strcpy(initValue, "0");
                        break;
                    case TYPE_FLOAT:
                    case TYPE_DOUBLE:
                        strcpy(initValue, "0.0");
                        break;
                }
                fprintf(out, "\t\t%s = %s\n", curField->name, initValue);
            }
       
            
            curField = (FIELD_T *)curField->next;
        }
        
        fprintf(out, "\t}\n\n");
        
        fprintf(out, "}\n\n");
        curType = (TYPE_T *)curType->next;
        
    }
    
    
    
    
    // Flush out switches
    

    for(k=0; k<nSwitches; ++k) { // print out all switches
        
        curSwitch = &Switch[k];
        swType = curSwitch->type;
        
        
        
        fprintf(out, "class %s%s {\n", "_user_", curSwitch->name);
        
        fprintf(out, "\t// This is a switch\n");
        fprintf(out, "\tlet nChannels = %d\n", curSwitch->nInlets);
        fprintf(out, "\tvar curChannel = 0\n");
        fprintf(out, "\tvar inlet: [%s?]\n\n", swType->name);
        fprintf(out, "\tvar outlet: %s?\n", swType->name);
        fprintf(out, "\tinit () {\n\n");
        fprintf(out, "\t\tinlet = [nil");
           for(j=1; j<curSwitch->nInlets; ++j) {
               fprintf(out, ", nil");
           }
           fprintf(out, "]\n\n\t}");
        
        fprintf(out, "\tfunc setChannel(c: Int) {\n\n");
        fprintf(out, "\t\tcurChannel = c\n");
        fprintf(out, "\t\toutlet = inlet[c]\n");
        fprintf(out, "\t}\n\n");
        fprintf(out, "\tfunc channelByName(n: String) -> Int {\n");
        fprintf(out, "\t\tswitch n {\n");
        
        
        
        fprintf(out, "\t\t}\n");
        
        fprintf(out, "\t}\n");
        
        
        fprintf(out, "}\n");
        
    }
    
    
    
    
    for(k=0; k<nUnits; ++k) { // print out all units as classes
        
        curUnit = &unit[k];
        if(curUnit->super) {
            superUnit = curUnit->super;
            fprintf(out, "class %s: %s {\n", curUnit->name,
                    superUnit->name);
        }
        if(curUnit->superName[0]) {
            fprintf(out, "class %s: %s {\n", curUnit->name,
                    curUnit->superName);
        }
        else { // no inheritance
            fprintf(out, "class %s {\n\n", curUnit->name);
        }
        
        curEvent = curUnit->event;
        for(j=0; j<curUnit->nEvents; ++j) {
            
            
            
            fprintf(out, "\tfunc _eventHandler_%s() -> () {\n\n", curEvent->name);
            
            flushSourceInstructions(curEvent->firstInstruction, curEvent->nInstructions, out, 2);
            
            fprintf(out, "\n\t}\n");
            curEvent = (EVENT_T *)curEvent->next;
            
        }
        
        fprintf(out, "}\n");
        
    }
    
}
 */
