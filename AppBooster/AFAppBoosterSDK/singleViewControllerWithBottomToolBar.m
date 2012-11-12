//
//  singleViewControllerWithBottomToolBar.m
//  AFAppBoosterSDK
//
//  Created by Nicolas Jouannem on 6/3/11.
//  Copyright 2011 APPSFIRE. All rights reserved.
//

#import "singleViewControllerWithBottomToolBar.h"
#import "AFABNotificationBar.h"

@implementation singleViewControllerWithBottomToolBar

@synthesize toolbar;

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
    [toolbar release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,
                                                          self.view.frame.size.height - 44.0,
                                                          self.view.frame.size.width,
                                                          44.0)];
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithTitle:@"Test" style:UIBarButtonItemStyleBordered target:self action:nil];
    
    [toolbar setItems:[NSArray arrayWithObject:item1]];
    [self.view addSubview:toolbar];
    [item1 release];
    
    // Let's add an observer to be notified when the SDK is initialized
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(appboosterIsInitialized) name:@"AFSDKisInitialized" object:nil];
}

- (void)appboosterIsInitialized {
    /*
     TO ADD THE NOTIFICATION BAR, include the header file and allocate it here. By default, the bar will position on the lower part of the current view's frame. You can override this by changing the frame after allocating or modifying the code directly.
     */
    
    AFABNotificationBar *bar = [[AFABNotificationBar alloc] initWithFrameContainingBottomToolbar:self.view.bounds];
    [bar setShowWhenCountIsZero:YES];
    [self.view addSubview:bar];
    [bar release];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
