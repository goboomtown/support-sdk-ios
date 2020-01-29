//
//  SupportButton.h
//  SupportSDK
//
//  Created by Larry Borsato on 2019-09-17.
//  Copyright © 2019 Boomtown. All rights reserved.
//

@import UIKit;

@class SupportButton;

extern NSString  *const _Nonnull SupportSDKErrorDomain;

/**
 These methods allow the Support Button to communicate with the delegate calling application
 */
@protocol SupportButtonDelegate <NSObject>

@required

/**
 Called when the issue view controller is ready to be displayed. This will display tracking and chat related to the issue
 */
- (void) supportButton:(nonnull SupportButton *)supportButton  displayIssueViewController:(nonnull UIViewController *)viewController;

/**
 Called when the generated support action sheet is ready to be displayed. This will display the available support options
 */
- (void) supportButton:(nonnull SupportButton *)supportButton  displaySupportMenu:(nonnull UIAlertController *)alertController;

/**
 Called to provide alerts for the user. The message will explain the situation (which is really a failure description)
 */
- (void)supportButton:(nonnull SupportButton *)supportButton didFailWithError:(nonnull NSError *)error;

@optional


- (void) supportButtonDidGetCustomer:(nonnull SupportButton *)supportButton;
- (void) supportButton:(nonnull SupportButton *)supportButton didFailToGetCustomerWithError:(nonnull NSError *)error;

- (void) supportButtonDidGetSettings:(nonnull SupportButton *)supportButton;
- (void) supportButton:(nonnull SupportButton *)supportButton didFailToGetSettingsWithError:(nonnull NSError *)error;

- (void) supportButtonDidCreateIssue:(nonnull SupportButton *)supportButton;
- (void) supportButton:(nonnull SupportButton *)supportButton didFailToCreateIssueWithError:(nonnull NSError *)error;

- (void) supportButtonDidCancelIssue:(nonnull SupportButton *)supportButton;
- (void) supportButton:(nonnull SupportButton *)supportButton didFailToCancelIssueWithError:(nonnull NSError *)error;


/**
 Called when settings were sucessfully retrieved
 */
//- (void)supportButtonDidGetSettings:(nonnull SupportSDKButton *)supportButton;

/**
 Called when settings retrieval fails
 */
- (void)supportButton:(nonnull SupportButton *)supportButton didFailRetrievingSettingsWithError:(nonnull NSError *)error;

/**
 Called when the mDNS service has been successfully advertised
 */
- (void)supportButton:(nonnull SupportButton *)supportButton didAdvertiseService:(nonnull NSNetService *)netService;

/**
 Called when the mDNS service failed to successfully advertise
 */
- (void)supportButton:(nonnull SupportButton *)supportButton didFailToAdvertiseService:(nonnull NSDictionary<NSString *,NSNumber *> *)errorDict;


@end


IB_DESIGNABLE
@interface SupportButton : UIView <NSNetServiceDelegate>

/**
 The delegate for responses
 */
@property (nullable, strong, nonatomic)	id			<SupportButtonDelegate> delegate;


/**
 Load the Support SDK configuration from the provided JSON file

 @param     configFileName      the file name of the configuration file (i.e support_sdk.json)
 @param     customerId          an id (emai, MID, etc) to identify a customer

 @return    YES if configuration was successfully loaded, NO if not
 */
- (BOOL) loadConfigurationFile:(NSString *)configFileName customerId:(NSString *)customerId;

/**
Retrieve and load the desired customer into the Support SDK. This must me done after the settings have been retrieved

@param     customerInformation       a dictionary of possible keys (i.e. customer_email) and values (i.e. an email address)
*/
- (void) getCustomerWithInformation:(NSDictionary *)customerInformation;

/**
 Advertise the Support SDK service via mDNS

 The contents of publicData will be available in the TXT record in clear text. The contents of dataToEncrypt will be available
 as an encrypted string under the key "private".

 @param     publicData      key-value pairs that will be available in the TXT record in clear text
 @param     dataToEncrypt   key-value pairs that will be available in the TXT record as an encrypted string under the "private" key

 @return    YES if mDNS service is created, NO if creation fails
 */
- (BOOL) advertiseServiceWithPublicData:(nullable NSDictionary<NSString*, NSString*> *)publicData
                            privateData:(nullable NSDictionary<NSString*, NSString*> *)privateData;


@end