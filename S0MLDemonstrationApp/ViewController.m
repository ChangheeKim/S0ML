//
//  ViewController.m
//  S0MLDemonstrationApp
//
//  Created by 金昌熙 on 2015/06/15.
//  Copyright (c) 2015年 金昌熙. All rights reserved.
//

#import "ViewController.h"
#import "S0ML.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	S0MLData *drinks = [S0ML parseBundleFileNamed:@"drinks"];
	
	[S0ML logContentsOfS0MLData:drinks];
	
	for( S0MLObject *drink in drinks.objects){
		NSLog(@"%@ is %@ color. It's%@ available in Japan.", [drink elementForName:@"name"], [drink elementForName:@"color"], [drink boolWithElementForName:@"availability"]?@"":@" not");
	}
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
