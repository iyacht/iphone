//
//  PhDMasterXmlParser.m
//  PhDUnitModule
//
//  Created by 杨 成 on 11-6-1.
//  Copyright 2011 None. All rights reserved.
//

#import "PhDMasterXmlParser.h"

static NSString *kName_InternetSites = @"互联网站";
static NSString *kName_MobileCoolSites = @"手机酷站";
static NSString *kName_WebSites = @"网址大全";

@implementation PhDMasterXmlParser

@synthesize currentMaster;

+ (NSString *)parserName {
    return @"PhDMasterXmlParser";
}

- (void)unitTest:(NSString *)path {
	masterArray = [[NSArray alloc] initWithObjects:kName_InternetSites,kName_MobileCoolSites,kName_WebSites,nil];
    xmlData = [NSMutableData dataWithContentsOfFile:path];  
    if (nil != xmlData) {
		htmlData = [[NSMutableString alloc] init];
		[htmlData appendFormat:
		 @"<!DOCTYPE html PUBLIC \"-//WAPFORUM//DTD XHTML Mobile 1.0//EN\" \"http://www.wapforum.org/DTD/xhtml-mobile10.dtd\"><html xmlns=\"http://www.w3.org/1999/xhtml\"><head><meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\" /><title>%@</title></head><body>",[masterArray  objectAtIndex: currentMaster]];
		findMatchSection = NO;
		NSXMLParser *parser = [[NSXMLParser alloc] initWithData:xmlData];
		parser.delegate = self;
		currentString = [NSMutableString string];
		[parser parse];
		[parser release]; 
    } 
	
	[htmlData appendString:@"</body></html>"];
	NSString *fileName =[NSString stringWithFormat:@"%@/demo-%@.html",[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"],[masterArray  objectAtIndex: currentMaster]];//autorelease
	[htmlData writeToFile:fileName atomically:NO encoding:NSUTF8StringEncoding error:nil];
	[htmlData release];
	currentString = nil;
	xmlData = nil;
}

- (void)dealloc {
    [super dealloc];
}

#pragma mark NSXMLParser Parsing Callbacks

// Constants for the XML element names that will be considered during the parse. 
// Declaring these as static constants reduces the number of objects created during the run
// and is less prone to programmer error.
static NSString *kName_Section = @"section";
static NSString *kName_a = @"a";
static NSString *kName_nbsp = @"nbsp";
static NSString *kName_br = @"br";
static NSString *kName_span = @"span";

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *) qualifiedName attributes:(NSDictionary *)attributeDict {
    if ([elementName isEqualToString:kName_Section]) {
		if ([[attributeDict objectForKey:@"name"] isEqualToString:[masterArray  objectAtIndex: currentMaster]]) {
			findMatchSection = YES;
		}
		
    } else if (findMatchSection == YES) {
		if ([elementName isEqualToString:kName_a]) {
			[htmlData appendFormat:@"<a href=\"%@\">", [attributeDict objectForKey:@"href"]];
			[currentString setString:@""];
			storingCharacters = YES;
		} else if ([elementName isEqualToString:kName_nbsp]) {
			[currentString setString:@""];
			storingCharacters = YES;
		} else if ([elementName isEqualToString:kName_br]) {
			[currentString setString:@""];
			storingCharacters = YES;
		} else if ([elementName isEqualToString:kName_span]) {
			[currentString setString:@""];
			storingCharacters = YES;
		}
    }
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	if (findMatchSection == NO) {
		return;
	}
    if ([elementName isEqualToString:kName_Section]) {
        findMatchSection = NO;
    } else if ([elementName isEqualToString:kName_a]) {
		[htmlData appendFormat:@"%@</a>",currentString];
		
    } else  if ([elementName isEqualToString:kName_nbsp]) {
        [htmlData appendString:@" "];
    } else  if ([elementName isEqualToString:kName_br]) {
		[htmlData appendString:@"</p>"];
    } else  if ([elementName isEqualToString:kName_span]) {
		[htmlData appendFormat:@"%@",currentString];
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
