//
//  UGLIAPIBinder.h
//  UGLIBinder
//
//  Created by Flandre Scarlet on 10/12/14.
//  Copyright (c) 2014 Digital Dreams Interactive. All rights reserved.
//

//#ifndef UGLIBinder_UGLIAPIBinder_h
//#define UGLIBinder_UGLIAPIBinder_h

#import <Foundation/Foundation.h>
//#import "UGLIFoundation.h"
#import "UGLIinternal.h"

#define UGLIhandle int
#define UGLIbool char

#define UGLI_MAX_SYMBOL_NAME 80
#define UGLI_MAX_STRING 1024
#define UGLIuint unsigned int
#define UGLIint int
#define UGLIfloat float
#define UGLIbyte unsigned char
#define UGLIdouble double
#define UGLIchar char


// we have to have a knowledge of API functions to bind
#define UGLI_API_FUNC_COUNT 3

#define UGLI_CALL 1
#define UGLI_GETNSSTRING 2

/*#ifndef TYPE_INT
 #define TYPE_INT 0
 #define TYPE_FLOAT 1
 #define TYPE_STRING 2
 #define TYPE_HANDLE 3
 #define TYPE_BYTE 4
#endif
*/

#define UGLI_INFO_NAME 0
#define UGLI_INFO_NENTITIES 1
#define UGLI_INFO_NEVENTS 2
#define UGLI_INFO_NFUNCTIONS 3


typedef struct {
    
    UGLIint type;
    UGLIchar name[UGLI_MAX_SYMBOL_NAME];
    UGLIint intValue;
    UGLIfloat floatValue;
    UGLIchar stringValue[UGLI_MAX_STRING];
    UGLIint handleValue;
    
} UGLI_PassedParam;


typedef struct {
    
    UGLI_PassedParam p;
    
    UGLIfloat defaultFloat;
    UGLIchar defaultString[UGLI_MAX_STRING];
    UGLIint defaultInt;
    UGLIint required; // BOOL
    UGLIhandle handleValue;
    UGLIhandle defaultHandle; // handle -1 means error: no handle handle -2: self handle
    
    UGLIbool specified;
    UGLIuint passedType;
    
    
} UGLI_RequiredParam;

typedef struct {
    
    UGLIchar name[UGLI_MAX_SYMBOL_NAME];
    UGLIuint nOfEntities;
    UGLIuint index;
    
} _UNIT_INFO;

typedef struct {
    
    int nUnits;
    _UNIT_INFO *unit;
    
} UGLI_UNIT_INFO;

typedef struct {
    
    char *stringValue;
    UGLIint intValue;
    UGLIfloat floatValue;
    UGLIbool valid;
    
} UGLI_info;

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
-(id)init;
-(UGLI_RequiredParam *)searchParam: (UGLIchar *)s;
-(void)addParameter: (UGLI_PassedParam *)pp;
-(NSString *)getCode;
-(void)performCall;
@end


@interface UGLIAPIBinder : NSObject {
    
    NSMutableArray *UGLI_APIFunction;
    UGLI_APIBind *currentFunction;
    
}
-(id)init;
-(void)addFunction:(UGLI_APIBind *)func;
-(void)selectFunctionByName:(char *)name;
-(void)addParameter:(UGLI_PassedParam *)p;
-(void)execute;
-(NSString *)getCode;
@end

extern UGLIAPIBinder *_UGLI_APIBinder;

void _UGLI_initAPIBinding(void);

//#endif
