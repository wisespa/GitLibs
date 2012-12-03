//
//  MMInterstitial.h
//  MMSDK
//
//  Created by Nolan Brown on 3/23/12.
//  Copyright (c) 2012 Millennial Media Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MMRequest.h"

@interface MMInterstitial : NSObject

// Fetch an interstitial for a given APID
+ (void)fetchWithRequest:(MMRequest *)request
                    apid:(NSString *)apid
            onCompletion:(void (^)(BOOL success, NSError *error))callback;

// Check if an ad is available for a given APID
+ (BOOL)isAdAvailableForApid:(NSString *)apid;

// Display an interstitial for a given APID. ViewController is required.
+ (void)displayForApid:(NSString *)apid
    fromViewController:(UIViewController *)viewController
       withOrientation:(UIInterfaceOrientation)overlayOrientation
          onCompletion:(void (^)(BOOL success, NSError *error))callback;

@end
