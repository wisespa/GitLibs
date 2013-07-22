/**
 Defines where notifications can appear on the screen.
 */
typedef enum NPNotificationPosition
{
    ///@{
    /// For iPhone + iPad
	NPNotificationPosition_TOP = 0, ///< Default notification position
	NPNotificationPosition_BOTTOM,
    ///@}
    
    ///@{
    /// For iPad only
	NPNotificationPosition_TOP_LEFT,
	NPNotificationPosition_BOTTOM_LEFT,
	NPNotificationPosition_TOP_RIGHT,
	NPNotificationPosition_BOTTOM_RIGHT,
	NPNotificationPosition_COUNT,
    ///@}
} NPNotificationPosition;

typedef void(^NPPostLaunchAction)(void);

@interface Nextpeer : NSObject

/**
 @return The release Version String of the Nextpeer client library in use.
 */
+ (NSString*)releaseVersionString;

/**
 @param productKey This is your unique product key you received when registering your application. Is copied.
 @param delegatesContainer The delegates container is retained but none of the delegates in the container are retained.
 */
+ (void)initializeWithProductKey:(NSString*)productKey
                    andDelegates:(NPDelegatesContainer*)delegatesContainer;

/**
 @param productKey This is your unique product key you received when registering your application. Is copied.
 @param settings The available settings are defined as NextpeerSettingXXXXXXXXXXXX. See NextpeerSettings.h.
 @param delegatesContainer The delegates container is retained but none of the delegates in the container are retained.
 */
+ (void)initializeWithProductKey:(NSString*)productKey
                     andSettings:(NSDictionary*)settings
                    andDelegates:(NPDelegatesContainer*)delegatesContainer;

/**
 Launches the Nextpeer Dashboard view at the top of your application's keyed window.
 
 @note If Nextpeer::isNextpeerSupported returns NO this method will not execute.
 If the player has not yet authorized your app, they will be prompted to setup an
 account or authorize your application before accessing the Nextpeer dashboard.
 */
+ (void)launchDashboard;

/**
 Removes the Nextpeer dashboard from your application's keyed window.
 */
+ (void)dismissDashboard;

/**
 Call this method when you wish to change the notification orientation in run time.
 It's preferable to use the settings dictionary if you wish to set this up at start-time.
 */
+ (void)setNotificationOrientation:(UIInterfaceOrientation)orientation;

/**
 Let the platform handle a url request, this will used when the Facebook App redirects to the app during the SSO process.
 
 @note The SDK may launch the Nextpeer dashboard under some scenarios from this call.
 
 @param url The URL that was passed to the application delegate's handleOpenURL method(s).
 @return YES if the url starts with np[app_id] and the SDK handled the request; NO if the attempt to handle the URL failed (not supported by the platform).
 */
+ (BOOL)handleOpenURL:(NSURL *)url;

/**
 Call this method to verify if the current run time environment supports Nextpeer requirements.
 
 @note Minimum iOS version supported by the SDK is iOS 4.0. You can handle such case by implementing the 
       NextpeerDelegate::nextpeerNotSupportedShouldShowCustomError method (otherwise Nextpeer will display alert).
 
 @return YES if the run time requirements match, NO otherwise.
 */
+ (BOOL)isNextpeerSupported;

/**
 Call this method register this user's device token. This will allow Nextpeer to send invitations to this user
 when he/she is invited to play the current game. Note that this is only relevant if you've followed the push notification
 integration instructions and provided the p12 file for your game.
 
 @example
 - (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken {
 // Updates the device token and registers the token with Nextpeer
 [Nextpeer registerDeviceToken:deviceToken];
 }
 */
+ (void)registerDeviceToken:(NSData*)deviceToken;

/**
 Call this method after the launching of the app. This allows Nextpeer to respond to any push or local notifications
 that may have been received when the app was in the background.
 Note that you will need to call this method after Nextpeer has already been initialized.
 
 @return Returns a boolean value indicating if the notification will be handled by Nextpeer.
 
 @example
 - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
 ...
 [Nextpeer initializeWithProductKey...];
 ...
 [Nextpeer handleLaunchOptions:launchOptions];
 ...
 
 }
 */
+ (BOOL)handleLaunchOptions:(NSDictionary*)launchOptions;

/**
 Call this method after the receiving a remote push notification while the app is running.
 
 @return Returns a boolean value indicating if the notification will be handled by Nextpeer.
 
 @example
 - (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
 ...
 [Nextpeer handleRemoteNotification:userInfo];
 ...
 
 }
 */
+ (BOOL)handleRemoteNotification:(NSDictionary*)userInfo;

/**
 Call this method after the receiving a local push notification while the app is running.
 
 @return Returns a boolean value indicating if the notification will be handled by Nextpeer.
 
 @example
 - (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
 ...
 [Nextpeer handleLocalNotification:userInfo];
 ...
 
 }
 */
+ (BOOL)handleLocalNotification:(UILocalNotification*)notification;

@end