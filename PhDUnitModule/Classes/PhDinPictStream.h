//
//  PhDinPictStream.h
//  PhDUnitModule
//
//  Created by 杨 成 on 11-6-13.
//  Copyright 2011 None. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhDinStream.h"

@interface PhDinPictStream : PhDinStream {
	NSUInteger totalData;
}
- (void)setTotalData:(PhDInt)iTotalData;
@end
