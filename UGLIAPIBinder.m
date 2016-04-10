//
//  UGLIAPIBinder.m
//  UGLIBinder
//
//  Created by Flandre Scarlet on 10/12/14.
//  Copyright (c) 2014 Digital Dreams Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UGLIFoundation.h"



void _UGLI_initAPIBinding(void);

#define TRUE 1
#define FALSE 0

//#include "UGLI_internal.h"

// these defines are part of UGLI.h
//#include <UGLI.h>
// etc...


/*
 typedef struct {
 
 void *key;
 void *value;
 int length;
 int index;
 
 } UGLI_DB;
 
 typedef struct { // we want a global list of databases to hold information about every unit and entity
 UGLI_DB *DB;
 UGLIint DB_length;
 UGLIint DB_index;
 } UGLI_MASTER_DB;
 
 UGLI_MASTER_DB UGLI_masterDB;
 
 void UGLI_initMasterDB(void) {
 
 UGLI_masterDB.DB = (UGLI_DB *)malloc(sizeof(UGLI_DB)*100);
 UGLI_masterDB.DB_length = 100;
 UGLI_masterDB.DB_index = 0;
 
 }
 
 UGLIint UGLI_createDB(UGLIchar *name, UGLIuint keySize, UGLIuint valueSize) {
 
 UGLI_masterDB.DB[UGLI_masterDB.DB_index].length = 100;
 UGLI_masterDB.DB[UGLI_masterDB.DB_index].index = 0;
 
 
 }*/

UGLI_UNIT_INFO UGLI_unitInfo;

UGLIuint UGLI_getUnitIndexByName(char *name) {
    
    int i;
    for(i=0; i<UGLI_unitInfo.nUnits; ++i) {
        
        if(!strcmp(UGLI_unitInfo.unit[i].name, name)) return i;
        
    }
    
    return -1;
    
}

UGLI_info UGLI_getUnitInfo(UGLIint unitIndex, UGLIuint infoType) {
    
    UGLI_info res;
    
    res.valid = FALSE;
    if(infoType == UGLI_INFO_NAME) {
        
        res.stringValue = UGLI_unitInfo.unit[unitIndex].name;
        res.valid = TRUE;
        
    }
    if(infoType == UGLI_INFO_NENTITIES) {
        
        res.intValue = UGLI_unitInfo.unit[unitIndex].nOfEntities;
        res.valid = TRUE;
        
    }
    
    
    return res;
    
}

UGLI_info UGLI_getEntityInfo(UGLIint unitIndex, UGLIuint infoType) { // DUMMY. REPLACE
    
    UGLI_info res;
    
    res.valid = FALSE;
    if(infoType == UGLI_INFO_NAME) {
        
        res.stringValue = UGLI_unitInfo.unit[unitIndex].name;
        res.valid = TRUE;
        
    }
    if(infoType == UGLI_INFO_NENTITIES) {
        
        res.intValue = UGLI_unitInfo.unit[unitIndex].nOfEntities;
        res.valid = TRUE;
        
    }
    
    
    return res;
    
}


// API

void UGLI_quit(void) {
    
    exit(0);
    
}

void UGLI_log_int(int v) {
    
    printf("%d\n", v);
    
}

void UGLI_log_float(float f) {
    
    printf("%f\n", f);
    
}

void UGLI_log_string(char *str) {
    
    printf("%s\n", str);
    
}

NSMutableArray *_handle;

UGLIhandle UGLI_entityByName(char *n) {
    
    UGLIhandle res; // how do we cope with memory management
    int searchType;
    
    // 1) create new collection
    // 2) add entity indexes to collection
    // 3) create new handle name and return handle
    
    [_handle removeAllObjects];
    // wildcard rules must be simple: *, *suffix, prefix* just these three
    if(strlen(n)==1 && n[0]=='*') {
        searchType = 0;
    }
    else if (strlen(n)>1 && n[0]=='*') {
        searchType = 1;
    }
    else if (strlen(n)>1 && n[strlen(n)-1]=='*') {
        searchType = 2;
    }
    switch (searchType) {
            
        case 0:
            
            break;
        case 1:
            break;
        case 2:
            break;
            
    }
    
    return res;
    
}


void UGLI_clear(void) {
    
    printf("UGLI_clear executed!\n");
    
}

void UGLI_setClearColor4f(float r, float g, float b, float a) {
    
    //printf("UGLI_setClearColor4f %g %g %g %g executed!\n", r, g, b, a);
    //glClearColor(r, g, b, a);
    
}

