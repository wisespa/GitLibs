//
//  CacheExampleViewController.m
//  MMSampleApp
//
//
//  Copyright (c) 2010-2012 Millennial Media. All rights reserved.
//

#import "CacheExampleViewController.h"

@implementation CacheExampleViewController
@synthesize statusLabel = statusLabel_;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Cache", @"Cache");
        self.tabBarItem.image = [UIImage imageNamed:@"TabBarIconCache.png"];
    }
    return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Load our patterned image background
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"broken_noise.png"]];

    // Returns an autoreleased MMAdView object
    cacheAdView_ = [MMAdView interstitialWithType:MMFullScreenAdTransition 
                                             apid:CACHE_APID 
                                         delegate:self 
                                           loadAd:NO];
    cacheAdView_.rootViewController = self; // you must set the rootViewController
    
    [self.view addSubview:cacheAdView_];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.statusLabel = nil; // Release our status label

    // Properly release MMAdView object
    cacheAdView_.refreshTimerEnabled = NO; // Stop internal refresh timer
    cacheAdView_.delegate = nil; // Set the delegate to nil
    cacheAdView_ = nil; // Set your variable to nil
}

#pragma mark - IBActions

- (IBAction)fetch:(id)sender
{
    // Request an Ad to cache
    self.statusLabel.text = NSLocalizedString(@"Fetching", @"Fetching");
    BOOL success = [cacheAdView_ fetchAdToCache];
    if(!success) {
        self.statusLabel.text = NSLocalizedString(@"Error", @"Error");
    }
}

- (IBAction)check:(id)sender
{
    // Check if a cached ad is available
    self.statusLabel.text = NSLocalizedString(@"Checking", @"Checking");
    BOOL adAvailable = [cacheAdView_ checkForCachedAd];
    if(!adAvailable) {
        self.statusLabel.text = NSLocalizedString(@"No ad available", @"No ad available");
    }
    else {
        self.statusLabel.text = NSLocalizedString(@"Ad available", @"Ad available");
    }
}

- (IBAction)display:(id)sender
{
    // Display cached ad
    self.statusLabel.text = NSLocalizedString(@"Displaying", @"Displaying");
    BOOL success = [cacheAdView_ displayCachedAd];
    if(!success) {
        self.statusLabel.text = NSLocalizedString(@"Error", @"Error");
    }
}

#pragma mark - MMAdDelegate Methods

- (NSDictionary *) requestData {
    return @{};
}

- (void)adRequestSucceeded:(MMAdView *) adView
{
	NSLog(@"AD REQUEST SUCCEEDED");
}

- (void)adRequestFailed:(MMAdView *) adView
{
	NSLog(@"AD REQUEST FAILED");
    self.statusLabel.text = NSLocalizedString(@"Request failed", @"Request failed");
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
    self.statusLabel.text = NSLocalizedString(@"Caching", @"Caching");

}

- (void)adRequestFinishedCaching:(MMAdView *) adView successful: (BOOL) didSucceed {
    if (didSucceed) {
        NSLog(@"AD FINISHED CACHING");
        self.statusLabel.text = NSLocalizedString(@"Finished Caching", @"Finished Caching");
    }
    else {
        NSLog(@"AD FAILED TO CACHE");
        self.statusLabel.text = NSLocalizedString(@"Caching Failed", @"Caching Failed");
    }
}

#pragma mark - Rotation

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
