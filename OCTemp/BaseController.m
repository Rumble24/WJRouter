//
//  BaseController.m
//  OCTemp
//
//  Created by jingwei on 2025/5/28.
//

#import "BaseController.h"

@interface BaseController ()

@end

@implementation BaseController

+ (void)load {
    NSLog(@"%s", __func__);
}

+ (void)initialize {
    if (self == [BaseController class]) {
        NSLog(@"%s", __func__);
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
}



@end
