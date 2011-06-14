//
//  PhDinAllStream.h
//  PhDUnitModule
//
//  Created by 杨 成 on 11-6-10.
//  Copyright 2011 None. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhDinStream.h"
#import "PhDinInitStream.h"
#import "PhDinHeadStream.h"
#import "PhDinFlagStream.h"
#import "PhDinXmlStream.h"
#import "PhDinPHeadStream.h"
#import "PhDinPInfoStream.h"
#import "PhDinPictStream.h"

typedef enum
{
	PhDiASInit,
	PhDiASHead,
	PhDiASFlag,
	PhDiASSize,
	PhDiASUi,
	PhDiASXml,
	PhDiASPHead,
	PhDiASPInfo,
	PhDiASPict,
	PhDiASEnd
} PhDiASStatus;

@interface PhDinAllStream : PhDinStream
	< PhDinInitStreamDelegate, 
	PhDinHeadStreamDelegate, 
	PhDinFlagStreamDelegate,
	PhDinPHeadStreamDelegate,
	PhDinPInfoStreamDelegate > {
	PhDiASStatus phDiASStatus;
	NSMutableData *cacheData;
	
	PhDInt totalKB;
	PhDInt headKB;
		
	PhDInt compressLength;
	PhDInt contentLength;
		
	PhDByte flag;
	PhDInt totalData;
		
	PhDInt tmpImageLength;
}

- (void)unitTest:(NSString *)path;
- (id)initWithiASStatus:(PhDiASStatus)iASStatus initWithNeedLenth:(NSUInteger)iNeedLength;

- (NSData *)compress:(NSData *)Data;
- (NSData *)decompress:(NSData *)Data;
@end
