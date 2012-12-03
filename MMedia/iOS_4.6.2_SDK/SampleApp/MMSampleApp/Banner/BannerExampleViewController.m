//
//  BannerExampleViewController.m
//  MMSampleApp
//
//
//  Copyright (c) 2010-2012 Millennial Media. All rights reserved.
//

#import "BannerExampleViewController.h"

@implementation BannerExampleViewController
@synthesize statusLabel = statusLabel_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Banner", @"Banner");
        self.tabBarItem.image = [UIImage imageNamed:@"TabBarBanner.png"];
    }
    return self;
}

- (IBAction)refresh:(id)sender
{
    [bannerAdView_ refreshAd];

}

#pragma mark - View lifecycle

- (void) viewDidDisappear:(BOOL)animated 
{
    // Stop internal refresh timer when the ad is not on the screen

    bannerAdView_.refreshTimerEnabled = NO; 
}

- (void) viewDidAppear:(BOOL)animated 
{
    // Start internal refresh timer when the view reappears
    
    bannerAdView_.refreshTimerEnabled = YES; 
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Load our patterned image background
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"broken_noise.png"]];
    
    // Create a 320 x 53 frame to display iPhone ads, or a 768 x 90 frame to display iPad ads
    CGRect adFrame = (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) ? CGRectMake(0, 0, 320, 53) : CGRectMake(0, 0, 728, 90);
    
    // Returns an autoreleased MMAdView object
    bannerAdView_ = [MMAdView adWithFrame:adFrame 
                                     type:MMBannerAdTop 
                                     apid:BANNER_APID
                                 delegate:self  // Must be set, CANNOT be nil
                                   loadAd:YES   // Loads an ad immediately
                               startTimer:YES]; // Start timer to auto refresh the ad view
    bannerAdView_.rootViewController = self; // you must set the rootViewController
    [self.view addSubview:bannerAdView_];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.statusLabel = nil; // Release our status label
    
    // Properly release MMAdView object
    bannerAdView_.refreshTimerEnabled = NO; // Stop internal refresh timer
    bannerAdView_.delegate = nil; // Set the delegate to nil
    bannerAdView_ = nil; // Set your variable to nil
}

#pragma mark - MMAdDelegate Methods

- (void)adRequestSucceeded:(MMAdView *) adView
{
	NSLog(@"AD REQUEST SUCCEEDED");
    self.statusLabel.text = NSLocalizedString(@"Request succeeded", @"Request succeeded");
}

- (void)adRequestFailed:(MMAdView *) adView
{
	NSLog(@"AD REQUEST FAILED");
    self.statusLabel.text = NSLocalizedString(@"Request failed", @"Request failed");
}

- (void)adDidRefresh:(MMAdView *)adView
{
    NSLog(@"AD DID REFRESH");
    self.statusLabel.text = NSLocalizedString(@"Refreshing", @"Refreshing");
}

- (void)adWasTapped:(MMAdView *)adView
{
	NSLog(@"AD WAS TAPPED");
}

- (void)applicationWillTerminateFromAd
{
	NSLog(@"AD WILL OPEN SAFARI");
}

- (void)adModalWasDismissed
{
	NSLog(@"AD MODAL WAS DISMISSED");
}

- (void)adModalWillAppear
{
	NSLog(@"AD MODAL WILL APPEAR");
}

- (void)adModalDidAppear
{
	NSLog(@"AD MODAL DID APPEAR");
}

// Caching delegates

- (void)adRequestIsCaching:(MMAdView *) adView {
    NSLog(@"AD IS CACHING");
}

- (void)adRequestFinishedCaching:(MMAdView *) adView successful: (BOOL) didSucceed {
    if (didSucceed) {
        NSLog(@"AD FINISHED CACHING");
    }
    else {
        NSLog(@"AD FAILED TO CACHE");
    }
}

#pragma mark - Rotation

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
