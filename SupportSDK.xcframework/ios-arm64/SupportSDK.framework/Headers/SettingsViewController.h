//
//  SettingsViewController.h
//  SupportSDK
//
//  Created by Larry Borsato on 2021-06-25.
//  Copyright © 2021 Boomtown. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BarcodeViewController;
@protocol BarcodeViewControllerDelegate;

NS_ASSUME_NONNULL_BEGIN

@interface SettingsViewController : UITableViewController <UITableViewDelegate, BarcodeViewControllerDelegate>

@end

NS_ASSUME_NONNULL_END
