//
//  PhDinHeadStream.h
//  PhDUnitModule
//
//  Created by 杨 成 on 11-6-13.
//  Copyright 2011 None. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhDinStream.h"

@protocol PhDinHeadStreamDelegate <NSObject>
@optional
- (void)setCompressLength:(PhDInt)iCompressLength;
- (void)setContentLength:(PhDInt)iContentLength;
@end
@interface PhDinHeadStream : PhDinStream {
	id <PhDinHeadStreamDelegate> delegate;
}

@property (nonatomic, assign) id <PhDinHeadStreamDelegate> delegate;


@end
