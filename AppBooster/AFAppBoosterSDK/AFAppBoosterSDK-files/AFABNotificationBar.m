//
//  AFABNotificationBar.m
//  AFAppBoosterSDK
//
//  Created by Nicolas Jouannem on 5/25/11.
//  Copyright 2011 Appsfire SAS. All rights reserved.
//

#import "QuartzCore/QuartzCore.h"
#import <GLKit/GLKMath.h>
#import "AFAppBoosterSDK.h"
#import "AFABNotificationBar.h"

#define kAFNotificationBarAnimationDuration         .6f
#define kAFNotificationBarFadeAnimationDuration     .5f
#define kAFNotificationBarAlpha                     1.0f
#define kAFNotificationBarHeight                    44.0f
#define kAFNotificationBarPaddingTopBottom          5.0f
#define kAFNotificationBarPaddingLeft               10.0f
#define kAFNotificationBarPaddingRight              10.0f
#define kAFNotificationBarCountLabelPadding         10.f

/* Helper drawing functions */
void drawLinearGradient(CGContextRef context,
                        CGRect rect,
                        CGColorRef startColor,
                        CGColorRef endColor);

void drawGlossAndGradient(CGContextRef context,
                          CGRect rect,
                          CGColorRef startColor,
                          CGColorRef endColor);


@interface AFABNotificationBar (Private)
- (void)fadeTo:(CGFloat)alpha;
- (void)slideUp;
- (void)slideDown;
@end

@implementation AFABNotificationBar

@synthesize showWhenCountIsZero;
@synthesize lblNotification;

@synthesize hasGlossyEffect;
@synthesize lightColor;
@dynamic darkColor;
@dynamic textColor;

@synthesize youHaveNewNotifications, youDoNotHaveNewNotifications;
@synthesize displaySetting;
@synthesize localeHasBeenSet;

@synthesize animationStyle;

#pragma mark    Bottom Toolbar initialization
-(id)initWithFrameContainingBottomToolbar:(CGRect)frame
{
    return [self initWithFrameContainingBottomToolbar:frame usingDisplayOption:kAFABNotificationBarSetting_DisplayNowInDefaultLanguageAndRefreshToLocaleStringsAsSoonAsTheyBecomeAvailable];
}

- (id)initWithFrameContainingBottomToolbar:(CGRect)frame usingDisplayOption:(int)setting
{
    
    self.displaySetting = setting;
    
    return [self initWithFrame:CGRectMake(frame.origin.x,
                                          frame.origin.y,
                                          frame.size.width,
                                          frame.size.height - 44.0)]; // 44.0 is the default height of a toolbar object
    
}

#pragma mark    UITabBarController implementation
-(id)initWithTabBarController:(UITabBarController *)tabbarController
{
    return [self initWithTabBarController:tabbarController usingDisplayOption:kAFABNotificationBarSetting_DisplayNowInDefaultLanguageAndRefreshToLocaleStringsAsSoonAsTheyBecomeAvailable];
}

-(id)initWithTabBarController:(UITabBarController *)tabbarController usingDisplayOption:(int)setting
{
    
    self.displaySetting = setting;
    
    // UIViewController *firstTabView = [tabbarController.viewControllers objectAtIndex:0];
    
    // CGRect firstViewFrame = firstTabView.view.frame;
    
    return [self initWithFrame:CGRectMake(0, 0,
                                          tabbarController.tabBar.frame.size.width,
                                          [UIScreen mainScreen].bounds.size.height - tabbarController.tabBar.frame.size.height)];
    // firstViewFrame.size.height - kAFnotificationBarHeight + 2)]; // Play with the "2" to reduce or increase vertical spacing
}

#pragma mark    Standard initWithFrame
- (id)initWithFrame:(CGRect)frame usingDisplayOption:(int)setting
{
    self.displaySetting = setting;
    return [self initWithFrame:frame];
}

