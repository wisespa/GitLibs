//
//  CacheExampleViewController.h
//  MMSampleApp
//
//
//  Copyright (c) 2010-2012 Millennial Media. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MMAdView.h"

@interface CacheExampleViewController : UIViewController <MMAdDelegate> {
    MMAdView *cacheAdView_;
    UILabel *statusLabel_;
}

@property (nonatomic, retain) IBOutlet UILabel *statusLabel;

- (IBAction)fetch:(id)sender;
- (IBAction)check:(id)sender;
- (IBAction)display:(id)sender;

@end
