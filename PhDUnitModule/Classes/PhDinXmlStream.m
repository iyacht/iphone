//
//  PhDinXmlStream.m
//  PhDUnitModule
//
//  Created by 杨 成 on 11-6-7.
//  Copyright 2011 None. All rights reserved.
//

#import "PhDinXmlStream.h"
#import "PhDStreamElement.h"

@implementation PhDinXmlStream

+ (NSString *)parserName {
    return @"PhDinXmlStream";
}

- (void)unitTest:(NSString *)path {
    NSMutableData *xmlData = [NSMutableData dataWithContentsOfFile:path];  
    if (nil != xmlData) { 
		[self parser:xmlData];
    }
	
	[xmlData release];
}

#define TAG_PAGE 16
#define TAG_BGCOLOR 68
#define TAG_SELECT 67
#define TAG_INPUT 66
#define TAG_LABEL 64
#define TAG_LINKURL 65
#define TAG_URLMAP 101
#define TAG_IMAGECONTENT 69
#define TAG_IMAGEURL 70
#define TAG_URL_SINGLE_MAP 32

#define TAG_BLOCK_BEGIN 17
#define TAG_ANCHOR 71
#define TAG_PAGE_ICO 72
#define TAB_SELECT_ACT 73
#define TAG_BLOCK_END 98

typedef PhDByte PhDTag;
- (BOOL)parserInternal {
	PhDTag iTag = 0;
	NSUInteger seg = 0;
	while (1)
	{
		if ([self leftLength] < 5)
		{
			if (0 == [self leftLength])
				return YES;
			return NO;
		}
		
		iTag = [self readByte];
		if (iTag < 100)
		{
			seg  = [self readShort];
			if ([self leftLength] < seg)
			{
				return NO;
			}
		}
		else
		{
			seg  = [self readLong];
			if ([self leftLength] < seg)
			{
				return NO;
			}
		}
		
		switch (iTag)
		{
			case TAG_PAGE:
				NSLog(@"%@",@"TAG_PAGE");
				[self addInfo:seg];
				break;
			case TAG_BGCOLOR:
				NSLog(@"%@",@"TAG_BGCOLOR");
				[self addBg:seg];
				break;
			case TAG_LABEL:
				NSLog(@"%@",@"TAG_LABEL");
				[self addKown:seg];
				break;
			case TAG_LINKURL:
				NSLog(@"%@",@"TAG_LINKURL");
				[self addKown:seg];
				break;
			case TAG_IMAGECONTENT:
				NSLog(@"%@",@"TAG_IMAGECONTENT");
				[self addKown:seg];
				break;
			case TAG_IMAGEURL:
				NSLog(@"%@",@"TAG_IMAGEURL");
				[self addKown:seg];
				break;
			case TAG_INPUT:
				NSLog(@"%@",@"TAG_INPUT");
				[self addKown:seg];
				break;
			case TAG_SELECT:
				NSLog(@"%@",@"TAG_SELECT");
				[self addKown:seg];
				break;
			case TAB_SELECT_ACT:
				NSLog(@"%@",@"TAB_SELECT_ACT");
				[self addKown:seg];
				break;
			case TAG_URL_SINGLE_MAP:
				NSLog(@"%@",@"TAG_URL_SINGLE_MAP");
				[self addKown:seg];
				break;
			case TAG_ANCHOR:
				NSLog(@"%@",@"TAG_ANCHOR");
				[self addKown:seg];
				break;
			case TAG_PAGE_ICO:
				NSLog(@"%@",@"TAG_PAGE_ICO");
				[self addKown:seg];
				break;
			case TAG_BLOCK_BEGIN:
				NSLog(@"%@",@"TAG_BLOCK_BEGIN");
				[self addKown:seg];
				break;
			case TAG_BLOCK_END:
				NSLog(@"%@",@"TAG_BLOCK_BEGIN");
				[self addKown:seg];
				break;
			case TAG_URLMAP:
				NSLog(@"%@",@"TAG_URLMAP");
				[self addLongKown:seg];
				break;
			case 255:
			case 0:
				return NO;
			default:
				if (iTag < 100)
					[self addUnkown:seg];
				else
					[self addLongUnkown:seg];
				break;
		}
	};
	return NO;
}

#define U16_SEGBEGIN NSUInteger segmentsize = seg;\
NSUInteger length = segmentsize
#define U16_SEGEND 	if (length)\
[self skip:length]
#define U32_SEGBEGIN NSUInteger segmentsize = seg;\
NSUInteger length = segmentsize
#define U32_SEGEND 	if (length)\
[self skip:length]

- (void)addKown:(NSUInteger)seg {
	U16_SEGBEGIN;
	U16_SEGEND;
}

- (void)addLongKown:(NSUInteger)seg {
	U32_SEGBEGIN;
	U32_SEGEND;
}


- (void)addUnkown:(NSUInteger)seg {
	U16_SEGBEGIN;
	U16_SEGEND;
}
 
- (void)addLongUnkown:(NSUInteger)seg{
	U32_SEGBEGIN;
	U32_SEGEND;
}

- (void)addInfo:(NSUInteger)seg {
	PhDStreamInfo* phDStreamInfo = [[PhDStreamInfo alloc]init];
	if (phDStreamInfo == nil) {
		//fail
	}
	U16_SEGBEGIN;
	phDStreamInfo.totalKB = [self readLongEx:&length];
	phDStreamInfo.UserID = [self readUTF8StringEx:&length];
	phDStreamInfo.TransactionID = [self readUTF8StringEx:&length];
	phDStreamInfo.PageID = [self readUTF8StringEx:&length];
	phDStreamInfo.srcW = [self readLongEx:&length];
	phDStreamInfo.srcH = [self readLongEx:&length];
	phDStreamInfo.pageURL = [self readUTF8StringEx:&length];
	phDStreamInfo.title = [self readUTF8StringEx:&length];
	U16_SEGEND;
	
	NSLog(@"%@",phDStreamInfo);
	[phDStreamInfo release];
}

- (void)addBg:(NSUInteger)seg {
	PhDStreamBg* phDStreamBg = [[PhDStreamBg alloc]init];
	if (phDStreamBg == nil) {
		//fail
	}
	U16_SEGBEGIN;
	phDStreamBg.bgx = [self readShortEx:&length];
	phDStreamBg.bgy = [self readLongEx:&length];
	phDStreamBg.bgw = [self readShortEx:&length];
	phDStreamBg.bgh = [self readLongEx:&length];
	phDStreamBg.color = [self readLongEx:&length];
	U16_SEGEND;
	
	NSLog(@"%@",phDStreamBg);
	[phDStreamBg release];
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
