//
//  ViewController1.m
//  OCTemp
//
//  Created by jingwei on 2025/5/28.
//

#import "ViewController1.h"
#import "WJRouter.h"

@interface ViewController1 ()<WJRouterProtocol>

@end

@implementation ViewController1

//+ (void)initialize {
//    NSLog(@"%s", __func__);
//}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [WJRouter openWithName:@"Main" parameters:@{@"a": @"1"} object:UIColor.redColor];
}



+ (UIViewController *)createWithParameters:(NSDictionary *)parameters object:(id)object { 
    ViewController1 *vc = ViewController1.new;
    if ([object isKindOfClass:[UIColor class]]) {
        vc.view.backgroundColor = object;
    }
    return vc;
}

+ (NSString *)pageName { 
    return @"Setting";
}

+(WJRouterAnimation)animation {
    return present;
}

@end
