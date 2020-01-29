//
//  ViewController.h
//  SupportSDKDemo
//
//  Created by Larry Borsato on 2019-09-17.
//  Copyright © 2019 Boomtown. All rights reserved.
//

@import UIKit;
@import SupportSDK;

@interface ViewController : UIViewController

@property (strong, nonatomic, nullable) SupportButton       *supportButton;
@property (strong, nonatomic, nullable) SupportSDKProactive *proactiveAgent;

@end

