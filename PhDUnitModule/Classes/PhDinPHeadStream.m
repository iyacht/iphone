//
//  PhDinPHeadStream.m
//  PhDUnitModule
//
//  Created by 杨 成 on 11-6-13.
//  Copyright 2011 None. All rights reserved.
//

#import "PhDinPHeadStream.h"


@implementation PhDinPHeadStream

@synthesize delegate;

- (BOOL)parserInternal {
	PhDInt totalData = [self readLong];;
	[delegate setTotalData:totalData];
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
