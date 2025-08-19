//
//  ViewController+a.m
//  OCTemp
//
//  Created by jingwei on 2025/5/27.
//

#import "ViewController+a.h"
#import "NSObject+Swizzling.h"

@implementation ViewController (a)
+ (void)load {
    NSLog(@"%s", __func__);
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSObject exchangeInstanceMethodWithSelfClass:self originalSelector:@selector(viewDidL) swizzledSelector:@selector(swizzled_viewDidLoad)];
    });
}
- (void)swizzled_viewDidLoad {
    [self swizzled_viewDidLoad];
    NSLog(@"%s", __func__);
}

- (void)test {
    NSLog(@"ViewController+a.h");
}
@end
