//
//  BannerExampleViewController.h
//  MMSampleApp
//
//
//  Copyright (c) 2010-2012 Millennial Media. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "MMAdView.h"

@interface BannerExampleViewController : UIViewController <MMAdDelegate> {
    MMAdView *bannerAdView_;
    UILabel *statusLabel_;
}

@property (nonatomic, retain) IBOutlet UILabel *statusLabel;

- (IBAction)refresh:(id)sender;

@end
