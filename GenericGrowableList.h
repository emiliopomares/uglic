//
//  GenericGrowableList.h
//  UGLITest
//
//  Created by Remilia Scarlet on 14/04/15.
//  Copyright (c) 2015 Digital Dreams Interactive. All rights reserved.
//

#ifndef UGLITest_GenericGrowableList_h
#define UGLITest_GenericGrowableList_h


#endif


@interface GenericGrowableList: NSObject {
    
    int capacity;
    int nElements;
    int preserveIndexes;
    
    void *data;
    char *occupied;
    
    int dSize;
    
    int lastIndex;
    
}
-(id)initWidthDataSize: (int) d preserveIndexes: (int)p;
-(id)initWithCapacity: (int)c dataSize: (int) d preserveIndexes: (int)p;
-(void *)retrieveElementAtPosition: (int) index;
-(void)storeElement: (void *)dPtr atPosition: (int)index;
-(int)findFreePosition;
-(void)removeElementAtIndex: (int)index;
-(void)resetList;
-(int)count;
-(bool)isValidIndex: (int)index;
@end