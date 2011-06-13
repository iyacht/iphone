//
//  PhDinInitStream.m
//  PhDUnitModule
//
//  Created by 杨 成 on 11-6-13.
//  Copyright 2011 None. All rights reserved.
//

#import "PhDinInitStream.h"


@implementation PhDinInitStream

@synthesize delegate;

- (BOOL)parserInternal {
	PhDShort flag = [self readShort];
	PhDInt TotalKB = [self readLong];
	PhDInt HeadKB = [self readLong];
	if (flag != 0x232A)
		return NO;
	[delegate setTotalKB:TotalKB];
	[delegate setHeadKB:HeadKB];
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
