//
//  PhDSearchXmlParser.m
//  PhDUnitModule
//
//  Created by 杨 成 on 11-5-31.
//  Copyright 2011 None. All rights reserved.
//

#import "PhDSearchXmlParser.h"

static NSUInteger kCountForNotification = 0;

@implementation Search

@synthesize name, display, index, icon, portal;

- (NSString *)description
{
	return [NSString stringWithFormat:@"Search\nname: %@ \ndisplay: %@\nindex: %@\nicon: %@\nportal: %@", 
			name, display, index, icon, portal];
}

- (void)dealloc {
	[name release];
    [display release];
	[index release];
    [icon release];
	[portal release];
	
    [super dealloc];
}
@end

@implementation PhDSearchXmlParser

@synthesize delegate, parsedSearchs;
@synthesize currentString, currentSearch, xmlData;

+ (NSString *)parserName {
    return @"PhDSearchXmlParser";
}

- (void)unitTest:(NSString *)path {  
    xmlData = [NSMutableData dataWithContentsOfFile:path];  
    if (nil != xmlData) { 
		parsedSearchs = [[NSMutableArray alloc] init];
		NSXMLParser *parser = [[NSXMLParser alloc] initWithData:xmlData];
		parser.delegate = self;
		currentString = [NSMutableString string];
		[parser parse];
		[self parseEnded];
		[parser release]; 
    } 

    currentString = nil;
    xmlData = nil;
    currentSearch = nil;
}

- (void)dealloc {
    [super dealloc];
}

- (void)parseEnded {
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(parser:didParseSearchs:)] && [parsedSearchs count] > 0) {
        [self.delegate parser:self didParseSearchs:parsedSearchs];
    }
    [self.parsedSearchs removeAllObjects];
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(parserDidEndParsingData:)]) {
        [self.delegate parserDidEndParsingData:self];
    }
}

- (void)parsedSearch:(Search *)search {
	NSLog(@"%@",search);
    [self.parsedSearchs addObject:search];
    if (self.parsedSearchs.count > kCountForNotification) {
        if (self.delegate != nil && [self.delegate respondsToSelector:@selector(parser:didParseSearchs:)]) {
            [self.delegate parser:self didParseSearchs:parsedSearchs];
        }
        [self.parsedSearchs removeAllObjects];
    }
}

#pragma mark Parsing support methods

static const NSUInteger kAutoreleasePoolPurgeFrequency = 20;

- (void)finishedCurrentSearch {
	[self parsedSearch:currentSearch];
    self.currentSearch = nil;
    countOfParsedSearchs++;
    // Periodically purge the autorelease pool. The frequency of this action may need to be tuned according to the 
    // size of the objects being parsed. The goal is to keep the autorelease pool from growing too large, but 
    // taking this action too frequently would be wasteful and reduce performance.
    if (countOfParsedSearchs == kAutoreleasePoolPurgeFrequency) {
        countOfParsedSearchs = 0;
    }
}

#pragma mark NSXMLParser Parsing Callbacks

// Constants for the XML element names that will be considered during the parse. 
// Declaring these as static constants reduces the number of objects created during the run
// and is less prone to programmer error.
static NSString *kName_Item = @"item";
static NSString *kName_name = @"name";
static NSString *kName_display = @"display";
static NSString *kName_index = @"index";
static NSString *kName_icon = @"icon";
static NSString *kName_portal = @"portal";
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *) qualifiedName attributes:(NSDictionary *)attributeDict {
    if ([elementName isEqualToString:kName_Item]) {
        self.currentSearch = [[[Search alloc] init] autorelease];
    } else if ([elementName isEqualToString:kName_name] || 
			   [elementName isEqualToString:kName_display] || 
			   [elementName isEqualToString:kName_index] || 
			   [elementName isEqualToString:kName_icon] || 
			   [elementName isEqualToString:kName_portal]) {
        [currentString setString:@""];
        storingCharacters = YES;
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:kName_Item]) {
        [self finishedCurrentSearch];
    } else if ([elementName isEqualToString:kName_name]) {
        currentSearch.name = currentString;
    } else  if ([elementName isEqualToString:kName_display]) {
        currentSearch.display = currentString;
    } else  if ([elementName isEqualToString:kName_index]) {
        currentSearch.index = currentString;
    } else  if ([elementName isEqualToString:kName_icon]) {
        currentSearch.icon = currentString;
    } else  if ([elementName isEqualToString:kName_portal]) {
        currentSearch.portal = currentString;
    } 
    storingCharacters = NO;
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    if (storingCharacters) [currentString appendString:string];
}

/*
 A production application should include robust error handling as part of its parsing implementation.
 The specifics of how errors are handled depends on the application.
 */
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    // Handle errors as appropriate for your application.
}

@end
