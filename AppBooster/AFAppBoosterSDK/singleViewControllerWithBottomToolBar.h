//
//  singleViewControllerWithBottomToolBar.h
//  AFAppBoosterSDK
//
//  Created by Nicolas Jouannem on 6/3/11.
//  Copyright 2011 APPSFIRE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface singleViewControllerWithBottomToolBar : UIViewController {
    UIToolbar *toolbar;
}

@property (nonatomic, retain) UIToolbar *toolbar;

- (void)appboosterIsInitialized;

@end
