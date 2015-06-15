//
//  S0MLObject.h
//
//  Created by 金昌熙 on 2015/05/29.
//  Copyright (c) 2015年 金昌熙. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "S0MLHeader.h"


@interface S0MLObject : NSObject

@property NSMutableArray *elements;
@property S0MLHeader *header;

-(NSString*)elementForName:(NSString*)name;
-(NSString*)elementAtIndex:(NSInteger)index;

// NSStringを分析し、bool値を返還：
-(BOOL)boolWithString:(NSString*)string;

-(BOOL)boolWithElementAtIndex:(NSInteger)index;
-(BOOL)boolWithElementForName:(NSString*)name;

-(NSInteger)integerWithElementAtIndex:(NSInteger)index;
-(NSInteger)integerWithElementForName:(NSString*)name;

-(float)floatWithElementAtIndex:(NSInteger)index;
-(float)floatWithElementForName:(NSString*)name;

-(double)doubleWithElementAtIndex:(NSInteger)index;
-(double)doubleWithElementForName:(NSString*)name;

@end