#import <Foundation/Foundation.h>

@class NPInGameNotification;

@interface NPNotificationContainer : NSObject 

@property (nonatomic, readonly) NSString* notificationText;
@property (nonatomic, readonly) UIImage* renderedImage;

@end
