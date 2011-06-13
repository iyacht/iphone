//
//  PhDinInitStream.h
//  PhDUnitModule
//
//  Created by 杨 成 on 11-6-13.
//  Copyright 2011 None. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhDinStream.h"

@protocol PhDinInitStreamDelegate <NSObject>
@optional
- (void)setTotalKB:(PhDInt)iTotalKB;
- (void)setHeadKB:(PhDInt)iHeadKB;
@end

@interface PhDinInitStream : PhDinStream {
	id <PhDinInitStreamDelegate> delegate;
}

@property (nonatomic, assign) id <PhDinInitStreamDelegate> delegate;

@end
