// Copyright (C) 2011-2012 by Tapjoy Inc.
//
// This file is part of the Tapjoy SDK.
//
// By using the Tapjoy SDK in your software, you agree to the terms of the Tapjoy SDK License Agreement.
//
// The Tapjoy SDK is bound by the Tapjoy SDK License Agreement and can be found here: https://www.tapjoy.com/sdk/license



#define TJC_CONNECT_SUCCESS				@"TJC_Connect_Success"
#define TJC_CONNECT_FAILED				@"TJC_Connect_Failed"
#define TJC_CONNECT_SDK
#define TJC_SDK_TYPE_VALUE				@"connect"


// The keys for the options dictionary when calling requestTapjoyConnect.
#define TJC_OPTION_USER_ID						@"TJC_OPTION_USER_ID"
#define TJC_OPTION_ENABLE_LOGGING				@"TJC_OPTION_ENABLE_LOGGING"
#define TJC_OPTION_COLLECT_MAC_ADDRESS			@"TJC_OPTION_COLLECT_MAC_ADDRESS"


/*!	\enum TJCMacAddressOption
 *	\brief Settings for collection of MAC address. Use this with the TJC_OPTION_COLLECT_MAC_ADDRESS option.
 */
typedef enum TJCMacAddressOption
{
	TJCMacAddressOptionOn = 0,				/*!< Enables collection of MAC address. */
	TJCMacAddressOptionOffWithVersionCheck,	/*!< Disables collection of MAC address for iOS versions 6.0 and above. */
	TJCMacAddressOptionOff					/*!< Completely disables collection of MAC address. THIS WILL EFFECTIVELY DISABLE THE SDK FOR IOS VERSIONS BELOW 6.0! */
} TJCMacAddressOption;