- (id)initWithFrame:(CGRect)frame
{
    self.displaySetting = 2;
    int fontSize        = 14;
    int barHeight       = kAFNotificationBarHeight;
    CGRect newFrame     = CGRectMake(0, frame.size.height - barHeight,
                                     frame.size.width, barHeight);
    
    self = [super initWithFrame:newFrame];
    if (self)
    {
        hasGlossyEffect = NO;
        
        self.lightColor = [UIColor colorWithRed:65.0f/255.0f green:133.0/255.0f blue:244.0f/255.0f alpha:1.0];
        self.darkColor = [UIColor colorWithRed:25.0/255.0 green:79.0/255.0 blue:220.0/255.0 alpha:1.0];
        self.textColor = [UIColor whiteColor];
        
        // Add notification count label
        notificationCountLabel = [[UILabel alloc] init];
        [notificationCountLabel setTextAlignment:UITextAlignmentCenter];
        [notificationCountLabel setTextColor:darkColor];
        [notificationCountLabel setAdjustsFontSizeToFitWidth:YES];
        [notificationCountLabel setBackgroundColor:[UIColor colorWithRed:1.f green:1.f blue:1.f alpha:0.9f]];
        [notificationCountLabel setFont:[UIFont boldSystemFontOfSize:fontSize]];
        [notificationCountLabel.layer setCornerRadius:3];
        [notificationCountLabel sizeToFit];
        [notificationCountLabel addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew context:nil];
        [self addSubview:notificationCountLabel];
        
        notificationCountLabel.text = [NSString stringWithFormat:@"%d", [AFAppBoosterSDK numberOfPendingNotifications]];
        
        // Add label
        self.lblNotification = [[[UILabel alloc] initWithFrame:CGRectMake(kAFNotificationBarPaddingLeft,
                                                                          0.0,
                                                                          newFrame.size.width - 40,
                                                                          barHeight)] autorelease];
        // [lblNotification setText:@"You have new notifications"];
        [lblNotification setText:@""];
        [lblNotification setTextColor:textColor];
        [lblNotification setAdjustsFontSizeToFitWidth:YES];
        [lblNotification setBackgroundColor:[UIColor clearColor]];
        [lblNotification setFont:[UIFont boldSystemFontOfSize:fontSize]];
        [lblNotification setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
        [lblNotification setShadowColor:[UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.5f]];
        [lblNotification setShadowOffset:CGSizeMake(0, -1)];
        
        [self addSubview:lblNotification];
        
        [self setAutoresizesSubviews:YES];
        [self setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin];
        [self setContentMode:UIViewContentModeRedraw];
        
        // By default, we don't show the bar when there are no notifications. This can be overwritten.
        showWhenCountIsZero = NO;
        
        // By default, bar is sliding up
        animationStyle = AFAnimationStyleSlideUp;
        
        // Here we set default pre-embarked English strings. Localized strings will be downloaded by the SDK and sent back.
        // See the constants available in AFABNotificationBar.h to see different ways of handling this.
        
        self.youHaveNewNotifications         = @"";
        self.youDoNotHaveNewNotifications    = @"";
        
        [self loadLocalizedStrings];
        
        [self addObservers2];
        
        self.layer.zPosition = 100;
    }
    return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"text"])
    {
        [self layoutSubviews];
    }
}

- (void)layoutSubviews
{
    [notificationCountLabel sizeToFit];
    
    float height = notificationCountLabel.frame.size.height;
    float width = notificationCountLabel.frame.size.width + kAFNotificationBarCountLabelPadding;
    float originX = self.bounds.size.width - width - kAFNotificationBarPaddingRight;
    float originY = kAFNotificationBarHeight / 2 - height / 2;
    
    notificationCountLabel.frame = CGRectMake(originX, originY, width, height);
}

- (UIColor *)darkColor
{
    return darkColor;
}

- (void)setDarkColor:(UIColor *)aDarkColor
{
    [darkColor release];
    darkColor = [aDarkColor retain];
    notificationCountLabel.textColor = aDarkColor;
}

- (UIColor *)textColor
{
    return textColor;
}

