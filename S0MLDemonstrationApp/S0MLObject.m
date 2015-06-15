//
//  S0MLObject.m
//
//  Created by 金昌熙 on 2015/05/29.
//  Copyright (c) 2015年 金昌熙. All rights reserved.
//

#import "S0MLObject.h"
#define CLASS_STRING 0
#define CLASS_BOOLEAN 1
#define CLASS_NUMBER 2

@implementation S0MLObject

-(instancetype)init{
	self = [super init];
	if(self){
		_elements = [NSMutableArray arrayWithCapacity:100];
	}
	
	return self;
}

-(NSString *)elementForName:(NSString *)name{

	for(int i = 0 ; i < [_header.elementNames count] ; i++ ){
		if([(NSString*)[_header.elementNames objectAtIndex:i] isEqualToString:name]){
			if([_elements count] > i)
				return (NSString*)[_elements objectAtIndex:i];
			else{
				NSLog(@"S0ML ERROR: element can't found for following element name: '%@'", name);
				NSLog(@"S0MLエラー：S0MLファイルに問題があります。「%@」に当たるelementを見つかりません。", name);
				NSLog(@"取り敢えずnilを返還します。");
				return nil;
			}
		}
	}
	
	NSLog(@"S0ML ERROR: element can't found for following element name: '%@'", name);
	NSLog(@"S0MLエラー：'%@'に当たるelementを見つかりません。", name);
	
	return nil;
}

-(NSString *)elementAtIndex:(NSInteger)index{
	return [_elements objectAtIndex:index];
}

-(NSInteger)integerWithElementForName:(NSString*)name{
	return [[self elementForName:name] integerValue];
}

-(NSInteger)integerWithElementAtIndex:(NSInteger)index{
	return [[self elementAtIndex:index] integerValue];
}

-(float)floatWithElementAtIndex:(NSInteger)index{
	return [[self elementAtIndex:index] floatValue];
}

-(float)floatWithElementForName:(NSString *)name{
	return [[self elementForName:name] floatValue];
}

-(double)doubleWithElementForName:(NSString*)name{
	return [[self elementForName:name] doubleValue];
}

-(double)doubleWithElementAtIndex:(NSInteger)index{
	return [[self elementAtIndex:index] doubleValue];
}

-(BOOL)boolWithElementForName:(NSString*)name{
	return [self boolWithString:[self elementForName:name]];
}

-(BOOL)boolWithElementAtIndex:(NSInteger)index{
	
	return [self boolWithString:[self elementAtIndex:index]];
}

-(BOOL)boolWithString:(NSString*)string{
	if([string isEqualToString:@"YES"]
	   || [string isEqualToString:@"Yes"]
	   || [string isEqualToString:@"yes"]
	   || [string isEqualToString:@"Y"]
	   || [string isEqualToString:@"y"]
	   || [string isEqualToString:@"true"]
	   || [string isEqualToString:@"TRUE"]
	   || [string isEqualToString:@"True"]
	   || [string isEqualToString:@"Positive"]
	   || [string isEqualToString:@"positive"]
	   || [string isEqualToString:@"O"]
	   || [string isEqualToString:@"o"]
	   || [string intValue] > 0){
		
		return YES;
	}else{
		return NO;
	}
}

@end