//
//  SessionManager.h
//  SupportSDK
//
//  Created by Larry Borsato on 2019-10-30.
//  Copyright © 2019 Boomtown. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BTSessionManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface SessionManager : BTSessionManager

- (void) startWithId:(NSString *)commId;

@end

NS_ASSUME_NONNULL_END
