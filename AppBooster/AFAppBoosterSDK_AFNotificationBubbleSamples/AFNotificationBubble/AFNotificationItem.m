//
//  AFNotificationItem.m
//  AFSample
//
//  Created by Arnaud Mesureur on 7/2/12.
//  Copyright (c) 2012 Appsfire. All rights reserved.
//

#import "AFNotificationItem.h"
#import "AFBubbleButton.h"

@implementation AFNotificationItem

- (id)init
{
    UIView *noTitleView = [[UIView alloc] init];
    self = [self initWithTitleView:noTitleView];
    [noTitleView release];
    return self;
}

- (id)initWithTitleView:(UIView *)titleView
{
    self = [super init];
    if (self != nil)
    {
        // The notification bubble button
        
        float   bubbleX = titleView.frame.size.width + kAFNotificationBubbleMarginWidth;
        float   bubbleY = kAFNotificationItemHeight / 2
                        - kAFNotificationBubbleHeight / 2
                        + kAFNotificationBubbleMarginHeight;
        CGRect  bubbleFrame = CGRectMake(bubbleX, bubbleY, 0, 0);
        
        AFBubbleButton *bubbleButton = [[AFBubbleButton alloc] initWithFrame:bubbleFrame];
        
        
        // The item view (title view + bubble button)
        
        float   viewHeight  = kAFNotificationItemHeight;
        float   viewWidth   = titleView.frame.size.width
                            + bubbleButton.frame.size.width
                            + kAFNotificationBubbleMarginWidth;
        CGRect  viewFrame   = CGRectMake(0, 0, viewWidth, viewHeight);
        
        self.frame = viewFrame;
        
        
        // adjust title view position
        
        float titleViewY = viewHeight / 2 - titleView.frame.size.height / 2;
        titleView.frame = CGRectMake(0, titleViewY, titleView.frame.size.width, titleView.frame.size.height);

        
        // Add title view and bubble button to subviews
        
        [self addSubview:titleView];
        [self addSubview:bubbleButton];
        
        [bubbleButton release];
    }
    return self;
}

- (void)addToNavigationBarInViewController:(UIViewController *)viewController
                                     style:(AFNotificationItemStyle)style
{
    switch (style)
    {
        case AFNotificationItemStyleLeft:
        {
            UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] init];
            
            leftItem.customView = self;
            viewController.navigationItem.leftBarButtonItem = leftItem;

            [leftItem release];
            break;
        }
        case AFNotificationItemStyleRight:
        {
            UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] init];
            
            rightItem.customView = self;
            viewController.navigationItem.rightBarButtonItem = rightItem;
            [rightItem release];
            break;
        }
        case AFNotificationItemStyleMiddle:
        {
            viewController.navigationItem.titleView = self;
            break;
        }
    }
}

@end
