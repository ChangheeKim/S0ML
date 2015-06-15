//
//  S0ML.m
//
//  Created by Changhee Kim on 2015/05/28.
//  Copyright (c) 2015年 Changhee Kim, All rights reserved.
//

#import "S0ML.h"

@implementation S0ML

+(S0MLData *)parseString:(NSString*)string{
	NSString *processedString = [S0ML processedStringWithString:string];
	S0MLData *data = [S0ML parseProcessedString:processedString];
	
	return data;
}

+(S0MLData *)parseBundleFileNamed:(NSString *)fileName{
	NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:@"s0ml"];
	NSString *content = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
	
	//NSLog(@"\ncontent:\n%@", content);
	
	NSString *processedString = [S0ML processedStringWithString:content];
	
	//NSLog(@"\nprocessedString:\n%@",processedString);
	
	S0MLData *data = [S0ML parseProcessedString:processedString];
	
	return data;
}

+(S0MLData*)parseFileWithURL:(NSString*)urlString{
	NSURL *url = [NSURL URLWithString:urlString];
	NSString *content = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
	
	if(!content){
		NSLog(@"S0ML ERROR: could not find requested URL: %@", urlString);
		NSLog(@"S0MLエラー: 要請のURLに接近できません。要請のURL: %@",urlString);
		return nil;
	}
	
	//NSLog(@"content: %@", content);
	
	NSString *processedString = [S0ML processedStringWithString:content];
	
	//NSLog(@"\nprocessedString:\n%@",processedString);
	
	S0MLData *data = [S0ML parseProcessedString:processedString];
	
	return data;
}

+(void)logContentsOfS0MLData:(S0MLData*)data{
	S0MLHeader *header = data.header;
	
	NSLog(@"//S0ML Contents Log:");
	NSLog(@"Header>");
	
	for(int i = 0 ; i < [header.elementNames count] ; i++){
		NSLog(@"%@", [header.elementNames objectAtIndex:i]);
	}
	
	for(int i = 0 ; i < [data.objects count] ; i++){
		NSLog(@"Object %d>", i);
		S0MLObject *object = [data.objects objectAtIndex:i];
		for(NSString *string in object.elements){
			NSLog(@"%@", string);
		}
	}
	NSLog(@"//End");
}


+(NSString*)processedStringWithString:(NSString*)string{
	
	// Remove spaces, returns, tabs, comments:
	NSMutableString *processedString = [NSMutableString stringWithCapacity:[string length]];
	BOOL isString = NO;
	
	for(int i = 0; i < [string length]; i++){
		
		NSString *currentCharacter = [string substringWithRange:NSMakeRange(i, 1)];
		
		// フラッグの場合、フラッグ名前を取り消す：
		if([currentCharacter isEqualToString:@">"]){
			
			for(int j = 0 ; j < [processedString length] ; j++){
				
				if([[processedString substringWithRange:NSMakeRange([processedString length]-1-j, 1)] isEqualToString:@";"]){
					[processedString setString:[processedString substringToIndex:[processedString length]-j]];
					break;
				}
				
				if(j == [processedString length]-1){
					[processedString setString:[processedString substringToIndex:[processedString length]-1-j]];
				}
			}
			
		}
		
		// if it is comment, pass the line:
		if([currentCharacter isEqualToString:@"/"]){
			if(isString){
				[processedString appendString:currentCharacter];
				continue;
			}else{
				if([string substringWithRange:NSMakeRange(i, 2)]){
					
					for(int j = 2; j < [string length]-i; j++){
						currentCharacter = [string substringWithRange:NSMakeRange(i+j, 1)];
						if([currentCharacter isEqualToString:@"\n"] || [currentCharacter isEqualToString:@"\r"]){
							i +=j;
							break;
						}
					}
				}
			}
		}else{
			// 属性がstringであるのかを判断：
			if([currentCharacter isEqualToString:@"\""]){
				
				// 「\"」の場合、無視して「"」を出力：
				if([[processedString substringWithRange:NSMakeRange([processedString length]-1,1)] isEqualToString:@"\\"]){
					
					[processedString deleteCharactersInRange:NSMakeRange([processedString length]-1,1)];
					
				}else{
					if(!isString){
						isString = YES;
					}else{
						// ending point of string:
						isString = NO;
					}
					continue;
				}
			}
			
			// スペース、タッブ、リターン文字であると：
			if([currentCharacter isEqualToString:@" "]
			   || [currentCharacter isEqualToString:@"\n"]
			   || [currentCharacter isEqualToString:@"\r"]
			   || [currentCharacter isEqualToString:@"\t"]){
				
				// isStringが「YES」である場合、スペース、タッブ、リターンの処理：
				if(isString){
					[processedString appendFormat:@"%@",currentCharacter];
				}
			}else{
				[processedString appendFormat:@"%@",currentCharacter];
			}
		}
	}
		
	return processedString;
}
	
+(S0MLData*)parseProcessedString:(NSString*)string{
	
	S0MLData *data = [[S0MLData alloc] init];
	
	NSMutableString *savedString = [[NSMutableString alloc] initWithCapacity:100];
	
	// Headerを読み、S0MLHeaderに保存：
	for(int i = 0 ; i < [string length] ; i++){
		NSString *currentCharacter = [string substringWithRange:NSMakeRange(i, 1)];
		
		//
		if([currentCharacter isEqualToString:@">"]){
			if(data.header == nil){
				data.header = [[S0MLHeader alloc] init];
			}else{
				S0MLObject *object = [[S0MLObject alloc] init];
				[data.objects addObject:object];
				
				[object setHeader:data.header];
			}
		}
		
		//
		else if(data.header && [data.objects count] == 0){

			if([currentCharacter isEqualToString:@";"]){
				[data.header.elementNames addObject:[NSString stringWithString:savedString]];
				[savedString setString:@""];
			}else{
				[savedString appendString:currentCharacter];
			}
			
		}else{
			if([currentCharacter isEqualToString:@";"]){
				
				S0MLObject *object = [data.objects lastObject];
				
				if([savedString isEqualToString:@"nil"] || [savedString isEqualToString:@"null"] || [savedString isEqualToString:@""]){
					[object.elements addObject:S0Nil];
				}else{
					[object.elements addObject:[NSString stringWithString:savedString]];
				}
				
				[savedString setString:@""];
				
			}else{
				[savedString appendString:currentCharacter];
			}
		}
	}
	
	return data;
}

+(id)nilElement{
	static NSObject *nilElement;
	
	if(!nilElement){
		nilElement = [NSNull null];
	}
	
	return nilElement;
}

+(NSNumber*)numberElementWithNumber:(NSNumber*)number{
	NSNumber *numberElement = number;
	return numberElement;
}

+(NSNumber*)boolElementWithBool:(BOOL)boolen{
	return [NSNumber numberWithBool:boolen];
}

@end