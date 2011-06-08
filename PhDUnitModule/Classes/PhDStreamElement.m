//
//  PhDStreamElement.m
//  PhDUnitModule
//
//  Created by 杨 成 on 11-6-8.
//  Copyright 2011 None. All rights reserved.
//

#import "PhDStreamElement.h"


@implementation PhDStreamElement

@end

@implementation PhDStreamInfo
@synthesize totalKB, UserID, TransactionID, PageID, srcW, srcH, pageURL, title;

- (NSString *)description
{
	return [NSString stringWithFormat:@"StreamInfo\ntotalKB:%d,\nUserID:%@,\nTransactionID:%@,\nPageID:%@,\nsrcW:%d,\nsrcH:%d,\npageURL:%@,\ntitle:%@.\n", 
			totalKB, UserID, TransactionID, PageID, srcW, srcH, pageURL, title];
}

- (void)dealloc {
    [UserID release];
    [TransactionID release];
    [PageID release];
    [pageURL release];
    [title release];
	
    [super dealloc];
}
@end

@implementation PhDStreamBg
@synthesize bgx, bgy, bgw, bgh, color;

- (NSString *)description
{
	return [NSString stringWithFormat:@"StreamBg\nbgx:%d,\nbgy:%d,\nbgw:%d,\nbgh:%d,\ncolor:%d.\n", 
			bgx, bgy, bgw, bgh, color];
}


@end