- (void)setTextColor:(UIColor *)aTextColor
{
    [textColor release];
    textColor = [aTextColor retain];
    if (textColor)
    {
        lblNotification.textColor = textColor;
    }
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // gradient
    if (hasGlossyEffect)
        drawGlossAndGradient(context, self.bounds, [lightColor CGColor], [darkColor CGColor]);
    else
        drawLinearGradient(context, self.bounds, [lightColor CGColor], [darkColor CGColor]);
    
    // Borders
    CGRect viewRect = self.bounds;
    CGColorRef innerColor = [[UIColor colorWithRed:1.f green:1.f blue:1.f alpha:0.3f] CGColor];
    CGColorRef outerColor = [darkColor CGColor];
    
    CGPoint innerBorder[2] = {
        CGPointMake(viewRect.origin.x, viewRect.origin.y + 1),
        CGPointMake(viewRect.origin.x + viewRect.size.width, viewRect.origin.y + 1)
    };
    CGContextSetStrokeColorWithColor(context, innerColor);
    CGContextSetLineWidth(context, 1.f);
    CGContextStrokeLineSegments(context, innerBorder, 2);
    
    CGPoint outerBorder[2] = {
        CGPointMake(viewRect.origin.x, viewRect.origin.y),
        CGPointMake(viewRect.origin.x + viewRect.size.width, viewRect.origin.y)
    };
    CGContextSetStrokeColorWithColor(context, outerColor);
    CGContextSetLineWidth(context, 1.f);
    CGContextStrokeLineSegments(context, outerBorder, 2);
    
    [super drawRect:rect];
    
    [self updateNotificationsCounter2:nil];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [AFAppBoosterSDK presentNotifications];
}

#pragma mark Behavioral functions
// Saves the localized or default language strings to cache for future use
- (void)saveLocalizedStringsWithDictionary:(NSDictionary *)strings
{
    
    if (strings == nil || [strings count] == 0)
    {
        NSLog(@"Notice : AFABNotificationBar::saveLocalizedStringsWithDictionary did not receive a valid dictionary; will retry later");
        return;
    }
    
    // Only save if a) There is no existing saved file or b) The existing saved strings are different
    // 1. check if local string file cache exists
    NSString *stringsFile = [[[NSHomeDirectory() stringByAppendingPathComponent:@"Library"] stringByAppendingPathComponent:@"Caches"] stringByAppendingPathComponent:@"AFNotificationBarStrings"];
    NSFileManager *fileManager	= [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:stringsFile])
    {
        NSDictionary *existing = [NSDictionary dictionaryWithContentsOfFile:stringsFile];
        NSString *one         = [existing valueForKey:@"YOU_HAVE_NOTIFS"];
        NSString *two         = [existing valueForKey:@"YOU_DONT_HAVE_NOTIFS"];
        if (!([one isEqualToString:[strings valueForKey:@"YOU_HAVE_NOTIFS"]] && [two isEqualToString:[strings valueForKey:@"YOU_DONT_HAVE_NOTIFS"]]))
        {
            // They are different, save them to cache
            [strings writeToFile:stringsFile atomically:YES];
        }
    } else {
        [strings writeToFile:stringsFile atomically:YES];
    }
    
    if (localeHasBeenSet == YES && self.displaySetting != kAFABNotificationBarSetting_DisplayNowForceToEnglish)
    {
        self.youHaveNewNotifications         = [strings valueForKey:@"YOU_HAVE_NOTIFS"];
        self.youDoNotHaveNewNotifications    = [strings valueForKey:@"YOU_DONT_HAVE_NOTIFS"];
    }
    
}

