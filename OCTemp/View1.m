//
//  View1.m
//  OCTemp
//
//  Created by jingwei on 2025/5/28.
//

#import "View1.h"
#import <objc/runtime.h>

@implementation View1

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    Method method = class_getInstanceMethod([self class], @selector(addDynamicInstanceMethod:));
    IMP methodIMP = method_getImplementation(method);
    const char * types = method_getTypeEncoding(method);
    class_addMethod([self class], sel, methodIMP, types);
    return YES;
}

-(void)addDynamicInstanceMethod:(NSString *)value {
    NSLog(@"addDynamicInstanceMethod value = %@",value);
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [super touchesBegan:touches withEvent:event];
//    NSLog(@"%s", __func__);
//
//}

//- (void)viewDidLoad {
//    [super viewDidLoad];
//    
//    // 创建签名对象
//    NSMethodSignature *methodSignature = [ViewController instanceMethodSignatureForSelector:@selector(sendMessageWithArgument1:argument2:)];
//    // 创建 NSInvocation 对象
//    NSInvocation *objInvocation = [NSInvocation invocationWithMethodSignature:methodSignature];
//
//    // 指定 target 对象
//    objInvocation.target = self;
//    // 执行的方法
//    objInvocation.selector = @selector(sendMessageWithArgument1:argument2:);
//
//    // 给执行的方法设置参数
//    NSString *argument1 = @"11111";
//    NSString *argument2 = @"22222";
//    [objInvocation setArgument:&argument1 atIndex:2];
//    [objInvocation setArgument:&argument2 atIndex:3];
//
//    // 执行方法
//    [objInvocation invoke];
//    
//    // 获取返回值
//    NSString *result = nil;
//    [objInvocation getReturnValue:&result];
//    NSLog(@"The Result is : %@", result);
//}


- (NSString *)sendMessageWithArgument1:(NSString *)argument1 argument2:(NSString *)argument2 {
    NSLog(@"参数1:%@, 参数2:%@", argument1, argument2);
    
    return @"返回结果";
}
@end
