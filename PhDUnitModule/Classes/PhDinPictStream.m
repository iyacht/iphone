//
//  PhDinPictStream.m
//  PhDUnitModule
//
//  Created by 杨 成 on 11-6-13.
//  Copyright 2011 None. All rights reserved.
//

#import "PhDinPictStream.h"

static NSUInteger PhDimageNumber = -1;
@implementation PhDinPictStream
- (NSUInteger) getImageNumber {
	PhDimageNumber = PhDimageNumber + 1;
	if (0xEFFFFFFF == PhDimageNumber) {
		PhDimageNumber = 0;
	}
	return PhDimageNumber;
}

- (BOOL)parserInternal {
	NSUInteger imageNumber = [self getImageNumber];
	NSString *fileName =[NSString stringWithFormat:@"%@/%08d.jpg",[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"],imageNumber];//autorelease
	[stream writeToFile:fileName atomically:NO];

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
