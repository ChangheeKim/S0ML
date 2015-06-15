//
//  S0MLData.h
//
//  Created by 金昌熙 on 2015/05/29.
//  Copyright (c) 2015年 金昌熙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "S0MLHeader.h"
#import "S0MLObject.h"

@interface S0MLData : NSObject

@property S0MLHeader *header;
@property NSMutableArray *objects;

-(S0MLObject*)objectAtIndex:(NSInteger)index;
-(NSInteger)indexOfObject:(id)object;

@end