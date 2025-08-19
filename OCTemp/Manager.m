//
//  Manager.m
//  OCTemp
//
//  Created by jingwei on 2025/5/28.
//

#import "Manager.h"

static Manager *_instance;

@implementation Manager

+ (instancetype)shareInstance {
    if (!_instance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _instance = [[self alloc]init];
        });
    }
    return _instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    if (!_instance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _instance = [super allocWithZone:zone];
        });
    }
    return _instance;
}

@end
