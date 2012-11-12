//
//  AFAppBoosterSDKAppDelegate.m
//  AFAppBoosterSDK
//
//  Created by Nicolas Jouannem on 4/21/11.
//  Copyright 2011 Appsfire. All rights reserved.
//

#import "AFAppBoosterSDKAppDelegate.h"
#import "AFAppBoosterSDK.h"

#import "singleViewController.h"
#import "singleViewController_iPad.h"

@implementation AFAppBoosterSDKAppDelegate

@synthesize window=_window;
@synthesize viewController=_viewController;
@synthesize tabController=_tabController;
@synthesize toolbarController=_toolbarController;
@synthesize toolbar;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    BOOL showTabBar     = NO;   // Change to YES to view a Tab Bar version
    BOOL showToolBar    = NO;   // Change to YES to view an implentation with a bottom tool bar
    
    // Override point for customization after application launch.
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        self.viewController = [[singleViewController alloc] initWithNibName:@"singleViewController" bundle:nil]; 
    } else {
        self.viewController = [[singleViewController_iPad alloc] initWithNibName:@"singleViewController_iPad" bundle:nil]; 
    }
    
    if ( [self.window respondsToSelector:@selector(rootViewController)] )
    {
        if (showTabBar)
        {
            self.window.rootViewController = self.tabController;
        } else if (showToolBar) {
            self.window.rootViewController = self.toolbarController;
        } else {
            self.window.rootViewController = self.viewController;
        }
        
    } else {   
        if (showTabBar)
        {
            [self.window addSubview :self.tabController.view];            
        } else if (showToolBar) {
            [self.window addSubview :self.toolbarController.view];
        } else {
            [self.window addSubview:self.viewController.view];
        }
        
    }
    
    [self.window makeKeyAndVisible];
    
    
    // MANDATORY - YOU MUST CALL THIS CODE HERE
    NSString *apiKey = @"INSERT YOUR API KEY HERE";
    
    if ([AFAppBoosterSDK connectWithAPIKey:apiKey afterDelay:0.5])
        NSLog(@"Appsfire Appbooster Demo App launched with %@",[AFAppBoosterSDK getAFSDKVersionInfo]);
    else
        NSLog(@"Unabled to launch Appsfire Appbooster Demo App. Probably incompatible iOS.");

    // END OF MANDATORY CODE
    
    
    /*
        Apple has deprecated the UDID which means that apps using the API
        call to uniqueIdentifier ([[UIDevice currentDevice] uniqueIdentifier])
        will be rejected. We strongly advise you to use the OpenUDID alternative
        which respects your user's privacy and guarantees a unique identifier for
        your services. You can check out the entire source code here: http://openudid.org
        The AppboosterSDK lets you access the OpenUDID of your user very easily.
    */
    
    NSLog(@"OpenUDID: %@ (visit http://openudid.org for more information)", [AFAppBoosterSDK openUDID]);
    
    /*
     
     OPTIONAL - Set gradients
    
     [AFAppBoosterSDK useGradients:[NSArray arrayWithObjects:
                       [UIColor colorWithRed:.1137 green:.2274 blue:.7764 alpha:1.0],
                       [UIColor colorWithRed:.2196 green:.3411 blue:.9333 alpha:1.0],
                       nil]];
    
     */    
    
    
    /*
     
     OPTIONAL - Change default style to Full Screen (Note: You can only set this once - at app startup)
     
        [AFAppBoosterSDK useFullScreenStyle];
     
    */
    
    /*
     
     OPTIONAL - Ask SDK to handle your springboard badge count
    
        [AFAppBoosterSDK handleBadgeCountLocally:YES];
     
        or ask SDK to handle your springboard badge count locally AND remotely. In the latter scenario, the count will be updated even if the user is not using your app. To enable this, you must supply your production push certificate in your Manage Apps space (http://appsfire.com/sdk)
     
     
        [AFAppBoosterSDK handleBadgeCountLocallyAndRemotely:YES]; 
     
     
        NOTE : If you choose the second option, you must register your user's push token and send the token to the SDK. To start, you will have to register the token using this code :
     
     
                 [[UIApplication sharedApplication]
                 registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                 UIRemoteNotificationTypeSound |
                 UIRemoteNotificationTypeAlert)];
     
        The callbacks to this fuction is 
     
            - (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
            - (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
     
        See this callback function below for the next steps to follow.
    
    */
    
    
    /*
     
     OPTIONAL - Send custom data to the SDK. Any instances of the "key values" will be replaced by what you send. You must send NSStrings ONLY.
    
    
         NSDictionary *customTags = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"Bob",@"34",nil]
                                                    forKeys:[NSArray arrayWithObjects:@"FIRSTNAME",@"AGE",nil]];
     
         [AFAppBoosterSDK useCustomValues:customTags];
    
    */
    
    
    
    
    /*
     
        OPTIONAL - You have the possibility of sending your user's email to the SDK feedback form (saves time for your user) and/or hiding the email field from the feedback form.
     
        [AFAppBoosterSDK setUserEmail:@"YOUR USER'S EMAIL HERE" isModifiable:YES];
     
        NOTE : The email must be valid for this function to work correctly.
     
        If you want to remove the email from the SDK form, simply send "nil"
     
        ie/ [AFAppBoosterSDK setUserEmail:nil isModifiable:YES];
     
     */

    return YES;
}

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    /*
        // Do what you want with it
        NSLog(@"TOKEN Registration Successful");
        [AFAppBoosterSDK registerPushToken:deviceToken];
        [AFAppBoosterSDK handleBadgeCountLocallyAndRemotely:YES];
     */
}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    /*
        NSLog(@"Failed to register for remote notifications. Make sure you're set up correctly in the Mobile Provisioning section of iTunes Connect.");
        
        [[[[UIAlertView alloc] initWithTitle:@"WARNING" message:@"This build failed to register for remote notifications." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease] show];
        
        // In this scenario, you can resort to handling the badge count locally or not at all.
        [AFAppBoosterSDK handleBadgeCountLocally:YES];
     */
}

- (IBAction)forceOpenNotificationWindow
{
    // Open the Notification Wall
    [AFAppBoosterSDK presentNotifications];
}

- (IBAction)forceOpenFeedbackWindow
{
    // Open the Feedback Form immediately
    [AFAppBoosterSDK presentFeedback];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc
{
    [_window release];
    [_viewController release];
    [_tabController release];
    [super dealloc];
}

@end
