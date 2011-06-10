//
//  PhDSearchXmlParser.h
//  PhDUnitModule
//
//  Created by 杨 成 on 11-5-31.
//  Copyright 2011 None. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Search : NSObject
{
	NSString *name;
	NSString *display;
	NSString *index;
	NSString *icon;
	NSString *portal;
}

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *display;
@property (nonatomic, copy) NSString *index;
@property (nonatomic, copy) NSString *icon;
@property (nonatomic, copy) NSString *portal;

@end

@class PhDSearchXmlParser;
// Protocol for the parser to communicate with its delegate.
@protocol PhDSearchXmlParserDelegate <NSObject>

@optional
// Called by the parser when parsing is finished.
- (void)parserDidEndParsingData:(PhDSearchXmlParser *)parser;
// Called by the parser in the case of an error.
- (void)parser:(PhDSearchXmlParser *)parser didFailWithError:(NSError *)error;
// Called by the parser when one or more songs have been parsed. This method may be called multiple times.
- (void)parser:(PhDSearchXmlParser *)parser didParseSearchs:(NSArray *)parsedSearchs;

@end
@interface PhDSearchXmlParser : NSObject <NSXMLParserDelegate> {
    id <PhDSearchXmlParserDelegate> delegate;
    NSMutableArray *parsedSearchs;

	NSMutableString *currentString;
    Search *currentSearch;
    BOOL storingCharacters;
    NSMutableData *xmlData;
    NSUInteger countOfParsedSearchs;
}

@property (nonatomic, assign) id <PhDSearchXmlParserDelegate> delegate;
@property (nonatomic, retain) NSMutableArray *parsedSearchs;

@property (nonatomic, retain) NSMutableString *currentString;
@property (nonatomic, retain) Search *currentSearch;
@property (nonatomic, retain) NSMutableData *xmlData;

+ (NSString *)parserName;
- (void)unitTest:(NSString *)path;
- (void)parseEnded;
- (void)parsedSearch:(Search *)search;
@end
