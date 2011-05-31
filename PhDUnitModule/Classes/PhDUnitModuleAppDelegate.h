//
//  PhDUnitModuleAppDelegate.h
//  PhDUnitModule
//
//  Created by 杨 成 on 11-5-30.
//  Copyright 2011 None. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PhDUnitModuleViewController;

@interface PhDUnitModuleAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    PhDUnitModuleViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet PhDUnitModuleViewController *viewController;

@end

