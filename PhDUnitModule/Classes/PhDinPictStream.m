//
//  PhDinPictStream.m
//  PhDUnitModule
//
//  Created by 杨 成 on 11-6-13.
//  Copyright 2011 None. All rights reserved.
//

#import "PhDinPictStream.h"


@implementation PhDinPictStream

- (BOOL)parserInternal {
	while (totalData) {
		PhDInt picDataID = [self readLong];
		PhDInt OneImageLength = [self readLong];
		PhDByte reserver = [self readByte];
		//dump image
		totalData = totalData - 9 - OneImageLength;
		[self skip:OneImageLength];
		NSLog(@"picDataID:%08X\nOneImageLength:%d\nreserver:%d\n",picDataID, OneImageLength, reserver);
	}
	
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

- (void)setTotalData:(PhDInt)iTotalData {
	totalData = iTotalData;
}
@end
