//
//  NSObject+Swizzling.h
//  SafeObjectCrash
//
//  Created by lijien on 2024/1/24.
//  Copyright © 2024年 lijien. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Swizzling)
+ (void)exchangeInstanceMethodWithSelfClass:(Class)selfClass
                           originalSelector:(SEL)originalSelector
                           swizzledSelector:(SEL)swizzledSelector;
@end
