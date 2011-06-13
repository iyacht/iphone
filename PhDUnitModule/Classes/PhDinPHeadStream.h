//
//  PhDinPHeadStream.h
//  PhDUnitModule
//
//  Created by 杨 成 on 11-6-13.
//  Copyright 2011 None. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhDinStream.h"

@protocol PhDinPHeadStreamDelegate <NSObject>
@optional
- (void)setTotalData:(PhDInt)iTotalData;
@end
@interface PhDinPHeadStream : PhDinStream {
	id <PhDinPHeadStreamDelegate> delegate;
}

@property (nonatomic, assign) id <PhDinPHeadStreamDelegate> delegate;

@end
