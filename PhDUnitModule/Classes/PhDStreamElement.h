//
//  PhDStreamElement.h
//  PhDUnitModule
//
//  Created by 杨 成 on 11-6-8.
//  Copyright 2011 None. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PhDinStream.h"

@interface PhDStreamElement : NSObject {

}

@end

@interface PhDStreamInfo : NSObject {
    PhDInt totalKB;
	PhDUTF* UserID;
	PhDUTF* TransactionID;
	PhDUTF* PageID;
	PhDInt srcW;
	PhDInt srcH;
	PhDUTF* pageURL;
	PhDUTF* title;
}

@property (nonatomic, assign) PhDInt totalKB;
@property (nonatomic, retain) PhDUTF* UserID;
@property (nonatomic, retain) PhDUTF* TransactionID;
@property (nonatomic, retain) PhDUTF* PageID;
@property (nonatomic, assign) PhDInt srcW;
@property (nonatomic, assign) PhDInt srcH;
@property (nonatomic, retain) PhDUTF* pageURL;
@property (nonatomic, retain) PhDUTF* title;

@end

@interface PhDStreamBg : NSObject {
    PhDShort bgx;
	PhDInt bgy;
	PhDShort bgw;
	PhDInt bgh;
	PhDInt color;
}

@property (nonatomic, assign) PhDShort bgx;
@property (nonatomic, assign) PhDInt bgy;
@property (nonatomic, assign) PhDShort bgw;
@property (nonatomic, assign) PhDInt bgh;
@property (nonatomic, assign) PhDInt color;

@end
