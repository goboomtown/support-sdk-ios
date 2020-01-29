# Boomtown Support SDK for iOS (v 1.0.0)

#### Minimum Requirements
- Xcode 10.2
- iOS 9.0

#### Dependencies
-	AFNetworking 3.0
-	XMPPFramework 4.0
-	SVProgressHUD
- TwilioVideo 2.8.1
-	iOS-Color-Picker
- MTBBarcodeScanner


A Podfile is included in case you want to use CocoaPods. If so, Support SDK will include these dependencies. The Support SDK CocoaPod can be found at https://cocoapods.org/pods/SupportSDK.

## Overview
**SupportSDK** contains `SupportSDK`, an iOS framework for Boomtown partners. It allows partners to integrate issue creation, notification, and chat in a single `SupportButton` button.

## Getting Started

1. Clone this repository
2. Drag `SupportSDK.framework` from the SDK folder into the `Embedded Binaries` section in `Targets->General`
3. In the "Choose options for adding these files" dialog, ensure "Copy items if needed" is checked and "Create Groups" is selected next to "Added folders"

## Obtaining Configuration Information
For chat to work, **SupportSDK** requires you specify the obtain the configuration JSON file provided by the mobile configurator within Relay. The downloaded configuration file will look like this:

```
{
  "apiHost": "https://api.thinkrelay.com",
  "integrationId": "xxxxxxx",
  "apiKey": "xxxxxxxxxxxxxxxxxxxxxxxxxx",
  "buttonURL":"https://api.thinkrelay.com/resources/images/sdk_button.png",
  "partnerToken": "xxxxxxxxxxxxx",
  "privateKey": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
}

```
The downloaded configuration file may be renamed if desired and should be dragged into your Xcode project. The loadConfigurationFile() method will load this file by name.

## Usage

_Note:_ Objective-C and Swift examples may be found in the `SupportSDK/Examples` folder of this repository

### Objective-C
```Objective-C

@import SupportSDK;

//	Create BTConnectHelp button and add it to view
SupportButton *supportButton = [[SupportButton alloc] initWithFrame:self.view.frame];
supportButton.delegate = self;
if ( ![supportButton loadConfigurationFile:@"support_sdk.json" customerId:nil] ) {
		NSLog(@"Unable to load configuration file");
}
[self.view addSubview:supportButton];

```

### Swift
```Swift

import SupportSDK

let button = SupportButton(frame: self.subview.frame)
button.delegate = self;
if button.loadConfigurationFile("support_sdk.json", customerId:nil) == false  {
		NSLog("Unable to load configuration file")
}
self.view.addSubview(button)

```

## Acknowledgements

**SupportSDK** makes use of various open source libraries, and we are grateful for the contributions of the open source community.

To help you acknowledge the open source libraries we have used, we have included two files in the root of the repository:

- `Acknowledgements.md` is a Markdown file for you to use however makes sense for you.
- `Acknowledgements.plist` is an Apple PLIST file designed for use in a Settings bundle.