void UGLI_setClearColor4i(UGLIbyte r, UGLIbyte g, UGLIbyte b, UGLIbyte a) {
    
    //printf("UGLI_setClearColor4i %d %d %d %d executed!\n", r, g, b, a);
    //glClearColor((((float)r)/255.0), (((float)g)/255.0), (((float)b)/255.0), (((float)a)/255.0));
    
}

UGLIint UGLI_spawnByName(UGLIchar *unitName, char *name) {
    
    printf("UGLI_spawnByName executed!\n");
    
    return 1;
    
}

UGLIint UGLI_spawnByIndex(UGLIuint unitIndex, char *name) {
    
    printf("UGLI_spawnByName executed!\n");
    
    return 1;
    
}

UGLIint UGLI_spawnByHandleType(UGLIhandle hanle, char *name) {
    
    printf("UGLI_spawnByHandleType executed!\n");
    
    return 1;
}

/*
@interface UGLI_APIBind : NSObject  {
    
@public UGLIchar name[UGLI_MAX_SYMBOL_NAME];
@public UGLIuint nParams;
@public NSString *(*call)(UGLI_APIBind *o, int mode);
@public UGLI_PassedParam *passedParam;
@public UGLIuint passedParam_length;
@public UGLI_RequiredParam *requiredParam;
@public UGLIuint requiredParam_length;
@public UGLI_PassedParam *retParam;
    
@public UGLIuint nOfregisteredParameters;
@public UGLIuint maxParameters;
    
}

@end
*/
@implementation UGLI_APIBind

-(id)init {
    
    passedParam = nil;
    passedParam_length = 0;
    
    requiredParam = nil;
    requiredParam_length = 0;
    
    retParam = (UGLI_PassedParam *)malloc(sizeof(UGLI_PassedParam));
    
    return self;
    
}

-(UGLI_RequiredParam *)searchParam: (UGLIchar *)s {
    
    if(s==nil) return nil;
    char *temp;
    
    int i;
    for(i=0; i<requiredParam_length; ++i) {
        
        if(!strcmp(requiredParam[i].p.name, s)) return &requiredParam[i];
        
    }
    return nil;
    
}

UGLIint getIntegerFrom(UGLI_PassedParam *pp) {
    
    switch(pp->type) {
            
        case TYPE_INT:
            return pp->intValue;
            break;
        case TYPE_FLOAT:
            return (int)pp->floatValue;
            break;
        case TYPE_STRING:
            return (int)pp->stringValue[0];
            break;
        case TYPE_HANDLE:
            return (int)pp->handleValue;
            break;
            
    }
    
    return 0;
    
}

UGLIfloat getFloatFrom(UGLI_PassedParam *pp) {
    
    switch(pp->type) {
            
        case TYPE_INT:
            return (float)pp->intValue;
            break;
        case TYPE_FLOAT:
            return pp->floatValue;
            break;
        case TYPE_STRING:
            return (float)pp->stringValue[0];
            break;
        case TYPE_HANDLE:
            return (float)pp->handleValue;
            break;
            
    }
    
    return 0.0;
    
}

-(void)addParameter: (UGLI_PassedParam *)pp {
    
    // if(maxParameters>nOfregisteredParameters) {
    UGLI_RequiredParam *rq;
    rq = [self searchParam:pp->name];
    if(!rq) {
        UGLI_log_string("Warning: extraneous parameter ");
        UGLI_log_string(pp->name);
        UGLI_log_string(" calling function ");
        UGLI_log_string(name);
        UGLI_log_string("\n");
        return;
    }
    rq->p = *pp; // copy whole
    rq->specified = TRUE;
    ++nOfregisteredParameters;
    //}
    
    
}

-(NSString *)getCode {
    
    
    NSString *res;
    res = call(self, UGLI_GETNSSTRING);
    
    // reset parameter specification
    int i;
    nOfregisteredParameters = 0;
    for(i=0; i<requiredParam_length; ++i) {
        
        requiredParam[i].specified = FALSE;
    }
    
    return res;
    
}

-(void)performCall {
    
    call(self, UGLI_CALL);
    
    // reset parameter specification
    int i;
    nOfregisteredParameters = 0;
    for(i=0; i<requiredParam_length; ++i) {
        
        requiredParam[i].specified = FALSE;
    }
    
}

@end

/*@interface UGLI_APIBinder : NSObject {
    
    NSMutableArray *UGLI_APIFunction;
    UGLI_APIBind *currentFunction;
    
}

@end
*/
@implementation UGLIAPIBinder



