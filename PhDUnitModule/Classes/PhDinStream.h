//
//  PhDinStream.h
//  PhDUnitModule
//
//  Created by 杨 成 on 11-6-7.
//  Copyright 2011 None. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhDtypeDef.h"

@interface PhDinStream : NSObject {
	NSData* stream;
	NSUInteger iterator;
	NSUInteger needLength;
}

@property (readonly) NSData* stream;
@property (readonly) NSUInteger needLength;

+ (NSString *)parserName;
- (void)parser:(NSData *)Data;
- (BOOL)parserInternal;

- (void) close;
- (NSUInteger) leftLength;
- (void) skip:(NSInteger)num;
- (void) revert:(NSInteger)num;

- (PhDByte) readByte;
- (PhDShort) readShort;
- (PhDInt) readLong;
- (PhDUTF *) readUTF8String;

- (PhDByte) readByteEx:(NSUInteger *)len;
- (PhDShort) readShortEx:(NSUInteger *)len;
- (PhDInt) readLongEx:(NSUInteger *)len;
- (PhDUTF *) readUTF8StringEx:(NSUInteger *)len;
@end
