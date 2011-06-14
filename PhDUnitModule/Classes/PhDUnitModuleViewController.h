//
//  PhDUnitModuleViewController.h
//  PhDUnitModule
//
//  Created by 杨 成 on 11-5-30.
//  Copyright 2011 None. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PhDSearchXmlParser.h"
@interface PhDUnitModuleViewController : UIViewController <PhDSearchXmlParserDelegate> {
	UILabel *titleLabel;
	UISlider *unitSlider;
	UISwitch *clearTextSwitch;
	UIButton *unitTestButton;
	UITextView *logTextView;
}

@property (nonatomic, retain) IBOutlet UILabel *titleLabel;
@property (nonatomic, retain) IBOutlet UISlider *unitSlider;
@property (nonatomic, retain) IBOutlet UISwitch *clearTextSwitch;
@property (nonatomic, retain) IBOutlet UIButton *unitTestButton;
@property (nonatomic, retain) IBOutlet UITextView *logTextView;

- (IBAction)doUnitTestButton:(id)sender;
- (IBAction)doExitAppButton:(id)sender; 
- (IBAction)sliderChanged:(id)sender;
@end

