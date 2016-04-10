//
//  GenericGrowableList.m
//  UGLITest
//
//  Created by Remilia Scarlet on 14/04/15.
//  Copyright (c) 2015 Digital Dreams Interactive. All rights reserved.
//

#import <Foundation/Foundation.h>
#include "GenericGrowableList.h"
#include "UGLIFoundation.h"


@implementation GenericGrowableList

-(id)initWidthDataSize: (int) d preserveIndexes: (int)p {
    
    capacity = 10; // WARNING constantize
    dSize = d;
    data = (void *)malloc(dSize * capacity);
    preserveIndexes = p;
    if(preserveIndexes) {
        occupied = (void *)malloc((capacity+1) * sizeof(char));
        memset(occupied, capacity+1, sizeof(char));
    }
    return self;
    
}

-(id)initWithCapacity: (int)c dataSize: (int) d preserveIndexes: (int)p {
    
    capacity = c;
    dSize = d;
    data = (void *)malloc(dSize * capacity);
    preserveIndexes = p;
    if(preserveIndexes) {
        occupied = (void *)malloc((capacity+1) * sizeof(char));
        memset(occupied, capacity+1, sizeof(char));
    }
    nElements = 0;
    return self;
    
}

-(void *)retrieveElementAtPosition: (int) index {
    
    if(index>=nElements) return NULL; // WARNING   esto hay que cambiarlo, semánticamente incorrecto, no funciona con PreserveIndexes
    //if(occupied[index])
    return data + dSize * index;
    //else return NULL;
    
}

-(void)storeElement: (void *)dPtr atPosition: (int)index {
    
    if(index<0) return;
    if(index>=capacity) {
        
        // grow array
        
    }
    void *dest;
    dest = data + dSize * index;
    memcpy(dest, dPtr, dSize);
    if(preserveIndexes) occupied[index] = 1;
    ++nElements;
    
}

-(int)findFreePosition {
    
    int i;
    
    if(!preserveIndexes) return nElements;
    
    for(i=0; i<capacity; ++i) {
        
        if(occupied[i]==0) return i;
        
    }
    
    return -1;
    
}

-(void)removeElementAtIndex: (int)index {
    
    UGLI_Rendity_t *d, *s;
    
    if(preserveIndexes) occupied[index] = 0;
    else {
        
        if(index<(nElements-1)) {
            void *dst; void *src;
        //for(i=index+1; i<nElements; ++i) {
            
            dst = data + dSize * (index);
            src = data + dSize * (index+1);
            s = src;
            d = dst;
            memcpy(dst, src, dSize * (nElements-1-index)); // shift elements
        }
        //}
        
    }
    --nElements;
    
}

-(bool)isValidIndex: (int)index {

    if(preserveIndexes) return occupied[index]==1;
    else return true;

}

-(void)resetList {
    
    if(preserveIndexes) {
        
        for(int i=0; i<capacity; ++i) {
            
            occupied[i] = 0;
            
        }
        
    }
    else {
        
        nElements = 0;
        
    }
    
}

-(int)count {
    
    return nElements;
}

@end