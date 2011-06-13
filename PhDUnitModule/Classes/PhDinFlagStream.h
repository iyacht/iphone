//
//  PhDinFlagStream.h
//  PhDUnitModule
//
//  Created by 杨 成 on 11-6-13.
//  Copyright 2011 None. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhDinStream.h"

@protocol PhDinFlagStreamDelegate <NSObject>
@optional
- (void)setFlag:(PhDByte)iFlag;
@end
@interface PhDinFlagStream : PhDinStream {
	id <PhDinFlagStreamDelegate> delegate;
}

@property (nonatomic, assign) id <PhDinFlagStreamDelegate> delegate;

@end
