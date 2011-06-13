//
//  PhDinHeadStream.m
//  PhDUnitModule
//
//  Created by 杨 成 on 11-6-13.
//  Copyright 2011 None. All rights reserved.
//

#import "PhDinHeadStream.h"

@implementation PhDinHeadStream

@synthesize delegate;

- (BOOL)parserInternal {
	PhDInt CompressLength = 4899;
	PhDInt ContentLength = 28927;
	[delegate setCompressLength:CompressLength];
	[delegate setContentLength:ContentLength];
	return YES;
}

- (void)parser:(NSData *)Data {
	[super parser:Data];
	BOOL res = [self parserInternal];
	if (NO == res) {
		NSLog(@"Left:%d",[self leftLength]);
	}
	[self close];
}

- (void)dealloc {
	[super dealloc];
}
@end
