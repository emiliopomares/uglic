//
//  UGLIFoundation.h
//  UGLITest
//
//  Created by Remilia Scarlet on 12/04/15.
//  Copyright (c) 2015 Digital Dreams Interactive. All rights reserved.
//

//#include "ParseUtils.h"
//#import <OpenGL/gl.h>
//#include <GL/glew.h>
#import <GLFW/glfw3.h>
#import "UGLIAPIBinder.h"
#import "GenericGrowableList.h"

//

typedef struct {
    
    float x, y;
    
} UGLIvec2;

typedef struct {
    
    float x, y, z;
    
} UGLIvec3;

typedef struct {
    
    float x, y, z, w;
    
} UGLIvec4;


extern UGLIuint UGLIScriptPlayer_instances;
extern UGLIuint UGLISprite2D_instances;

@interface ParseUtilz: NSObject {
    
    char ParseBuffer[1024];
    uint32_t offset;
    uint32_t start;
    char *data;
}

-(void) initParse:(char *)sdata;
-(int)isDigit: (char)d;
-(int) isInteger;
-(int) isFloat;
-(int) scanNextToken;
-(int) scanToEndOfLine;
-(int) scanToChar: (char) c;
-(int) scanNextString;
-(int) scanNextNumber;
-(void) rewind;
-(char *)token;
-(int) scanNextIdentifier;
-(int)offset;
-(void)nextLine;
-(void)seek:(int)o;

@end


#ifndef UGLITest_UGLIFoundation_h
#define UGLITest_UGLIFoundation_h


#endif

#define INSTANCES_SOFT_LIMIT 1000
#define INSTANCES_HARD_LIMIT 2000

#define _UGLI_MAX_PARAMETER_HARD_VALUE 50
#define _UGLI_MAX_TEMP_HARD_VALUE 50
#define _UGLI_MAX_STRING_HARD_VALUE 128
// WARNING UGLI_HARD_VALUES are to be changed by an external file if needed
// WARNING UGLILog every time a static list overflows, so developer can know

#define UGLIuint unsigned int

#define UGLI_INTERPOLATION_NEAREST 0
#define UGLI_INTERPOLATION_LINEAR 1
#define UGLI_INTERPOLATION_CUBIC 2

#define UGLI_TYPE_BYTE 0
#define UGLI_TYPE_SHORT 1
#define UGLI_TYPE_INT 2
#define UGLI_TYPE_FLOAT 3
#define UGLI_TYPE_DOUBLE 4
#define UGLI_TYPE_STRING 5
#define UGLI_TYPE_HANDLE 100
#define UGLI_TYPE_USER -1

#define UGLIhandle int


#define UGLI_RENDITY_SPRITE2D 0
#define UGLI_RENDITY_SPRITE3D 1
#define UGLI_RENDITY_TILEMAP2D 2
#define UGLI_RENDITY_NONE -1


typedef struct {
    
    void *data;
    int dim;
    int type;
    int *maxdim;
    int *indexes;
    int dsize;
    char name[128];
    UGLIhandle parent;
    
    
} UGLIArray_T;

typedef struct {
    
    void *ptr;
    int type;
    
} UGLI_Rendity_t;


@interface UGLIComponent: NSObject {
    
    int componentType;
    void *next; // next component
    void *node; // the UGLINode this UGLIComponent is attached to...
    
}

-(void)update;
-(void)onAttach;
-(void)onDetach;

@end


@interface UGLINode : NSObject {
    
@public char unitName[128];
@public char instanceName[128];
    
    void **inlet; // list of pointers
    void **outlet; // list of pointers
    void ***outObject;
    int *nOutObjects;
    int **connectionIndex;
    
    int *PC; // list of PC's, one per slot
    int nOfSlots;
    
    UGLIhandle parent; // parent of this node, -1 for MasterController/root
    void *parentNode; // parent; NULL for MasterController/root
    
    // add list of states, functions, etc...
    NSMutableArray *slot;
    
    //status
    int frozen; // if frozen == 0 do not update()
    int markedForRemoval; // if market for removal, the entity will be killed at the end of the cycle
    
    int dead; // set to 1 if the node is "free": shall not be updated
    
    int rendityType;
    
    UGLIComponent *nextComponent; // pointer to the first of list of attachable components
    
}
-(int)rendityType;
-(void)freeze;
-(void)kill;
-(void *)addressOfVariable: (char *)name;
-(void)update;
-(void)updateComponents;
-(char *)getUnitName;
-(int)getInstanceNumber;
-(void)setNofSlots:(int)n;
@end


#define UGLIScriptPlayer_Playing 0
#define UGLIScriptPlayer_Stopped 1
#define UGLIScriptPlayer_Finished 2
#define UGLIScriptPlayer_Waiting 3

#define UGLIScriptPlayer_TimeBase_Frames 0
#define UGLIScriptPlayer_TimeBase_RealTime 1


@interface UGLIScriptPlayer: UGLINode {
    
    int head;
    long startFrame;
    long startTime; // in ms
    int status;
    int timeBase;
    
    long frameOfNextExecution;
    long timeOfNextExecution; // in ms
    
    long elapsedFrames;
    long elapsedTime;
    
    int timer;
    
    char *data;
    int dataLength;
    
    
    
    ParseUtilz* parser;
    
    
}

-(void)startScript;
-(void)pauseScript;
-(void)stopScript;
-(void)loadScriptFromResource: (int)r;
-(void)loadScriptFromFilename: (char *)fn;

@end

typedef struct {
    
    char name[_UGLI_MAX_STRING_HARD_VALUE];
    char value[_UGLI_MAX_STRING_HARD_VALUE];
    
} _UGLIDispatcher_parameter_T;

