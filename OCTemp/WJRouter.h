//
//  WJRouter.h
//  OCTemp
//
//  Created by jingwei on 2025/6/12.
//

#import <Foundation/Foundation.h>
#import "WJRouterProtocol.h"
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WJRouter : NSObject

+ (void)registerRouterWithAppDelegate:(id<UIApplicationDelegate>)applicationDelegate;

+ (void)openWithName:(NSString *)name parameters:(NSDictionary *)parameters object:(id)object;

@end

NS_ASSUME_NONNULL_END
