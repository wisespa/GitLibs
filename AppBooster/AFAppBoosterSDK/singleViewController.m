//
//  singleViewController2.m
//  AFAppBoosterSDK
//
//  Created by Nick Jouannem on 10/6/11.
//  Copyright (c) 2011 Appsfire SAS. All rights reserved.
//

#import "singleViewController.h"
#import "AFABNotificationBar.h"
#import "AFAppBoosterSDK.h"

@implementation singleViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
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
    
    // Let's add an observer to be notified when the SDK is initialized
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appboosterIsInitialized) name:@"AFSDKisInitialized" object:nil];
    
}

- (void)appboosterIsInitialized {
    /*
     TO ADD THE NOTIFICATION BAR, include the header file and allocate it here. In this example, *bar is a retained property of the view controller. By default, the bar will position itself on the lower part of the current view's frame. You can override this by changing the frame after allocating or modifying the code directly.
     */
    AFABNotificationBar *bar = [[AFABNotificationBar alloc] initWithFrame:self.view.bounds];
    [bar setShowWhenCountIsZero:YES];
    [self.view addSubview:bar];
    [bar release];
}

- (IBAction)forceOpenNotificationWindow
{
    [AFAppBoosterSDK presentNotifications];
}

- (IBAction)forceOpenFeedbackWindow
{
    [AFAppBoosterSDK presentFeedback];
}

- (void)dealloc
{
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}
@end