// Loads localized or default language strings from cache for future use
- (void)loadLocalizedStrings
{
    // 1. check if local string file cache exists
    NSString *stringsFile = [[[NSHomeDirectory() stringByAppendingPathComponent:@"Library"] stringByAppendingPathComponent:@"Caches"] stringByAppendingPathComponent:@"AFNotificationBarStrings"];
    NSFileManager *fileManager	= [NSFileManager defaultManager];
    if ([fileManager fileExistsAtPath:stringsFile])
    {
        // The file exists so we have previously stored files to cache. Let's load these strings now
        NSDictionary *strings = [NSDictionary dictionaryWithContentsOfFile:stringsFile];
        self.youHaveNewNotifications         = [NSString stringWithString:[strings valueForKey:@"YOU_HAVE_NOTIFS"]];
        self.youDoNotHaveNewNotifications    = [NSString stringWithString:[strings valueForKey:@"YOU_DONT_HAVE_NOTIFS"]];
        localeHasBeenSet = YES;
    } else {
        // The file does not exist - we have no strings in cache
    }
    
} // loadLocalizedStrings

- (void)dictionaryUpdated
{
    localeHasBeenSet = YES;
    [self updateNotificationsCounter2:nil];
}

- (void)notificationsAreLoaded
{
    [self hideBar];
}

- (void)showBar
{
    if (self.alpha == 0.f)
    {
        if ([AFAppBoosterSDK isInitialized])
        {
            [self fadeTo:1.f];
            [self slideUp];
        }
    }
}

- (void)hideBar
{
    if (self.alpha == 1.f)
    {
        [self fadeTo:0.f];
        [self slideDown];
    }
}

- (void)fadeTo:(CGFloat)alpha
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:kAFNotificationBarFadeAnimationDuration];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    [self setAlpha:alpha];
    [UIView commitAnimations];
}

- (void)slideUp
{
    if (animationStyle == AFAnimationStyleFlip)
    {
        CABasicAnimation *flipAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
        flipAnim.delegate = self;
        flipAnim.duration = kAFNotificationBarAnimationDuration;
        flipAnim.fillMode = kCAFillModeForwards;
        flipAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        flipAnim.fromValue = [NSNumber numberWithFloat:GLKMathDegreesToRadians(-270)];
        flipAnim.toValue = [NSNumber numberWithFloat:GLKMathDegreesToRadians(0)];
        [self.layer addAnimation:flipAnim forKey:@"flip"];
    }
    else // slide animation
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:kAFNotificationBarAnimationDuration];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        if (animationStyle == AFAnimationStyleSlideRight)
            self.transform = CGAffineTransformTranslate(self.transform, -self.frame.size.width, 0);
        else if (animationStyle == AFAnimationStyleSlideLeft)
            self.transform = CGAffineTransformTranslate(self.transform, self.frame.size.width, 0);
        else // animationStyle == AFAnimationStyleSlideUp by default
            self.transform = CGAffineTransformTranslate(self.transform, 0, -self.frame.size.height);
        [UIView commitAnimations];
    }
}

- (void)slideDown
{
    if (animationStyle == AFAnimationStyleFlip)
    {
        CABasicAnimation *flipAnim = [CABasicAnimation animationWithKeyPath:@"transform.rotation.x"];
        flipAnim.delegate = self;
        flipAnim.duration = kAFNotificationBarAnimationDuration;
        flipAnim.fillMode = kCAFillModeBoth;
        flipAnim.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        flipAnim.toValue = [NSNumber numberWithFloat:GLKMathDegreesToRadians(-270)];
        [self.layer addAnimation:flipAnim forKey:@"flipBack"];
    }
    else
    {
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:kAFNotificationBarAnimationDuration];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        if (animationStyle == AFAnimationStyleSlideRight)
            self.transform = CGAffineTransformTranslate(self.transform, self.frame.size.width, 0);
        else if (animationStyle == AFAnimationStyleSlideRight)
            self.transform = CGAffineTransformTranslate(self.transform, -self.frame.size.width, 0);
        else // animationStyle == AFAnimationStyleSlideUp by default
            self.transform = CGAffineTransformTranslate(self.transform, 0, self.frame.size.height);
        [UIView commitAnimations];
    }
}

