//
//  AFBubbleButton.h
//  Appsfire
//
//  Created by Arnaud Mesureur on 7/03/12.
//  Copyright (c) 2012 Appsfire. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

// --------------------------------------------------------------------------------
//  Notification bubble images files
// --------------------------------------------------------------------------------

#define kAFNotificationBubbleImageDisabled  @"bubble_left_disabled"
#define kAFNotificationBubbleImageEnabled   @"bubble_left_red"

// --------------------------------------------------------------------------------
//  Notification bubble frame size
// --------------------------------------------------------------------------------

#define kAFNotificationBubbleWidth          31.f
#define kAFNotificationBubbleHeight         26.f
#define kAFNotificationLabelHeight          kAFNotificationBubbleHeight * 0.83

@protocol AFBubbleButtonDelegate <NSObject>

@optional
- (void)AFBubbleButtonWillShow:(id)bubbleButton;

@end

@interface AFBubbleButton : UIButton
{
    UILabel *_labelNotificationsNumber;
    UIImage *_bubbleEmpty;
    UIImage *_bubbleRed;
}

@property (nonatomic, assign) id <AFBubbleButtonDelegate> delegate;
@property (nonatomic, assign) BOOL canBeDisplayed;

@end
