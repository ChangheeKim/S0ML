//
//  S0ML.h
//
//  Created by Changhee Kim on 2015/05/28.
//  Copyright (c) 2015年 Changhee Kim, All rights reserved.
//

#import <Foundation/Foundation.h>
#import "S0MLData.h"
#import "S0MLHeader.h"
#import "S0MLObject.h"

#define S0Nil [S0ML nilElement]

@interface S0ML : NSObject

+(S0MLData *)parseString:(NSString*)string;
+(S0MLData*)parseBundleFileNamed:(NSString*)fileName;
+(S0MLData*)parseFileWithURL:(NSString*)urlString;
+(void)logContentsOfS0MLData:(S0MLData*)data;
+(id)nilElement;

@end