- (void)notificationsAreUnloaded
{
    
    // if notif, then show the bar
    if ([AFAppBoosterSDK numberOfPendingNotifications] > 0)
    {
        [lblNotification setText:self.youHaveNewNotifications];
        [notificationCountLabel setHidden:NO];
        [self showBar];
        // else, differents cases
    }
    else
    {
        [lblNotification setText:self.youDoNotHaveNewNotifications];
        [notificationCountLabel setHidden:YES];
        if (showWhenCountIsZero) // if show when no notif
        {
            [self showBar];
        }
        else // if hide when no notif
        {
            [self hideBar];
        }
    }
}

- (void)updateNotificationsCounter2:(NSNotification *)notification
{
    
    if (notification != nil)
    {
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:2];
        
        // Update label on notification bar
        if ([[notification userInfo] valueForKey:@"displayStringNone"])
        {
            
            [dict setValue:[NSString stringWithString:[[notification userInfo] valueForKey:@"displayStringNone"]] forKey:@"YOU_DONT_HAVE_NOTIFS"];
            
            if ( self.displaySetting == kAFABNotificationBarSetting_DisplayNowInDefaultLanguageAndRefreshToLocaleStringsAsSoonAsTheyBecomeAvailable )
            {
                self.youDoNotHaveNewNotifications = [NSString stringWithString:[[notification userInfo] valueForKey:@"displayStringNone"]];
            }
        }
        if ([[notification userInfo] valueForKey:@"displayStringNew"])
        {
            
            [dict setValue:[NSString stringWithString:[[notification userInfo] valueForKey:@"displayStringNew"]] forKey:@"YOU_HAVE_NOTIFS"];
            
            if ( self.displaySetting == kAFABNotificationBarSetting_DisplayNowInDefaultLanguageAndRefreshToLocaleStringsAsSoonAsTheyBecomeAvailable )
            {
                self.youHaveNewNotifications = [NSString stringWithString:[[notification userInfo] valueForKey:@"displayStringNew"]];
            }
        }
        
        // In any case, regardless of display setting, we need to save these strings if we don't have them or if they are different than the ones we have
        [self saveLocalizedStringsWithDictionary:dict];
        [dict release];
        
        if ((self.displaySetting == kAFABNotificationBarSetting_DisplayNowForceToEnglish ||
             self.displaySetting == kAFABNotificationBarSetting_DisplayNowInDefaultLanguageAndRefreshToLocaleStringsAsSoonAsTheyBecomeAvailable)
            && localeHasBeenSet == NO
            && [self.youDoNotHaveNewNotifications isEqualToString:@""]
            && [self.youHaveNewNotifications isEqualToString:@""])
        {
            // We must make sure we have English strings by now
            self.youHaveNewNotifications         = @"You have new notifications";
            self.youDoNotHaveNewNotifications    = @"You have no new notifications";
        }
        
    } else {
        if ((self.displaySetting == kAFABNotificationBarSetting_DisplayNowForceToEnglish || self.displaySetting == kAFABNotificationBarSetting_DisplayNowInDefaultLanguageAndRefreshToLocaleStringsAsSoonAsTheyBecomeAvailable)
            && ([self.youHaveNewNotifications isEqualToString:@""] && [self.youDoNotHaveNewNotifications isEqualToString:@""]))
        {
            self.youHaveNewNotifications         = @"You have new notifications";
            self.youDoNotHaveNewNotifications    = @"You have no new notifications";
        }
    }
    
    [notificationCountLabel setText:[NSString stringWithFormat:@"%i", [AFAppBoosterSDK numberOfPendingNotifications]]];
    [notificationCountLabel setNeedsDisplay];
    
    // If we're displaying the Notification Window, then exit now
    if ([AFAppBoosterSDK isDisplayed])
    {
        return;
    }
    
    // Check if we have strings
    
    if ([self.youHaveNewNotifications isEqualToString:@""] || [self.youDoNotHaveNewNotifications isEqualToString:@""])
    {
        return;
    }
    
    if ([AFAppBoosterSDK numberOfPendingNotifications] == 0)
    {
        [notificationCountLabel setHidden:YES];
        if (showWhenCountIsZero == YES)
        {
            [lblNotification setText:self.youDoNotHaveNewNotifications];
            [lblNotification setHidden:NO];
            [self showBar];
            return;
        } else {
            [lblNotification setText:self.youDoNotHaveNewNotifications];
            [self hideBar];
        }
    } else {
        [notificationCountLabel setHidden:NO];
        [lblNotification setHidden:NO];
        [lblNotification setText:self.youHaveNewNotifications];
        [self showBar];
    }
    
} // updateNotificationsCounter

