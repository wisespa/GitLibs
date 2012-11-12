//
//  AFAppBoosterSDKAppDelegate.h
//  AFAppBoosterSDK
//
//  Created by Nicolas Jouannem on 4/21/11.
//  Copyright 2011 APPSFIRE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AFAppBoosterSDKAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    UITabBarController  *tabController;
    UIViewController    *viewController;
    UIViewController    *toolbarController;
    UIToolbar *toolbar;
}


@property (nonatomic, retain) IBOutlet UIToolbar *toolbar;

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UITabBarController *tabController;

@property (nonatomic, retain) IBOutlet UIViewController *viewController;

@property (nonatomic, retain) IBOutlet UIViewController *toolbarController;

- (IBAction)forceOpenNotificationWindow;
- (IBAction)forceOpenFeedbackWindow;

@end
