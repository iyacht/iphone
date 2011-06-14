//
//  PhDinAllStream.m
//  PhDUnitModule
//
//  Created by 杨 成 on 11-6-10.
//  Copyright 2011 None. All rights reserved.
//

#import "PhDinAllStream.h"
#include <zlib.h>

@implementation PhDinAllStream

+ (NSString *)parserName {
    return @"PhDinAllStream";
}

- (void)unitTest:(NSString *)path {
    NSMutableData *xmlData = [NSMutableData dataWithContentsOfFile:path];  
    if (nil != xmlData) { 
		[self initWithiASStatus:PhDiASInit initWithNeedLenth:10];
		[self parser:xmlData];
    }
}

- (id)initWithiASStatus:(PhDiASStatus)iASStatus initWithNeedLenth:(NSUInteger)iNeedLength {
	self = [super init];
	if(self) {
		phDiASStatus = iASStatus;
		needLength = iNeedLength;
		cacheData = [[NSMutableData  alloc] init];
	}
	return(self);
}

- (void)setiASStatus:(PhDiASStatus)iASStatus setNeedLenth:(NSUInteger)iNeedLength {
	phDiASStatus = iASStatus;
	needLength = iNeedLength;
	[cacheData setLength:0];
}

#define TAG_IMAGE 100
- (BOOL)parserInternal {
	if (PhDiASInit == phDiASStatus) {
		PhDinInitStream *phDinInitStream = [[PhDinInitStream alloc] init];
		phDinInitStream.delegate = self;
		[phDinInitStream parser:cacheData];
		[phDinInitStream release];
		[self setiASStatus:PhDiASHead setNeedLenth:headKB];

		return YES;
	} else if (PhDiASHead == phDiASStatus) {
		PhDinHeadStream *phDinHeadStream = [[PhDinHeadStream alloc] init];
		phDinHeadStream.delegate = self;
		if (totalKB > headKB) /*gzip*/{
			NSData *headData = [self decompress:cacheData];
			[phDinHeadStream parser:headData];
		} else {
			[phDinHeadStream parser:cacheData];
		}
		[phDinHeadStream release];
		[self setiASStatus:PhDiASFlag setNeedLenth:1];
		return YES;
	} else if (PhDiASXml == phDiASStatus) {
		PhDinXmlStream *phDinXmlStream = [[PhDinXmlStream alloc] init];
		if (contentLength > compressLength) /*gzip*/{
			NSData *xmlData = [self decompress:cacheData];
			[phDinXmlStream parser:xmlData];
		} else {
			[phDinXmlStream parser:cacheData];
		}
		[phDinXmlStream release];
		[self setiASStatus:PhDiASFlag setNeedLenth:1];
		return YES;
	} else if (PhDiASPHead == phDiASStatus) {
		PhDinPHeadStream *phDinPHeadStream = [[PhDinPHeadStream alloc] init];
		phDinPHeadStream.delegate = self;
		[phDinPHeadStream parser:cacheData];
		[phDinPHeadStream release];
		[self setiASStatus:PhDiASPInfo setNeedLenth:9];
		return YES;
	} else if (PhDiASPInfo == phDiASStatus) {
		PhDinPInfoStream *phDinPInfoStream = [[PhDinPInfoStream alloc] init];
		phDinPInfoStream.delegate = self;
		[phDinPInfoStream parser:cacheData];
		[phDinPInfoStream release];
		[self setiASStatus:PhDiASPict setNeedLenth:tmpImageLength];
		return YES;
	} else if (PhDiASPict == phDiASStatus) {
		PhDinPictStream *phDinPictStream = [[PhDinPictStream alloc] init];
		[phDinPictStream parser:cacheData];
		totalData = totalData - 9 - tmpImageLength;
		NSLog(@"totalData:\t%d",totalData);
		[phDinPictStream release];
		if (totalData) {
			[self setiASStatus:PhDiASPInfo setNeedLenth:9];
		} else {
			[self setiASStatus:PhDiASEnd setNeedLenth:0];
		}	
		return YES;
	} else if (PhDiASFlag == phDiASStatus) {
		PhDinFlagStream *phDinFlagStream = [[PhDinFlagStream alloc] init];
		phDinFlagStream.delegate = self;
		[phDinFlagStream parser:cacheData];
		[phDinFlagStream release];
		if (flag == 12)//ui
		{
			;
		}
		else if (flag == 13)//channel
		{
			;
		}
		else if (flag == 14)//search
		{
			;
		}
		else if(flag == 15)//update version
		{
			;
		}
		else if (flag == 0x00)//phd xml
		{
			[self setiASStatus:PhDiASXml setNeedLenth:compressLength];
		}
		else if (flag == TAG_IMAGE)//picture
		{
			[self setiASStatus:PhDiASPHead setNeedLenth:4];
		}
		else
		{
			;
		}
		
		return YES;
	}
	
	return NO;
}

