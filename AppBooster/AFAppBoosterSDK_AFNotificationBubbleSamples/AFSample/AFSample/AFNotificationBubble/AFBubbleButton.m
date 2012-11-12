//
//  AFBubbleButton.m
//  Appsfire
//
//  Created by Arnaud Mesureur on 7/03/12.
//  Copyright (c) 2012 Appsfire. All rights reserved.
//

#import "AFBubbleButton.h"
#import "AFAppBoosterSDK.h"

@interface AFBubbleButton ()

- (void)checkEnabled;
- (void)needsUpdate;

@end

@implementation AFBubbleButton

@synthesize delegate        = _delegate;
@synthesize canBeDisplayed  = _canBeDisplayed;


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [_labelNotificationsNumber release], _labelNotificationsNumber = nil;
    [_bubbleRed release], _bubbleRed = nil;
    [_bubbleEmpty release], _bubbleEmpty = nil;
    
    [super dealloc];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:CGRectMake(frame.origin.x,
                                           frame.origin.y,
                                           kAFNotificationBubbleWidth,
                                           kAFNotificationBubbleHeight)];
    if (self != nil)
    {
        _canBeDisplayed = YES;
        
        // images
        _bubbleEmpty = [[UIImage imageNamed:kAFNotificationBubbleImageDisabled] retain];
        _bubbleRed   = [[UIImage imageNamed:kAFNotificationBubbleImageEnabled] retain];

        // button's design (bubble image + text)
        [self setBackgroundImage:_bubbleEmpty forState:UIControlStateNormal];
        [self setAlpha:0.f];
        
        // label
        _labelNotificationsNumber = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 31, 20)];
        [_labelNotificationsNumber setBackgroundColor:[ UIColor clearColor]];
        [_labelNotificationsNumber setTextAlignment:UITextAlignmentCenter];
        [_labelNotificationsNumber setTextColor:[UIColor whiteColor]];
        [_labelNotificationsNumber setFont:[UIFont fontWithName:@"HelveticaNeue-Bold" size:12.0]];
        [_labelNotificationsNumber setAdjustsFontSizeToFitWidth:YES];
        [_labelNotificationsNumber setMinimumFontSize:9.0];
        
        // shadow
        [_labelNotificationsNumber setShadowColor:[UIColor colorWithRed:159.0/255.0 green:35.0/255.0 blue:0.0 alpha:0.4] ];
        [_labelNotificationsNumber setShadowOffset:CGSizeMake(0.0, -1.0) ];
        [self addSubview:_labelNotificationsNumber];

        // notifications & callbacks to update the button
        [self addTarget:[AFAppBoosterSDK class]
                 action:@selector(presentNotifications)
       forControlEvents:UIControlEventTouchUpInside];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(checkEnabled)
                                                     name:@"AFSDKisInitialized"
                                                   object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(needsUpdate) name:@"AFNotificationNotificationsCounterNeedsUpdate" object:nil];
                
        [self checkEnabled];
        
    }
    return self;
    
}

- (void)checkEnabled
{
    [UIView animateWithDuration:0.2 animations:^(void) {
        self.alpha = ([AFAppBoosterSDK isInitialized]) ? 1.0 : 0.0;
        
        if ([AFAppBoosterSDK isInitialized]
            && self.alpha == 1.0
            && [_delegate respondsToSelector:@selector(AFBubbleButtonWillShow:)])
        {
            [_delegate AFBubbleButtonWillShow:self];
        }
    }];
}

- (void)setAlpha:(CGFloat)alpha
{
    [super setAlpha:1.0 * (alpha == 1.0 && _canBeDisplayed && [AFAppBoosterSDK isInitialized])];
}

- (void)needsUpdate
{
    NSInteger pendingNotifications;
    
    pendingNotifications = [AFAppBoosterSDK numberOfPendingNotifications];
    if (pendingNotifications > 0)
    {
        [_labelNotificationsNumber setText:[NSString stringWithFormat:@"%d", pendingNotifications]];
        [self setBackgroundImage:_bubbleRed forState:UIControlStateNormal];
    }
    else
    {
        [_labelNotificationsNumber setText:@""];
        [self setBackgroundImage:_bubbleEmpty forState:UIControlStateNormal];
    }
}

@end
