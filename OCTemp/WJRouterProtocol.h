//
//  WJRouterProtocol.h
//  OCTemp
//
//  Created by jingwei on 2025/6/12.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, WJRouterAnimation) {
    push,
    present,
};

@protocol WJRouterProtocol

+ (NSString *)pageName;

+ (UIViewController<WJRouterProtocol> *)createWithParameters:(NSDictionary *)parameters object:(id)object;

@optional
+ (WJRouterAnimation)animation;

@end
