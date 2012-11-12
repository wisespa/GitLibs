================================================================================  

   README AppBooster SDK Notification Bubble
   --
   Created by Arnaud Mesureur on Wed Jul  4 15:02:45 2012
   contact: support@appsfire.com
   	    arnaud@appsfire.com

   company: Appsfire
   website: appsfire.com
   	    appsfire.com/appbooster
  
================================================================================


Description :
-------------

The AFNotificationItem is a light subclass of UIView that provides an *easy* way to
display your AppBooster notifications number on the navigation bar.

You have the possibility to add an UIView (with your app's logo for example)
to the left of the notification button.

Requirements :
--------------

- go to http://appsfire.com/index.php/dev/sdk/docs
- IMPORTANT : Download the AppBooster SDK for iOS by Appsfire. These sample files do NOT come with the libAppsfireSDK.a file that is necessary to run and compile. You must 
- Download and read the documentation for the AppBooster SDK for iOS
- You will need to copy the libAppsfireSDK.a file into the sample apps projects in order for these to compile & run


Notification bubble files :
---------------------------

In "AFNotificationBubble" folder :

- AFNotificationItem.h	-- The navigation bar notification item class interface
- AFNotificationItem.m	-- The navigation bar notification item class implementation

- AFBubbleButton.m	-- The bubble button subclass of UIButton class implementation
- AFBubbleButton.h	-- The bubble button subclass of UIButton class interface

- Resources folder	-- The folder containing all default assets for the bubble
			   (you can use your own resources instead)

In "AFNotificationBubble-ARC" folder :

- idem with class using ARC (Automatic Reference Counting)


Sample Applications :
---------------------

You can check how to use the notification bubble item in the sample applications
that come in with the files.

- "AFSample" directory contains a small project that shows how to use the
  "AFNotificationItem" class without using ARC
- "AFSample-ARC" directory contains the same project using ARC


Getting Started :
-----------------

I- Setting up the project

NB : IF YOU USE ARC (Automatic Reference Counting) in your project, follow these
     instructions with "AFNotificationBubble-ARC" folder instead of 
     "AFNotificationBubble".


1- Drag and drop the "AFNotificationBubble" folder in your xcode Project Navigator 
  OR
  right-click on your project in the Project Navigator and select "Add files to"
  then select the "AFNotificationBubble" folder.

2- if prompted select "copy items into destination group's folder" option.

3- click "finish".

You're done with the setup ! Now the easy part, let's code...

II- The line of code
--------------------

Prerequisites :

This tutorial is assuming you use a UINavigationController as the base of your
others UIViewController and that you have a visible UINavigationBar on top of
your current UIViewController.

All the code should be placed after initializing your UINavigationController.
This code could be place for example in the viewDidLoad of the UIViewController
where you want to display the notification bubble.


1- Add this import on top of your implementation file

	#import "AFNotificationItem.h"

2- Instantiate a new AFNotificationItem (with OR without additional UIView)

	AFNotificationItem *item = [[AFNotificationItem alloc] init];

OR

	// replace IMG_NAME by the name of the image you want to add next to the notification button
	UIImage	   		*image = [UIImage imageNamed:@"IMG_NAME"];
	UIImageView		*imageView = [[UIImageView alloc] initWithImage:image];
	AFNotificationItem	*item = [[AFNotificationItem alloc] initWithTitleView:titleView];

3- Add the item to the UIViewController of your choice

	// example in UIViewController viewDidLoad method
	[item addToNavigationBarInViewController:self style:AFNotificationItemStyleLeft];


Note: 'style' parameter has three possible values:
   	   - AFNotificationItemStyleLeft
	   - AFNotificationItemStyleRight
	   - AFNotificationItemStyleMiddle
   
4- If you are NOT using ARC, don't forget to release the item

	[item release];


That's it you're done !


III- Customization
------------------

To change the look of the bubble you can replace the files in the "AFNotificationBubble/Resources" folder
by your own files with the same name.

OR

You can open "AFBubbleButton.h" and change the define values with the name of your own files

"kAFNotificationBubbleImageDisabled" defines the image file for the 0 notifications state
"kAFNotificationBubbleImageEnabled" defines the image file for the active notifications state


--

Thanks for using AppBooster !

For any bug report or related questions about AppBooster, please see contact information on top
of this readme file.
