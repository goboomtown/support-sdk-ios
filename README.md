# Boomtown Product Support Platform SDK for iOS

#### Minimum Requirements
- Xcode 11
- iOS 11.0

#### Dependencies
-	AFNetworking 4.0
-	XMPPFramework 4.0
-	SVProgressHUD
- TwilioVideo 4.4.0
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
  "apiHost": "https://api.goboomtown.com",
  "integrationId": "xxxxxxx",
  "apiKey": "xxxxxxxxxxxxxxxxxxxxxxxxxx",
  "buttonURL":"https://api.goboomtown.com/resources/images/sdk_button.png",
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

## Server Configuration

**SupportSDK** requires you specify the obtain the server configuration JSON file provided by the mobile configurator. The downloaded configuration file will look like this:

```
{
  "apiHost": "https://api.goboomtown.com",
  "integrationId": "xxxxxx",
  "apiKey": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
  "buttonURL":"https://api.goboomtown.com/resources/images/sdk_button.png",
  "partnerToken": "xxxxxxxx",
  "privateKey": "xxxxxxxxxxxxxxxxxxxxx"
}
```

This file enables communication with the server and configures the available features.

## Menu Style

The menu style is configured in the menuAppearance section of the appearance JSON like this:

```
"menuAppearance":
{
  "style": "iconlist",
...
}

```
The style value may be one of the following:

```
"nomenu"
"menu"
"button"
"iconlist"
"iconlistexit"
```

If no value is set the default is iconlist.


## Customer Configuration

If desired, the customer may be identified by providing values for any of the following keys"

```
CustomerId : "members_id",
CustomerExternalId: "members_external_id",
CustomerLocationId: "members_locations_id",
CustomerLocationExternalId: "members_locations_external_id",
CustomerLocationMid: "members_locations_mid",
UserId: "members_users_id",
UserExternalId: "members_users_external_id",
UserEmail: "members_users_email",
UserPhone: "members_users_phone",
```

like this:

```
var customerJSON = {
  "members_users_email": "email@example.com"
};
```

## Appearance Configuration

Much of the application (menus, icons, and colors currently) can be configured using a JSON file as follows:

This is the default JSON.

```
{
  "navigationBarAppearance":
  {
    "textColor": "#000000",
    "backgroundColor": "#ffffff",
    "iconColor": "#000000"
  },
  "menuAppearance":
  {
    "style": "iconlist",
    "heading": "Support",
    "textSize": "20",
    "textStyle": "bold",
    "borderWidth": "1",
    "padding": "10",
    "spacing": "20",
    "textColor": "#000000",
    "iconColor": "#EF5E0D",
    "borderColor": "#E0E0E0",
    "textColorDark": "#ffffff",
    "iconColorDark": "#EF5E0D",
    "borderColorDark": "#E0E0E0"
  },
  "menu":
  {
    "chat": {
      "text": "Chat with Us",
      "icon": "a_chat"
    },
    "callme":
    {
      "text": "Call Me",
      "icon": "phone_call"
    },
    "knowledge":
    {
      "text": "Search Knowledge",
      "icon": "book_bookmark"
    },
    "web":
    {
      "text": "Web Support",
      "icon": "globe"
    },
    "email":
    {
      "text": "Email Support",
      "icon": "letter"
    },
    "phone":
    {
      "text": "Phone Support",
      "icon": "phone"
    },
    "forms":
    {
      "text": "Forms",
      "icon": "form"
    },
    "history":
    {
      "text": "History",
      "icon": "customer_alt"
    },
    "exit":
    {
      "text": "Exit"
    }
  },
  "icons":
  {
    "kbFolderIcon": "book-bookmark",
    "chatAttachmentButtonImage": "paperclip.png",
    "chatSendButtonImage": "send.png"
  },
  "colors":
  {
    "navigationBarColor": "#f2f2f2",
    "iconColor": "#EF5E0D",
    "buttonColor": "#EF5E0D",
    "lineColor": "#E0E0E0",
    "textColor": "#4F4F4F",
    "textColorDark": "#ffffff",
    "homeIconColor": "#EF5E0D",
    "homeLineColor": "#E0E0E0",
    "homeTextColor": "#007AFF",
    "homeSelectedColor": "#EBEBEB",
    "callMeHeaderTextColor": "#4F4F4F",
    "callMeLabelTextColor": "#626363",
    "callMeHintTextColor": "#ACACAC",
    "callMeButtonTextColor": "#ACACAC",
    "callMeButtonBackgroundColor": "#1AA8A8",
    "ratingHeaderTextColor": "#4F4F4F",
    "ratingLabelTextColor": "#626363",
    "ratingHintTextColor": "#ACACAC",
    "ratingButtonTextColor": "#ACACAC",
    "ratingButtonBackgroundColor": "#1AA8A8",
    "chatRefidTextColor": "#4f4f4f",
    "chatNavBarColor": "#f2f2f2",
    "chatSendButtonEnabledColor": "#626363",
    "chatSendButtonDisabledColor": "#ACACAC",
    "chatTimeStampColor": "#ACACAC",
    "chatActionButtonTextColor": "#838383",
    "chatActionButtonSelectedTextColor": "#ffffff",
    "chatActionButtonBorderColor": "#E0E0E0",
    "chatIconColor": "#838383",
    "kbFolderNameTextColor": "#303030",
    "kbFolderL0BackgroundColor": "#F3F8F8",
    "kbTextColor": "#303030",
    "menuBorderColor": "#E0E0E0"
  },
  "formAppearance":
  {
    "cancelButtonText": "Cancel",
    "saveButtonText": "Save",
    "label":
    {
      "textStyle": "bold",
      "textSize": "20",
      "textColor": "#000000",
      "textColorDark": "#ffffff",
      "requiredTextColor": "#000000",
      "requiredTextColorDark": "#ffffff",
      "requiredIndicatorColor": "#cc0000",
      "requiredIndicatorColorDark": "#cc0000"
    },
    "entry":
    {
      "textStyle": "bold",
      "textSize": "20",
      "textColor": "#000000",
      "textColorDark": "#ffffff",
      "borderColor": "#000000",
      "borderColorDark": "#ffffff",
      "borderWidth": "1"
    }
  }
}
```

If you only want to configure a general color scheme you need only set the following colors:

```
iconColor
buttonColor
lineColor
textColor
textColorDark
```

## Acknowledgements

**SupportSDK** makes use of various open source libraries, and we are grateful for the contributions of the open source community.

To help you acknowledge the open source libraries we have used, we have included two files in the root of the repository:

- `Acknowledgements.md` is a Markdown file for you to use however makes sense for you.
- `Acknowledgements.plist` is an Apple PLIST file designed for use in a Settings bundle.
