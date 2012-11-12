//
//  AppDelegate.m
//  AFSample
//
//  Created by Arnaud Mesureur on 7/2/12.
//  Copyright (c) 2012 Appsfire. All rights reserved.
//

#import "AppDelegate.h"
#import "AFAppBoosterSDK.h"
#import "AFBubbleButton.h"
#import "AFNotificationItem.h"

@implementation AppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{

    NSLog(@"Don't forget to add libAppsfireSDK.a to your project. You have to download it from the Appbooster website - http://appsfire.com/appbooster, section Docs.");
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    
    
    // Create the navigation controller with a root view controller.
    //
    // This must be done BEFORE doing anything with AFNotificationItem
    // otherwise it won't be able to access the UINavigationBar.
    //
    // You don't need this if you already created a UINavigationController
    // in Interface Builder.
    
    UIViewController        *rootViewController     = [[UIViewController alloc] init];
    UINavigationController  *navigationController   = [[UINavigationController alloc] initWithRootViewController:rootViewController];
    
    
    // Creating UIImageView with the company logo to use it as the title view in the navigation bar
    // on the left of the notification bubble button.
    
    UIImageView         *titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"myapplogo"]];
    
    
    // Creating the notification item with the title view
    
    AFNotificationItem  *titleItem = [[AFNotificationItem alloc] initWithTitleView:titleView];
    
    
    // Adding the item to the navigation bar in the view controller rootViewController
    //
    // 'style' parameter could have different values :
    //      - AFNotificationItemStyleLeft
    //      - AFNotificationItemStyleRight
    //      - AFNotificationItemStyleMiddle
    //
    
    [titleItem addToNavigationBarInViewController:rootViewController style:AFNotificationItemStyleMiddle];


    // Here is another example of notification item, on the left without additional UIView
    // Uncomment the two following lines to test it.
    
    //AFNotificationItem *leftItem = [[AFNotificationItem alloc] init];
    //[leftItem addToNavigationBarInViewController:rootViewController style:AFNotificationItemStyleLeft];
    
    self.window.rootViewController = navigationController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    
    // Connecting AppBooster with API key
    
    [AFAppBoosterSDK connectWithAPIKey:@"MY_API_KEY"];
            
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
