#pragma once

/**
 NSString 

 Your application's display name. Used as the game title (welcome screen, tournament selector, etc.).

 @note This field will override the display name value from the developer dashboard.
*/
extern NSString* NextpeerSettingDisplayName;

/**
 NSNumber UIInterfaceOrientation

 Default: UIInterfaceOrientationPortrait

 Defines what orientation the game notification should appear. The notification system does not auto rotate.
 */
extern NSString* NextpeerSettingNotificationOrientation;


/**
 NSNumber BOOL

 Default: FALSE

 Defines if Nextpeer should observe notification orientation change and adjust the in-game notifications according to changes.
 For example, if your game supports Landcape orientation, Default UIInterfaceOrientationLandscapeRight, you can verify that even if the user will 
 change the orientation (in-game) to UIInterfaceOrientationLandscapeLeft the notification orientation will adjust it self.
 */
extern NSString* NextpeerSettingObserveNotificationOrientationChange;

/**
 NSNumber ::NPNotificationPosition. See NextpeerPublic.h.

 Default: ::NPNotificationPosition_TOP.

 Behavior:
 
     iPhone + iPad:
	 NPNotificationPosition_TOP              notifications show up on the top of the screen
	 NPNotificationPosition_BOTTOM           notifications show up on the bottom of the screen
	
	 iPad:
	 NPNotificationPosition_BOTTOM_LEFT      iPad notifications show up on the lower left corner of the screen
	 NPNotificationPosition_TOP_LEFT         iPad notifications show up on the top left corner of the screen
	 NPNotificationPosition_BOTTOM_RIGHT     iPad notifications show up  on the bottom right corner of the screen
	 NPNotificationPosition_TOP_RIGHT        iPad notifications show up on the top right of the screen
 */
extern NSString* NextpeerSettingNotificationPosition;

/**
 NSNumber BOOL

 Default: YES

 Behavior: Specifies if the game supports retina mode (iOS4+). This affects generated images that come
           from the NPNotificationContainer. If set to True, the generated images will be sized according to the
           device compatibility (retina devices receiving larger images).
 */
extern NSString* NextpeerSettingGameSupportsRetina;

/**
 NSNumber BOOL

 Default: NO

 Defines if Nextpeer should observe device orientation change and adjust the dashboard according to changes.
 Nextpeer will keep the transformation in the main orientation. For example if you game supports landscape orientation, Nextpeer will switch between LandscapeLeft to LandscapeRight (but will not switch to portrait).
 */
extern NSString* NextpeerSettingSupportsDashboardRotation;

/**
 NSNumber UIInterfaceOrientation
 
 Default: [UIApplication sharedApplication].statusBarOrientation
 
 Defines the orientation in which the Nextpeer dashboard will be first launched. If not specified, Nextpeer will try to orient itself according to the status bar orientation.
 */
extern NSString* NextpeerSettingInitialDashboardOrientation;
