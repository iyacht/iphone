//
//  PhDinXmlStream.h
//  PhDUnitModule
//
//  Created by 杨 成 on 11-6-7.
//  Copyright 2011 None. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhDinStream.h"

@interface PhDinXmlStream : PhDinStream {
}

- (void)unitTest:(NSString *)path;

- (void)addKown:(NSUInteger)seg;
- (void)addLongKown:(NSUInteger)seg;
- (void)addUnkown:(NSUInteger)seg;
- (void)addLongUnkown:(NSUInteger)seg;

- (void)addInfo:(NSUInteger)seg;
- (void)addBg:(NSUInteger)seg;
@end