typedef struct {
    
    _UGLIDispatcher_parameter_T param[_UGLI_MAX_PARAMETER_HARD_VALUE];
    int nParams;
    int capacity;
    
} _UGLIDispatcher_param_list_T;

typedef struct {
    
    char value[_UGLI_MAX_STRING_HARD_VALUE];
    
} _UGLIDispatcher_TempVariable_T;

typedef struct {
    
    _UGLIDispatcher_TempVariable_T temp[_UGLI_MAX_TEMP_HARD_VALUE];
    int nElements;
    int selected;
    int capacity;
    
} _UGLIDispatcher_TempVariable_list_T;

@interface UGLIDispatcher: NSObject {
    
    // max instances soft limit
    // max instances hard limit
    int _instances_soft_limit;
    int _instances_hard_limit;
    
    int firstFreeIndex;
    
    NSMutableArray *entities;
    
    _UGLIDispatcher_param_list_T param;
    _UGLIDispatcher_TempVariable_list_T temp;
    
    UGLIAPIBinder *binder;
    
    UGLINode *curNode;
    int curHandle;
    int curEntity; // entity in execution just one!
    UGLINode *curEntityNode; // entity in execution just one!
    
    
}

- (char*)getParameterByName: (char *)name;
- (char*)getParameter: (int)index;
- (char*)getParameterName: (int)index;
- (void)setCurrentHandle:(int)handle; // WARNING type= UGLIHandle
- (void)setCurrentHandleByName: (char *)name;
- (void)killEntityByHandle: (UGLIhandle) h;
@end






@interface UGLIList: NSObject {
    
    int used;
    //NSMutableArray *contents;
    int nElements;
    int capacity;
    int *contents;
    int head;
    
}

@end

@interface UGLIBaseList: NSObject { // a list whose elements won't shift index
    // on element deletion
    
    int used;
    //NSMutableArray *contents;
    int nElements;
    int maxElement;
    int capacity;
    void **contents;
    int head;
    
}

@end



UGLIhandle spawn_UGLIScriptPlayer(void);
UGLIhandle spawn_UGLISprite2D(void);














/*   UGLI Internal UNITS   */

@interface UGLITransform2D:UGLINode {
    
    float x, y;
    float a;
    float sx, sy;
    float px, py;
    
    
    float *x_inlet_connection, *y_inlet_connection;
    
    float *a_inlet_connection;
    
    float *sx_inlet_connection; float *sy_inlet_connection;
    
}

-(UGLIfloat)x;
-(UGLIfloat)y;
-(UGLIfloat)angle;
-(UGLIfloat)scaleX;
-(UGLIfloat)scaleY;
-(void)setX:(UGLIfloat)nx;
-(void)setY:(UGLIfloat)ny;
-(void)incX:(UGLIfloat)xi;
-(void)incY:(UGLIfloat)yi;
-(void)setScaleX:(UGLIfloat)newSx;
-(void)setScaleY:(UGLIfloat)newSy;
-(void)setScale:(UGLIfloat)newS;
@end

@interface UGLISprite2D : UGLITransform2D { // do we create the UGLITransform2D class??? yessssss
    
    int _inlet_in_Face; // inlet
    UGLIuint face; // this is an index to the resource
    UGLIuint nOfFaces;
    float scaleX, scaleY;
    //UGLIGPUTexInfo_t *faceInfo;
    //UGLIuint *faceIndexes; // resource index for each face
    GenericGrowableList *faceIndex;
    //UGLIvec2 center;
    int currentRes;
    
    int flipH, flipV;
    
    int visible;
    
    
}
-(UGLIuint)currentResource;
-(float)width;
-(float)height;
-(float)widthInPixels;
-(float)heightInPixels;
-(void)assignResource:(int)rid toFace:(int)f;
-(void)setFace:(int)f;
@end

@interface UGLICharacter2D : UGLITransform2D {
    
    GenericGrowableList *sprites;
    GenericGrowableList *anims;
    
}

-(void)setAnim:(int)i;

@end


@interface UGLIAnimCurve : UGLINode {
    
    float _inlet_in_Time; // time is a inlet
    int interpolationType; // 0 nearest, 1 linear, 2 kubix guess this should also be an inlet
    //float *time;
    //UGLIuint time_length;
    //float *value;
    //UGLIuint value_length;
    //float maxTime;
    int dimension;
    //GenericGrowableList **value;
    NSMutableArray *value;
    GenericGrowableList *keyframeTime; // index correspondence between these two
    
}

@end


typedef struct {
    
    UGLIfloat *data; // data to upload to the GPU. NULL if partition empty
    GLint startIndex;
    
} UGLITilemapPartition;

@interface UGLITilemap:UGLITransform2D {
    
    UGLIuint tilesize; // in scaled pixels
    
    UGLIuint hSize, vSize; // in tiles
    UGLIuint partitionHSize, partitionVSize; // size of the partition
    
    uint32_t **mapdata; // format mapdata[row][column]
    //UGLITilemapPartition **part;
    
    UGLIuint hWrap, vWrap;
    
}

@end

#define UGLI_ALIGNMENT_CENTERED 0
#define UGLI_ALIGNMENT_LEFT 1
#define UGLI_ALIGNMENT_RIGHT 2
#define UGLI_ALIGNMENT_JUSTIFIED 3

typedef struct {
    
    UGLIuint pu1, pv1, pu2, pv2;
    UGLIfloat u1, v1, u2, v2;
    
} UGLIFontSymbolDefinition_t;

@interface UGLIBitmapFontText:UGLITransform2D {
    
    unsigned char *message;
    
    UGLIuint alignment;
    
    UGLIFontSymbolDefinition_t def[256];
    
}
-(void)setSymbolDefinitionIndex: (int)idx u1:(int)U1 v1: (int)V1 u2:(int)U2 v2:(int)V2;
@end