- (void)PrintStatus: (NSUInteger)iPhDiASStatus {
	switch (iPhDiASStatus) {
		case PhDiASInit:
			NSLog(@"%@",@"PhDiASInit");
			break;
		case PhDiASHead:
			NSLog(@"%@",@"PhDiASHead");
			break;
		case PhDiASFlag:
			NSLog(@"%@",@"PhDiASFlag");
			break;
		case PhDiASSize:
			NSLog(@"%@",@"PhDiASSize");
			break;
		case PhDiASUi:
			NSLog(@"%@",@"PhDiASUi");
			break;
		case PhDiASXml:
			NSLog(@"%@",@"PhDiASXml");
			break;
		case PhDiASPHead:
			NSLog(@"%@",@"PhDiASPHead");
			break;
		case PhDiASPInfo:
			NSLog(@"%@",@"PhDiASPInfo");
			break;
		case PhDiASPict:
			NSLog(@"%@",@"PhDiASPict");
			break;
		case PhDiASEnd:
			NSLog(@"%@",@"PhDiASEnd");
			break;
		default:
			break;
	}
	
}

- (void)parser:(NSData *)Data {
	NSUInteger start = 0;
	BOOL res = YES;
	while (res) {
		while (PhDiASEnd == phDiASStatus)
			return;
		[self PrintStatus:phDiASStatus];
		while (PhDiASEnd != phDiASStatus) {
			if (Data.length >= [self needLength]) {
				[cacheData appendData:[Data subdataWithRange:NSMakeRange(start, [self needLength])]];
				start = start + [self needLength];
				break;
			} else {
				[cacheData appendData:[Data subdataWithRange:NSMakeRange(start, Data.length - start)]];
				return;
			}
		}
		
		while (PhDiASEnd != phDiASStatus) {	
			res = [self parserInternal];
			if (NO == res) {
				NSLog(@"Left:%d",[self leftLength]);
				return;
			} else {
				break;
			}
		}
	}
}

- (void)dealloc {
	[super dealloc];
}

#pragma mark PhDinInitStreamDelegate
- (void)setTotalKB:(PhDInt)iTotalKB {
	totalKB = iTotalKB;
}

- (void)setHeadKB:(PhDInt)iHeadKB {
	headKB = iHeadKB;
}

#pragma mark PhDinHeadStreamDelegate
- (void)setCompressLength:(PhDInt)iCompressLength {
	compressLength = iCompressLength;
}

- (void)setContentLength:(PhDInt)iContentLength {
	contentLength = iContentLength;
}

#pragma mark PhDinFlagStreamDelegate
- (void)setFlag:(PhDByte)iFlag {
	flag = iFlag;
}

#pragma mark PhDinPHeadStreamDelegate
- (void)setTotalData:(PhDInt)iTotalData {
	totalData = iTotalData;
}

#pragma mark PhDinPInfoStreamDelegate
- (void)setImageLength:(PhDInt)iImageLength {
	tmpImageLength = iImageLength;
}

#pragma mark gzip interface
- (NSData *)decompress:(NSData *)Data
{
	NSUInteger full_length = Data.length;
	NSUInteger half_length = Data.length / 2;
	
	NSMutableData *unzipData = [NSMutableData dataWithLength: full_length + half_length];
	BOOL done = NO;
	NSInteger status;
	
	z_stream zlibStream;
	zlibStream.next_in = (Bytef *)[Data bytes];
	zlibStream.avail_in = (uInt)[Data length];
	zlibStream.total_out = 0;
	zlibStream.zalloc = Z_NULL;
	zlibStream.zfree = Z_NULL;
	
	//zip
	//if(inflateInit(&zlibStream) != Z_OK) return nil;
	//gzip
	int windowBits = 15 + 16;
	if(inflateInit2(&zlibStream, windowBits) != Z_OK) return nil;
	
	while(!done)
	{
		if (zlibStream.total_out >= [unzipData length])
			[unzipData increaseLengthBy: half_length];
		zlibStream.next_out = [unzipData mutableBytes] + zlibStream.total_out;
		zlibStream.avail_out = (uInt)([unzipData length] - zlibStream.total_out);
		
		status = inflate (&zlibStream, Z_SYNC_FLUSH);
		if (status == Z_STREAM_END) done = YES;
		else if (status != Z_OK) break;
	}
	if(inflateEnd (&zlibStream) != Z_OK)
		return nil;
	
	if(done) {
		[unzipData setLength: zlibStream.total_out];
		return [NSData dataWithData: unzipData];
	}
	else
		return nil;
}


- (NSData *)compress:(NSData *)Data
{
	z_stream zlibStream;
	
	zlibStream.zalloc = Z_NULL;
	zlibStream.zfree = Z_NULL;
	zlibStream.opaque = Z_NULL;
	zlibStream.total_out = 0;
	zlibStream.next_in=(Bytef *)[Data bytes];
	zlibStream.avail_in = (uInt)[Data length];
	
	if (deflateInit(&zlibStream, Z_DEFAULT_COMPRESSION) != Z_OK) return nil;
	
	
	NSMutableData *zipData = [NSMutableData dataWithLength:16384];
	
	do{
		
		if (zlibStream.total_out >= [zipData length])
			[zipData increaseLengthBy: 16384];
		
		zlibStream.next_out = [zipData mutableBytes] + zlibStream.total_out;
		zlibStream.avail_out = (uInt)([zipData length] - zlibStream.total_out);
		
		deflate(&zlibStream, Z_FINISH);
		
	} while(zlibStream.avail_out == 0);
	
	deflateEnd(&zlibStream);
	
	[zipData setLength: zlibStream.total_out];
	return [NSData dataWithData: zipData];
}
@end
