//
//  ViewController.m
//  SupportSDK-ObjC
//
//  Created by Larry Borsato on 2019-09-17.
//  Copyright © 2019 Boomtown. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <SupportButtonDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Support SDK Demo";
    
    CGFloat buttonSize = 75;
    CGRect buttonFrame = CGRectMake((self.view.frame.size.width-buttonSize)/2,
                                    (self.view.frame.size.height-buttonSize)/2,
                                    buttonSize,
                                    buttonSize);
    SupportButton *supportButton = [[SupportButton alloc] initWithFrame:buttonFrame];
    supportButton.delegate = self;
    if ( ![supportButton loadConfigurationFile:@"CONFIGURATION FILE NAME" customerInfo:nil] ) {
        NSLog(@"Unable to load configuration file");
    }
	[self.view addSubview:supportButton];
    
    [supportButton advertiseServiceWithPublicData:@{@"test":@"data"}
                                           privateData:@{@"test":@"private data"}];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}


#pragma mark - Support button delegates

- (void) supportButton:(nonnull SupportButton *)supportButton didAdvertiseService:(NSNetService *)netService
{
    NSLog(@"mDNS service successfully advertised.");
}


- (void) supportButton:(nonnull SupportButton *)supportButton didFailToAdvertiseService:(NSDictionary<NSString *,NSNumber *> *)errorDict
{
    NSLog(@"mDNS service failed to advertise.");
}


- (void) supportButton:(nonnull SupportButton *)supportButton  displaySupportMenu:(nonnull UIAlertController *)alertController
{
    if ( self.view.traitCollection.horizontalSizeClass != UIUserInterfaceSizeClassCompact )
    {
        [self presentViewController:alertController animated:YES completion:nil];
		UIPopoverPresentationController *popPresenter = [alertController
														 popoverPresentationController];
		popPresenter.sourceView = supportButton;
		popPresenter.sourceRect = supportButton.bounds;
	}
	else
	{
		[self.navigationController presentViewController:alertController animated:YES completion:nil];
	}
}


- (void) supportButton:(nonnull SupportButton *)supportButton displayIssueViewController:(UIViewController *)viewController
{
	[self.navigationController pushViewController:viewController animated:YES];
}


- (void) supportButton:(nonnull SupportButton *)supportButton didFailWithError:(nonnull NSError *)error
{
	NSLog(@"%@: %@", error.localizedDescription, error.localizedFailureReason);
}


@end
