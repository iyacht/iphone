//
//  PhDinPInfoStream.m
//  PhDUnitModule
//
//  Created by 杨 成 on 11-6-14.
//  Copyright 2011 None. All rights reserved.
//

#import "PhDinPInfoStream.h"


@implementation PhDinPInfoStream

@synthesize delegate;

- (BOOL)parserInternal {
	PhDInt picDataID = [self readLong];
	PhDInt OneImageLength = [self readLong];
	PhDByte reserver = [self readByte];

	NSLog(@"\npicDataID:\t0x%08X\nOneImageLength:\t%d\nreserver:\t%d\n",picDataID, OneImageLength, reserver);
	[delegate setImageLength:OneImageLength];
	
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
