//
//  singleViewController2.h
//  AFAppBoosterSDK
//
//  Created by Nick Jouannem on 10/6/11.
//  Copyright (c) 2011 Appsfire SAS. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface singleViewController : UIViewController {
    IBOutlet UIButton *forceOpenNotification;
    IBOutlet UIButton *forceOpenFeedback;
    IBOutlet UIButton *openNotificationsUIView;
    
}

- (IBAction)forceOpenNotificationWindow;
- (IBAction)forceOpenFeedbackWindow;

- (void)appboosterIsInitialized;

@end