-(id) init {
    
    UGLI_APIFunction = [[NSMutableArray alloc] initWithCapacity: 100];
    
    UGLI_APIBind *newbind;
    
    // register all UGLI API functions
    
    
    // UGLI_clear
    newbind = [[UGLI_APIBind alloc] init];
    strcpy(newbind->name, "clear");
    //newbind->call = &UGLI_clear_caller;
    newbind->requiredParam = nil;
    newbind->requiredParam_length = 0; // should not accept any parameters at all
    [UGLI_APIFunction addObject:newbind];
    
    
    // UGLI_setClearColor
    newbind = [[UGLI_APIBind alloc] init];
    //newbind->call = &UGLI_setClearColor_caller;
    strcpy(newbind->name, "setClearColor");
    newbind->requiredParam = (UGLI_RequiredParam *)malloc(sizeof(UGLI_RequiredParam)*4);
    newbind->requiredParam_length = 4;
    strcpy(newbind->requiredParam[0].p.name, "r");
    strcpy(newbind->requiredParam[1].p.name, "g");
    strcpy(newbind->requiredParam[2].p.name, "b");
    strcpy(newbind->requiredParam[3].p.name, "a");
    newbind->requiredParam[0].defaultFloat = 0.0;
    newbind->requiredParam[0].defaultInt = 0.0;
    newbind->requiredParam[1].defaultFloat = 0.0;
    newbind->requiredParam[1].defaultInt = 0.0;
    newbind->requiredParam[2].defaultFloat = 0.0;
    newbind->requiredParam[2].defaultInt = 0.0;
    newbind->requiredParam[3].defaultFloat = 0.0;
    newbind->requiredParam[3].defaultInt = 0.0;
    [UGLI_APIFunction addObject:newbind];
    
    
    // UGLI_spawn
    newbind = [[UGLI_APIBind alloc] init];
    strcpy(newbind->name, "spawn");
    newbind->requiredParam = (UGLI_RequiredParam *)malloc(sizeof(UGLI_RequiredParam)*2);
    newbind->requiredParam_length = 2;
    strcpy(newbind->requiredParam[0].p.name, "type");
    strcpy(newbind->requiredParam[1].p.name, "name");
    // this method has no default value for parameter
    //newbind->call = &UGLI_spawn_caller;
    [UGLI_APIFunction addObject:newbind];
    
    
    // UGLI_log
    newbind = [[UGLI_APIBind alloc] init];
    strcpy(newbind->name, "log");
    newbind->requiredParam = (UGLI_RequiredParam *)malloc(sizeof(UGLI_RequiredParam)*3);
    newbind->requiredParam_length = 3;
    strcpy(newbind->requiredParam[0].p.name, "intValue");
    strcpy(newbind->requiredParam[1].p.name, "floatValue");
    strcpy(newbind->requiredParam[2].p.name, "stringValue");
    //newbind->call = &UGLI_log_caller;
    [UGLI_APIFunction addObject:newbind];
    
    
    // UGLI_quit
    newbind = [[UGLI_APIBind alloc] init];
    strcpy(newbind->name, "quit");
    //newbind->requiredParam = (UGLI_RequiredParam *)malloc(sizeof(UGLI_RequiredParam)*3);
    newbind->requiredParam_length = 0;
    //newbind->call = &UGLI_quit_caller;
    [UGLI_APIFunction addObject:newbind];
    
    // UGLI_entityByName
    newbind = [[UGLI_APIBind alloc] init];
    strcpy(newbind->name, "entityByName");
    newbind->requiredParam = (UGLI_RequiredParam *)malloc(sizeof(UGLI_RequiredParam)*1);
    newbind->requiredParam_length = 1;
    strcpy(newbind->requiredParam[0].p.name, "name");
    //newbind->call = &UGLI_entityByName_caller;
    [UGLI_APIFunction addObject:newbind];
    
    
    // UGLI_playSound
    newbind = [[UGLI_APIBind alloc] init];
    strcpy(newbind->name, "playSound");
    newbind->requiredParam = (UGLI_RequiredParam *)malloc(sizeof(UGLI_RequiredParam)*1);
    newbind->requiredParam_length = 1;
    strcpy(newbind->requiredParam[0].p.name, "id");
    //newbind->call = &UGLI_playSound_caller;
    [UGLI_APIFunction addObject:newbind];
    
    
    // UGLI_playSoundByName
    newbind = [[UGLI_APIBind alloc] init];
    strcpy(newbind->name, "playSoundByName");
    newbind->requiredParam = (UGLI_RequiredParam *)malloc(sizeof(UGLI_RequiredParam)*1);
    newbind->requiredParam_length = 1;
    strcpy(newbind->requiredParam[0].p.name, "name");
    //newbind->call = &UGLI_playSoundByName_caller;
    [UGLI_APIFunction addObject:newbind];

    
    return self;
    
}

