//
//  PhDUnitModuleViewController.m
//  PhDUnitModule
//
//  Created by 杨 成 on 11-5-30.
//  Copyright 2011 None. All rights reserved.
//

#import "PhDUnitModuleViewController.h"
#import "PhDSearchXmlParser.h"

#define MINI_SLIDERVALUE 0
#define MAX_SLIDERVALUE 5
#define CUR_SLIDERVALUE 1

@implementation PhDUnitModuleViewController

//@synthesize
@synthesize titleLabel;
@synthesize unitSlider;
@synthesize clearTextSwitch;
@synthesize unitTestButton;
@synthesize logTextView;

@synthesize searchs;

- (IBAction) doUnitTestButton:(id)sender {
	if (clearTextSwitch.on == YES) {
		logTextView.text = nil;
		[logTextView setText:@"测试输出:"];
	}
	else {
		[logTextView setText:@"添加输出:"];
	}
	
	[unitTestButton setTitle:@"停止测试" forState:UIControlStateNormal];
	
	// Allocate the array for song storage, or empty the results of previous parses
    if (searchs == nil) {
        self.searchs = [NSMutableArray array];
    } else {
        [searchs removeAllObjects];
    }
	phDSearchXmlParser = [[PhDSearchXmlParser alloc] init];
	phDSearchXmlParser.delegate = self;
	
	[logTextView setText:[PhDSearchXmlParser parserName]];
	
	[phDSearchXmlParser openAndParse:@"haha"];
	
}

- (IBAction)doExitAppButton:(id)sender {
	exit(0);
	//no use @"被appstore拒"
	//[[UIApplication sharedApplication] respondsToSelector:@selector(terminate)];
}

- (IBAction)sliderChanged:(id)sender {
	UISlider *slider=(UISlider *)sender;
	int progressAsInt=(int)slider.value;
	NSString *newText=[[NSString alloc] initWithFormat:@"PhD选择测试用例：%d",progressAsInt];
	titleLabel.text=newText;
	[newText release];
	
}
#pragma mark <PhDSearchXmlParser> Implementation

- (void)parserDidEndParsingData:(PhDSearchXmlParser *)parser {
	logTextView.text = [NSString stringWithFormat:@"%@ %@", logTextView.text, @"结束测试" ];
	[unitTestButton setTitle:@"开始测试" forState:UIControlStateNormal];
}

- (void)parser:(PhDSearchXmlParser *)parser didParseSearchs:(NSArray *)parsedSearchs {
    [searchs addObjectsFromArray:parsedSearchs];
    NSLog(@"nil response");
	logTextView.text = [NSString stringWithFormat:@"%@ %d", logTextView.text, searchs.count ]; 
}

- (void)parser:(PhDSearchXmlParser *)parser didFailWithError:(NSError *)error {
    // handle errors as appropriate to your application...
}
/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


//*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	titleLabel.textAlignment = UITextAlignmentCenter;
	titleLabel.font = [UIFont fontWithName:@"Verdana" size:20];
	NSString *newText=[[NSString alloc] initWithFormat:@"PhD选择测试用例：%d",CUR_SLIDERVALUE];
	titleLabel.text=newText;
	[newText release];
	
	unitSlider.minimumValue = MINI_SLIDERVALUE;
	unitSlider.maximumValue = MAX_SLIDERVALUE;
	unitSlider.value = CUR_SLIDERVALUE;

	logTextView.editable = NO;
	
    [super viewDidLoad];
}
//*/


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[titleLabel release];
	[unitSlider release];
	[clearTextSwitch release];
	[unitTestButton release];
	[logTextView release];

	[phDSearchXmlParser release];
	[searchs release];
    [super dealloc];
}

@end
