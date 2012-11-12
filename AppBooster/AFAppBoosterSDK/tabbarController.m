//
//  tabbarController.m
//  AFAppBoosterSDK
//
//  Created by Nicolas Jouannem on 6/1/11.
//  Copyright 2011 APPSFIRE. All rights reserved.
//

#import "tabbarController.h"
#import "AFABNotificationBar.h"
#import "AFAppBoosterSDK.h"

@implementation tabbarController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    // If you want to place the Notification Bar right above the tab bar controller, you can use this :
    
    AFABNotificationBar *bar = [[AFABNotificationBar alloc] initWithTabBarController:self];
    [bar setShowWhenCountIsZero:YES];
    [self.view addSubview:bar];
    [bar release];
    
    
    // OR, if you have a dedicated tab, you can update the badge count using an observer
    [[NSNotificationCenter defaultCenter] addObserver:self
                                              selector:@selector(updateTabBarItemCount:) name:@"AFNotificationNotificationsCounterNeedsUpdate" object:nil];

}

- (void)updateTabBarItemCount:(NSNotification *)note
{
    [[[self viewControllers] objectAtIndex:1] tabBarItem].badgeValue = [NSString stringWithFormat:@"%i", [AFAppBoosterSDK numberOfPendingNotifications]];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

@end