-(void)addFunction:(UGLI_APIBind *)func {
    
    [UGLI_APIFunction addObject:func];
    
}

-(void)selectFunctionByName:(char *)name {
    
    int i;
    currentFunction = nil;
    for(i=0; i<[UGLI_APIFunction count]; ++i) {
        
        UGLI_APIBind *cur;
        cur = [UGLI_APIFunction objectAtIndex:i];
        if(!strcmp(cur->name, name)) {
            currentFunction = cur; break;
        }
        
    }
    
}

-(void)addParameter:(UGLI_PassedParam *)p {
    
    [currentFunction addParameter:p];
    
}

-(void)execute {
    
    if(currentFunction==nil) return;
    
    [currentFunction performCall];
    
}

-(NSString *)getCode {
    
    if(currentFunction==nil) return @"";
    
    return [currentFunction getCode];
    
}

@end

UGLIAPIBinder *_UGLI_APIBinder;

/*@interface UGLI_APIFunctionCall : NSObject {
 
 char name[UGLI_MAX_SYMBOL_NAME];
 UGLI_PassedParam *passedParam;
 UGLIuint passedParam_length;
 UGLI_PassedParam *returnParam;
 
 }
 
 @end
 
 @implementation UGLI_APIFunctionCall
 
 @end*/



// each API function we want to register has to be
// accompanied by the _caller and _get_NSString methods





