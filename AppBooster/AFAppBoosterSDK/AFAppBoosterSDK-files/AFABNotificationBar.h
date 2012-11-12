//
//  AFABNotificationBar.h
//  AFAppBoosterSDK
//
//  Created by Nicolas Jouannem on 5/25/11.
//  Copyright 2011 Appsfire SAS. All rights reserved.
//
//  Version : 1.0
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


/*
 
 The constants below give you control over when the Notification Bar becomes visible.
 
 The strings that make up the language used throughout the SDK are loaded asynchronously.
 As a result, when your app first loads, there's a high probability that the bar will be ready for display before
 the strings have been downloaded and updated throughout the SDK. The effect is that the language displayed immediately will be English.
 
 When the SDK is initialized, the user's locale is detected and if strings are available in his or her locale, the SDK will refresh
 the strings asynchronously to provide the user with the best experience. As a result, the language on the Notification Bar will change.
 
 To give you control over this behavior, we have provided the following constants that can be passed as arguments when creating the notification bar.
 
 The default constant used is kAFABNotificationBarSetting_DisplayNowInDefaultLanguageAndRefreshToLocaleStringsAsSoonAsTheyBecomeAvailable
 
 NOTE: The default language in the SDK is English.
 
 */

/*
 This setting will force the Notification Bar to display English throughout the entire first-time session of the user. The second time the app is launched, the locale strings (if they were available and downloaded) will be used instead.
 */
#define kAFABNotificationBarSetting_DisplayNowForceToEnglish    1


/*
 This setting is the default behavior. The Notification Bar will display as soon as it's ready in English and will update automatically when the locale strings (if they were available and downloaded) become available. As a result, the Notification Bar may change language instantly during the user's first session. Every session afer the first, if locale strings were found, they will be used immediately.
 */
#define kAFABNotificationBarSetting_DisplayNowInDefaultLanguageAndRefreshToLocaleStringsAsSoonAsTheyBecomeAvailable 2

/*
 This setting will hide the Botification Bar until the user's locale strings (if they are available from Appsfire and downloaded) are ready. If we do not yet have the strings corresponding to the user's locale, English will be used by default. Once the strings become avilable, the Notification Bar will become visible. Note that this setting takes precedence over the boolean value <showWhenCountIsZero> and will force the <hidden> property of the bar to be <YES> until ready.
 */
#define kAFABNotificationBarSetting_DisplayOnlyWhenLocaleStringsAreReady    3

typedef enum
{
    AFAnimationStyleSlideUp = 0,
    AFAnimationStyleSlideLeft,
    AFAnimationStyleSlideRight,
    AFAnimationStyleFlip
} AFAnimationStyle;

@interface AFABNotificationBar : UIView {
    BOOL    showWhenCountIsZero;
    BOOL    shouldBeVisible;
    BOOL    localeHasBeenSet;
    
    // Sliding direction when the bar appears
    AFAnimationStyle animationStyle;
    
    // Notification counter label
    UILabel *notificationCountLabel;
    
    // the upper light color of the gradient
    UIColor *lightColor;
    
    // the bottom dark color of the gradient
    UIColor *darkColor;
    
    // the lblNotification text color
    UIColor *textColor;
    
    // the upper border color
    UIColor *borderColor;
    
    // add/remove glossy effect to the bar
    BOOL hasGlossyEffect;
    
    // the main label
    UILabel *lblNotification;
    
    NSString *youHaveNewNotifications;
    NSString *youDoNotHaveNewNotifications;
    
    int     displaySetting;
    
}

@property (nonatomic, assign) AFAnimationStyle animationStyle;

@property (nonatomic, assign) BOOL      showWhenCountIsZero;
@property (nonatomic, retain) UILabel   *lblNotification;

@property (nonatomic, assign) BOOL hasGlossyEffect;
@property (nonatomic, retain) UIColor *lightColor;
@property (nonatomic, retain) UIColor *darkColor;
@property (nonatomic, retain) UIColor *textColor;

@property (nonatomic, retain) NSString  *youHaveNewNotifications;
@property (nonatomic, retain) NSString  *youDoNotHaveNewNotifications;

@property (nonatomic, assign) int       displaySetting;

@property (nonatomic, assign) BOOL      localeHasBeenSet;

/*
 Use this when adding the Notification Bar to a normal view
 */
- (id)initWithFrame:(CGRect)frame;

/*
 Same as above but you can specify a different display setting
 */
- (id)initWithFrame:(CGRect)frame usingDisplayOption:(int)setting;

/*
 Use this when trying to add the Notification Bar above the tabs of a default Tab Bar controller. The notification bar will always stay above the tabs.
 */
- (id)initWithTabBarController:(UITabBarController *)tabbarController;
/*
 Same as above but you can specify a different display setting
 */
- (id)initWithTabBarController:(UITabBarController *)tabbarController usingDisplayOption:(int)displaySetting;



/*
 Use this when trying to add the Notification Bar above the bottom tool bar. Send the bounds of the parent view of the tool bar in question.
 */
- (id)initWithFrameContainingBottomToolbar:(CGRect)frame;
/*
 Same as above but you can specify a different display setting
 */
- (id)initWithFrameContainingBottomToolbar:(CGRect)frame usingDisplayOption:(int)displaySetting;


- (void)notificationsAreLoaded;
- (void)notificationsAreUnloaded;
- (void)updateNotificationsCounter2:(NSNotification *)notification;
- (void)saveLocalizedStringsWithDictionary:(NSDictionary *)strings;
- (void)loadLocalizedStrings;
- (void)dictionaryUpdated;
- (void)sdkIsInitializing;
- (void)sdkIsInitialized; 
- (void)addObservers2;
- (void)removeObservers2;
- (void)showBar;
- (void)hideBar;

@end
