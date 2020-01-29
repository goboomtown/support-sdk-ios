//
//  ViewController.m
//  SupportSDKDemo  
//
//  Created by Larry Borsato on 2019-09-17.
//  Copyright © 2019 Boomtown. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <SupportButtonDelegate>

@property   NSString    *configFileName;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Support SDK Demo";
    
#ifdef STAGE
    self.configFileName = @"support_sdk_preprod.json";
#else
    self.configFileName = @"support_sdk.json";
#endif
    
    CGFloat buttonSize = 75;
    CGRect buttonFrame = CGRectMake((self.view.frame.size.width-buttonSize)/2,
                                    (self.view.frame.size.height-buttonSize)/2,
                                    buttonSize,
                                    buttonSize);
	self.supportButton = [[SupportButton alloc] initWithFrame:buttonFrame];
	self.supportButton.delegate = self;
//    if ( ![self.supportButton loadConfigurationFile:self.configFileName customerId:nil] ) {
//        NSLog(@"Unable to load configuration file");
//    }
    [self.view addSubview:self.supportButton];
    
    [self.supportButton advertiseServiceWithPublicData:@{@"test":@"data"}
                                           privateData:@{@"test":@"private data"}];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.proactiveAgent = [[SupportSDKProactive alloc] initWithConfigurationFile:self.configFileName customerId:nil];
    [self.proactiveAgent putAppHealthCheck:@"app-running"   checkStatus:OK          checkStatusDetail:@""];
    [self.proactiveAgent putAppHardwareCheck:@"cc-scanner"  checkStatus:CRITICAL    checkStatusDetail:@"device offline"];
    [self.proactiveAgent putAppCloudCheck:@"merchant-ep"    checkStatus:WARNING     checkStatusDetail:@"HTTP status code 401"];
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"testfile" ofType:nil];
    NSFileHandle *file = [NSFileHandle fileHandleForReadingAtPath:filePath];
    [self.proactiveAgent putAppDumpCheckWithFile:file checkStatus:OK checkStatusDetail:@""];
    
    [self promptForCustomerInformation];
}


- (void) promptForCustomerInformation
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"Login with Email Address", nil)
                                                                    message:NSLocalizedString(@"This is optional. Just hit cancel if you wish.", nil)
                                                             preferredStyle:UIAlertControllerStyleAlert];

    UIAlertAction *login = [UIAlertAction actionWithTitle:NSLocalizedString(@"Login", nil)
                                                    style:UIAlertActionStyleDefault
                                                   handler:^(UIAlertAction * action) {

                                                       if (alert.textFields.count > 0) {
                                                           UITextField *textField = [alert.textFields firstObject];
                                                           if ( ![self.supportButton loadConfigurationFile:self.configFileName customerId:textField.text] ) {
                                                               NSLog(@"Unable to load configuration file");
                                                           }
                                                       }
                                                   }];

    [alert addAction:login];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil)
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction * _Nonnull action) {
        if ( ![self.supportButton loadConfigurationFile:self.configFileName customerId:nil] ) {
            NSLog(@"Unable to load configuration file");
        }
    }];
                                                                                             [alert addAction:cancelAction];

    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = NSLocalizedString(@"Enter email address", nil); // if needs
    }];

    [self presentViewController:alert animated:YES completion:nil];
}



#pragma mark - Help button delegates

- (void) supportButton:(SupportButton *)supportButton didAdvertiseService:(NSNetService *)netService
{
    NSLog(@"mDNS service successfully advertised.");
}


- (void) supportButton:(SupportButton *)supportButton didFailToAdvertiseService:(NSDictionary<NSString *,NSNumber *> *)errorDict
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
    UIAlertController *alertController = [UIAlertController
                                          alertControllerWithTitle:error.localizedDescription
                                          message:error.localizedFailureReason
                                          preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", @"OK action")
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction *action)
                               {
                               }];
    [alertController addAction:okAction];
    [self.navigationController presentViewController:alertController animated:YES completion:nil];
}

@end
