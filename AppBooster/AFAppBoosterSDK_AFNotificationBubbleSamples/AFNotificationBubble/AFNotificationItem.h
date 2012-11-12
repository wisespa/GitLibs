//
//  AFNotificationItem.h
//  AFSample
//
//  Created by Arnaud Mesureur on 7/2/12.
//  Copyright (c) 2012 Appsfire. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AFBubbleButton.h"

// --------------------------------------------------------------------------------
//  Notification item margins
// --------------------------------------------------------------------------------

#define kAFNotificationItemMargin           10.f
#define kAFNotificationItemHeight           50.f

#define kAFNotificationBubbleMarginWidth    5.f
#define kAFNotificationBubbleMarginHeight   3.f

typedef enum
{
    AFNotificationItemStyleLeft,
    AFNotificationItemStyleRight,
    AFNotificationItemStyleMiddle
} AFNotificationItemStyle;

@interface AFNotificationItem : UIView

// init notification view with custom UIView on left side of bubble
// notification button

- (id)initWithTitleView:(UIView *)titleView;


// add the notification item as the left, right or title item of the
// navigation bar from the UIViewController
//
// style parameter gives requested position on navigation bar.
// cf. AFNotificationItemStyle enum

- (void)addToNavigationBarInViewController:(UIViewController *)viewController
                                     style:(AFNotificationItemStyle)style;

@end
