//
//  PhDinPInfoStream.h
//  PhDUnitModule
//
//  Created by 杨 成 on 11-6-14.
//  Copyright 2011 None. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhDinStream.h"
	
@protocol PhDinPInfoStreamDelegate <NSObject>
@optional
- (void)setImageLength:(PhDInt)iImageLength;
@end
@interface PhDinPInfoStream : PhDinStream {
	id <PhDinPInfoStreamDelegate> delegate;
}

@property (nonatomic, assign) id <PhDinPInfoStreamDelegate> delegate;

@end
