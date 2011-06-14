//
//  PhDinStream.m
//  PhDUnitModule
//
//  Created by 杨 成 on 11-6-7.
//  Copyright 2011 None. All rights reserved.
//

#import "PhDinStream.h"

@implementation PhDinStream

@synthesize stream;
@synthesize needLength;

+ (NSString *)parserName {
	return @"Base Class";
}

- (void)parser:(NSData *)Data {
	if (stream != Data)
	{
		if (nil != stream) {
			[stream release];
		}
		stream = [Data retain];
	}
	
	iterator = 0;
}

- (BOOL)parserInternal {
	return YES;
}

- (void) close {
	if (nil != stream)
	{
		[stream release];
	}
	
	iterator = 0;
}

- (NSUInteger) leftLength {
	return [stream length] - iterator;
}

- (void) skip:(NSInteger)num {
	iterator = iterator + num;
}

- (void) revert:(NSInteger)num {
	iterator = iterator - num;
}

- (PhDByte) readByte {
	PhDByte* buffer = (PhDByte*)[stream bytes];
	
	PhDByte res = buffer[iterator];
	iterator++;
	
	return res;
}

- (PhDShort) readShort {
	short res = 0;
	PhDByte* p = (PhDByte*)&res;
	
	PhDByte* buffer = (PhDByte*)[stream bytes];
	
	p[1] = buffer[iterator];
	iterator++;
	p[0] = buffer[iterator];
	
	iterator++;
	
	return res;
}

- (PhDInt) readLong {
	NSInteger res = 0;
	PhDByte* p = (PhDByte*)&res;
	
	PhDByte* buffer = (PhDByte*)[stream bytes];
	
	p[3] = buffer[iterator];
	iterator++;
	p[2] = buffer[iterator];
	iterator++;
	p[1] = buffer[iterator];
	iterator++;
	p[0] = buffer[iterator];
	iterator++;
	
	return res;
}

- (PhDUTF *) readUTF8String {
	PhDShort size = [self readShort];
	
	if (size != 0) {
		PhDByte* buffer = (PhDByte*)[stream bytes];
		
		char* aux = (char*)malloc( (size*sizeof(char))+1 );
		
		for (NSUInteger k = 0; k < size; k++) {
			aux[k] = (char)buffer[iterator];
			iterator++;
		}
		
		aux[size] = '\0';
		
		NSString* res = [NSString stringWithUTF8String:aux];
		
		free(aux);
		
		return res;
	} else {
		return nil;
	}
	
}

- (PhDByte) readByteEx:(NSUInteger *)len {
	*len = *len - 1;
	
	return [self readByte];
}

- (PhDShort) readShortEx:(NSUInteger *)len {
	*len = *len - 2;
	
	return [self readShort];
}

- (PhDInt) readLongEx:(NSUInteger *)len {
	*len = *len - 4;
	
	return [self readLong];
}

- (PhDUTF *) readUTF8StringEx:(NSUInteger *)len {
	*len = *len - 2;
	PhDShort size = [self readShort];
	
	if (size != 0) {
		*len = *len - size;
		PhDByte* buffer = (PhDByte*)[stream bytes];
		
		char* aux = (char*)malloc( (size*sizeof(char))+1 );
		
		for (NSUInteger k = 0; k < size; k++) {
			aux[k] = (char)buffer[iterator];
			iterator++;
		}
		
		aux[size] = '\0';
		
		NSString* res = [NSString stringWithUTF8String:aux];
		
		free(aux);
		
		return res;
	} else {
		return nil;
	}
}

- (void)dealloc {
	[super dealloc];
}
@end
