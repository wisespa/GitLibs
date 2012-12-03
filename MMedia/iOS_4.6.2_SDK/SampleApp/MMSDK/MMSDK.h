//
//  MMSDK.h
//  MMSDK
//
//  Created by Nolan Brown on 3/23/12.
//  Copyright (c) 2012 Millennial Media Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

// NSNotification keys
static NSString *const MillennialMediaAdWillTerminateApplication = @"MillennialMediaAdWillTerminateApplication";
static NSString *const MillennialMediaAdWasTapped = @"MillennialMediaAdWasTapped";
static NSString *const MillennialMediaAdModalWillAppear = @"MillennialMediaAdModalWillAppear";
static NSString *const MillennialMediaAdModalDidAppear = @"MillennialMediaAdModalDidAppear";
static NSString *const MillennialMediaAdModalWillDismiss = @"MillennialMediaAdModalWillDismiss";
static NSString *const MillennialMediaAdModalDidDismiss = @"MillennialMediaAdModalDidDismiss";

typedef enum ErrorCode {
    MMAdUnkownError = 0,
    MMAdServerError = -500,
    MMAdUnavailable = -503,
    MMAdDisabled    = -9999999
} MMErrorCode;

typedef enum LogLevel {
    MMLOG_LEVEL_OFF   = 0,
    MMLOG_LEVEL_INFO  = 1 << 0,
    MMLOG_LEVEL_DEBUG = 1 << 1,
    MMLOG_LEVEL_ERROR = 1 << 2,
    MMLOG_LEVEL_FATAL = 1 << 3
} MMLogLevel;

@interface MMSDK : NSObject

+ (NSString *)version;
+ (void)trackConversionWithGoalId:(NSString *)goalid;
+ (void)setLogLevel:(MMLogLevel)level;

@end