void _UGLI_initAPIBinding(void) { // The entirety of the UGLI API is exposed here
    
    UGLI_APIBind *newbind;
    
    _UGLI_APIBinder = [[UGLIAPIBinder alloc] init];
    
    //    _UGLI_APIFunction = [[NSMutableArray alloc] initWithCapacity:UGLI_API_FUNC_COUNT];
    
    // register all UGLI API functions
    
    
    // UGLI_clear
    newbind = [[UGLI_APIBind alloc] init];
    strcpy(newbind->name, "clear");
    //newbind->call = &UGLI_clear_caller;
    newbind->requiredParam = nil;
    newbind->requiredParam_length = 0; // should not accept any parameters at all
    [_UGLI_APIBinder addFunction:newbind];
    
    
    // UGLI_setClearColor
    newbind = [[UGLI_APIBind alloc] init];
    //newbind->call = &UGLI_setClearColor_caller;
    strcpy(newbind->name, "setClearColor");
    newbind->requiredParam = (UGLI_RequiredParam *)malloc(sizeof(UGLI_RequiredParam)*4);
    newbind->requiredParam_length = 4;
    strcpy(newbind->requiredParam[0].p.name, "r");
    strcpy(newbind->requiredParam[1].p.name, "g");
    strcpy(newbind->requiredParam[2].p.name, "b");
    strcpy(newbind->requiredParam[3].p.name, "a");
    newbind->requiredParam[0].defaultFloat = 0.0;
    newbind->requiredParam[0].defaultInt = 0.0;
    newbind->requiredParam[1].defaultFloat = 0.0;
    newbind->requiredParam[1].defaultInt = 0.0;
    newbind->requiredParam[2].defaultFloat = 0.0;
    newbind->requiredParam[2].defaultInt = 0.0;
    newbind->requiredParam[3].defaultFloat = 0.0;
    newbind->requiredParam[3].defaultInt = 0.0;
    [_UGLI_APIBinder addFunction:newbind];
    
    
    // UGLI_spawn
    newbind = [[UGLI_APIBind alloc] init];
    strcpy(newbind->name, "spawn");
    newbind->requiredParam = (UGLI_RequiredParam *)malloc(sizeof(UGLI_RequiredParam)*2);
    newbind->requiredParam_length = 2;
    strcpy(newbind->requiredParam[0].p.name, "type");
    strcpy(newbind->requiredParam[1].p.name, "name");
    // this method has no default value for parameter
    //newbind->call = &UGLI_spawn_caller;
    [_UGLI_APIBinder addFunction:newbind];
    
    
    // UGLI_log
    newbind = [[UGLI_APIBind alloc] init];
    strcpy(newbind->name, "log");
    newbind->requiredParam = (UGLI_RequiredParam *)malloc(sizeof(UGLI_RequiredParam)*3);
    newbind->requiredParam_length = 3;
    strcpy(newbind->requiredParam[0].p.name, "intValue");
    strcpy(newbind->requiredParam[1].p.name, "floatValue");
    strcpy(newbind->requiredParam[2].p.name, "stringValue");
    //newbind->call = &UGLI_log_caller;
    [_UGLI_APIBinder addFunction:newbind];
    
    
    // UGLI_quit
    newbind = [[UGLI_APIBind alloc] init];
    strcpy(newbind->name, "quit");
    //newbind->requiredParam = (UGLI_RequiredParam *)malloc(sizeof(UGLI_RequiredParam)*3);
    newbind->requiredParam_length = 0;
    //newbind->call = &UGLI_quit_caller;
    [_UGLI_APIBinder addFunction:newbind];
    
    // UGLI_entityByName
    newbind = [[UGLI_APIBind alloc] init];
    strcpy(newbind->name, "entityByName");
    newbind->requiredParam = (UGLI_RequiredParam *)malloc(sizeof(UGLI_RequiredParam)*1);
    newbind->requiredParam_length = 1;
    strcpy(newbind->requiredParam[0].p.name, "name");
    //newbind->call = &UGLI_entityByName_caller;
    [_UGLI_APIBinder addFunction:newbind];
    
    
    // Drum solo.... the API  for Poyete Land (UGLI v1.0) these are tunneled through [UGLIRuntime <whatevs>] calls
    // UGLI_log
    // UGLI_quit
    //
    // Dispatcher related functions:
    //
    // UGLI_getEntityByName
    // UGLI_invokeMethodByName
    // UGLI_setTarget
    // UGLI_invokeMethod (name: )
    // UGLI_addParam (address:  size: )
    //
    //
    // Renderer related functions:
    //
    // UGLI_CreateRenderLayer
    // UGLI_DeleteRenderLayer
    // UGLI_AddRenderEntity
    // UGLI_RemoveRenderEntity
    // UGLI_SetRenderLayer
    // UGLI_AddRenderFunction
    // UGLI_RemoveRenderFunction
    // UGLI_setCoordinateSystem
    // UGLI_setAxisScale
    // UGLI_getScreenAspectRatio
    // UGLI_setPan
    // UGLI_setRotation
    // UGLI_setScale
    // UGLI_getPan
    // UGLI_getScale
    // UGLI_getRotation
    //
    //
    // Input hub related functions:
    //
    // UGLI_getNumberOfKeyboards
    // UGLI_getNumberOfJoypads
    // UGLI_selectKeyboard
    // UGLI_selectJoypad
    // UGLI_joypadReadDigitalButton
    // UGLI_joypadReadAnalogButton
    // UGLI_keyboardReadKey
    //
    //
    // Resource related functions:
    //
    // UGLI_createPool (source:  poolname: )
    //      UGLI_createPoolWithName
    //      UGLI_createPoolFromSource
    // UGLI_setPoolName
    // UGLI_selectPool (name:  or  id: )
    //      UGLI_selectPoolByName
    // UGLI_loadPool
    // UGLI_isPoolLoading
    // UGLI_unloadPool
    // UGLI_forceUnloadPool
    // UGLI_destroyPool
    // UGLI_isPoolInRAM
    // UGLI_addResourceToPool (filename:   address: )
    //      addResourceToPoolFromFilename:
    //      addResourceToPoolFromRAMAddress
    // UGLI_setBaseDir
    // UGLI_slimPool
    // UGLI_getResourceInfo ( id:  or name: )
    //      getInfo:
    //      getInfoByName:
    //
    //
    //
    
    
    /*
     
     -(UGLIhandle)createPool;
     -(UGLIhandle)createPoolWithName: (char *)name;
     -(UGLIhandle)createPoolFromSource: (char *)filename; // source can be either a directory, a PAK file (same as dir), or a TXT file containing a list of files
     -(void)setPoolName: (char *)name;
     -(void)selectPool: (UGLIhandle)h;
     -(void)selectPoolByName: (char *)name;
     -(void)loadPool; // -> must detach to a different thread
     -(UGLIbool)isPoolStillLoading; // -> to show the "loading" screen
     -(void)unloadPool; // marks pool to be freed in case of need
     -(void)forceUnloadPool; // frees RAM no matter what
     -(void)destroyPool;
     -(UGLIbool)isPoolInRAM;
     -(void)addResourceToPoolFromFilename: (char *)filename;
     -(void)addResourceToPoolFromRAMAddress: (void *)address;
     -(void)setBaseDir: (char *)basedir;
     -(void)slimPool;
     -(char *)pwd;
     -(int)cd: (char *)relPath;
     -(void) resetPath;
     -(void)listCurrentPoolFileSources;
     -(void)createPoolFromSource: (char *)sourcename withName: (char *)poolName;
     -(UGLI_Resource_info_T *)getInfo:(int)index;
     -(UGLI_Resource_info_T *)getInfoByName:(char *)name;
     -(UGLI_Resource_Pool *)getCurrentPool;

     */
}