- (void)sdkIsInitializing
{
    // NSLog(@"SDK is initializing");
} // sdkIsInitializing

- (void)sdkIsInitialized
{
    // NSLog(@"SDK is initialized");
    [self updateNotificationsCounter2:nil];
} // sdkIsInitialized

#pragma mark Observers
- (void)addObservers2 {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(sdkIsInitializing) name:@"AFSDKisInitializing" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(sdkIsInitialized) name:@"AFSDKisInitialized" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(notificationsAreLoaded) name:@"AFNotificationsHaveBeenLoaded" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(notificationsAreUnloaded) name:@"AFNotificationsHaveBeenUnLoaded" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(updateNotificationsCounter2:) name:@"AFNotificationNotificationsCounterNeedsUpdate" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(dictionaryUpdated) name:@"AFSDKdictionaryUpdated" object:nil];
    
}

- (void)removeObservers2 {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"AFSDKisInitializing" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"AFSDKisInitialized" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"AFNotificationsHaveBeenLoaded" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"AFNotificationsHaveBeenUnLoaded" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"AFNotificationNotificationsCounterNeedsUpdate" object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:@"AFSDKdictionaryUpdated" object:nil];
    
}

#pragma Override setter for showWhenCountIsZero
- (void)setShowWhenCountIsZero:(BOOL)yesNo
{
    showWhenCountIsZero = yesNo;
    // Show in all cases
    if (showWhenCountIsZero == YES)
    {
        if ([self isHidden] == YES)
        {
            [self showBar];
            return;
        }
    } else {
        if ([AFAppBoosterSDK numberOfPendingNotifications] == 0)
        {
            [self hideBar];
        }
    }
}

#pragma mark Dealloc
- (void)dealloc
{
    [notificationCountLabel removeObserver:self forKeyPath:@"text"];
    [notificationCountLabel release];
    [lightColor release];
    [darkColor release];
    [textColor release];
    
    [self removeObservers2];
    [lblNotification release];
    [youHaveNewNotifications release];
    [youDoNotHaveNewNotifications release];
    [super dealloc];
}

@end



#pragma mark - Helper functions

//////////////////////////////////////////////////
/// Drawing helper functions
//////////////////////////////////////////////////
void drawLinearGradient(CGContextRef context,
                        CGRect rect,
                        CGColorRef startColor,
                        CGColorRef endColor)
{
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };
    
    NSArray *colors = [NSArray arrayWithObjects:(id)startColor, (id)endColor, nil];
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace,
                                                        (CFArrayRef) colors, locations);
    
    CGPoint startPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMinY(rect));
    CGPoint endPoint = CGPointMake(CGRectGetMidX(rect), CGRectGetMaxY(rect));
    
    CGContextSaveGState(context);
    CGContextAddRect(context, rect);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGContextRestoreGState(context);
    
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);
}

void drawGlossAndGradient(CGContextRef context,
                          CGRect rect,
                          CGColorRef startColor,
                          CGColorRef endColor)
{
    drawLinearGradient(context, rect, startColor, endColor);
    CGColorRef glossColor1 = [UIColor colorWithRed:1.0 green:1.0
                                              blue:1.0 alpha:0.35].CGColor;
    CGColorRef glossColor2 = [UIColor colorWithRed:1.0 green:1.0
                                              blue:1.0 alpha:0.1].CGColor;
    CGRect topHalf = CGRectMake(rect.origin.x, rect.origin.y,
                                rect.size.width, rect.size.height/2);
    drawLinearGradient(context, topHalf, glossColor1, glossColor2);
}


