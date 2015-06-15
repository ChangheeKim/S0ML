//
//  S0MLHeader.m
//
//  Created by 金昌熙 on 2015/05/29.
//  Copyright (c) 2015年 金昌熙. All rights reserved.
//

#import "S0MLHeader.h"

@implementation S0MLHeader

-(instancetype)init{
	self = [super init];
	if(self){
		_elementNames = [NSMutableArray arrayWithCapacity:100];
	}
	
	return self;
}

@end
