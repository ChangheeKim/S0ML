//
//  S0MLData.m
//
//  Created by 金昌熙 on 2015/05/29.
//  Copyright (c) 2015年 金昌熙. All rights reserved.
//

#import "S0MLData.h"

@implementation S0MLData

-(instancetype)init{
	self = [super init];
	if(self){
		_objects = [NSMutableArray arrayWithCapacity:100];
	}
	
	return self;
}

-(S0MLObject *)objectAtIndex:(NSInteger)index{
	return [_objects objectAtIndex:index];
}

-(NSInteger)indexOfObject:(id)object{
	return [_objects indexOfObject:object];
}

@end
