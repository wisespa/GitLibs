//
//  AFAppBoosterSDK.h
//  AFAppBoosterSDK
//
//  Created by Nicolas Jouannem on 5/1/11.
//  Copyright 2011 Appsfire SAS. All rights reserved.
//

/*
 Copyright 2010-2012 Appsfire SAS. All rights reserved.
 
 Redistribution and use in source and binary forms, without
 modification, are permitted provided that the following conditions are met:
 
 1. Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.
 
 2. Redistributions in binaryform must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation
 and/or other materials provided withthe distribution.
 
 THIS SOFTWARE IS PROVIDED BY APPSFIRE SAS ``AS IS'' AND ANY EXPRESS OR
 IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
 MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
 EVENT SHALL APPSFIRE SAS OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
 INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
 BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF
 LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE
 OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import <Foundation/Foundation.h>

@interface AFAppBoosterSDK : NSObject {}

// Setup the Appsfire SDK with your API key
+ (BOOL)connectWithAPIKey:(NSString *)key;

// Setup the Appsfire SDK with your API key and a custom delay time
+ (BOOL)connectWithAPIKey:(NSString *)key afterDelay:(int)delayTime;

// Returns this device's OpenUDID ( See http://openudid.org for more information)
+ (NSString *)openUDID;

// Gradients to use in the Send Feedback button and for unread messages
+ (void)useGradients:(NSArray *)gradients;

// Use Full Screen layout instead of default overlay
+ (void)useFullScreenStyle;

// Send data to SDK in key/value pairs. Strings matching any of your [KEYS] will be replaced by the respective value you send. (See documentation for example) Do not confuse this with "setDataValue" !
+ (void)useCustomValues:(NSDictionary *)customValues;

// Display the Notifications panel
+ (void)presentNotifications;

// Closes the Notifications panel if it is open
+ (void)closeNotifications;

// Display Feedback Screen
+ (void)presentFeedback;

// v1.0.3 - The following two methods are optional but should you choose to use them, it is only necessary to call one.
// Note that <handleBadgeCountLocallyAndRemotely> overrides any settings established by <handleBadgeCountLocally>
// Handle the Badge count for this app locally (only on the device and only while the app is alive)
+ (void)handleBadgeCountLocally:(BOOL)yesOrNo;

// Handle the Badge count for this app remotely (AppboosterSDK will update the icon at all times, locally and remotely, even when app is closed)
// NOTE : If you set this option to YES, you need to provide us with your Push Certificate. For more information, visit your "Manage Apps" section on http://appsfire.com/appbooster
+ (void)handleBadgeCountLocallyAndRemotely:(BOOL)yesOrNo;

// In cases where you know your app will open and close quickly and should therefore not load the SDK, call this method, ideally in the applicationDidFinishLaunching: procedure of your app.
+ (void)abortInitialization;

// Get SDK version and Build number (for developer purposes only)
+ (NSString *)getAFSDKVersionInfo;

// Returns the number of unread notifications that require attention.
+ (int)numberOfPendingNotifications;

// Tells you if the SDK is initialized or not
+ (BOOL)isInitialized;

// Tells you if the SDK is displayed
+ (BOOL)isDisplayed;

// Resets the SDK's cache completely - all user settings will be erased. This includes messages that have been read, icon images, assets, etc. Do not use lightly! If you're having an issue that only this seems to solve, please contact us immediatley : app-support@appsfire.com
+ (void)resetCache;

// Returns an SDK sessionID
+ (NSString *)getSessionID;

// v1.1 - If you know your user's email, call this function so that we avoid asking the user to enter his or her email when sending feedback. Returns FALSE if email is invalid. If isModifiable is set to FALSE, the user will not be able to modify his/her email in the Feedback form.
+ (BOOL)setUserEmail:(NSString *)email isModifiable:(BOOL)modifiable;

// Register APNS (push token)
+ (void)registerPushToken:(NSData *)deviceToken;

@end