//
//  PhDMasterXmlParser.h
//  PhDUnitModule
//
//  Created by 杨 成 on 11-6-1.
//  Copyright 2011 None. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PhDMasterXmlParser : NSObject <NSXMLParserDelegate> {
	NSMutableString *currentString;
    BOOL storingCharacters;
    NSMutableData *xmlData;
    NSMutableString *htmlData;
	BOOL findMatchSection;
	
	NSArray *masterArray;
	NSUInteger currentMaster;
}

@property (nonatomic, assign) NSUInteger currentMaster;

+ (NSString *)parserName;
- (void)unitTest:(NSString *)path;
@end
