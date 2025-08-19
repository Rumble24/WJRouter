//
//  WJRouter.m
//  OCTemp
//
//  Created by jingwei on 2025/6/12.
//

#import "WJRouter.h"
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

static NSMutableDictionary<NSString*, NSString*> *routerMap = nil;

@implementation WJRouter

// 还可以做缓存
+ (void)registerRouterWithAppDelegate:(id<UIApplicationDelegate>)applicationDelegate {
    if (routerMap != nil) return;
    routerMap = @{}.mutableCopy;
    
    const char *appImage = class_getImageName(self.class);
    unsigned int count = 0;
    const char **classes = objc_copyClassNamesForImage(appImage, &count);
    
    for (unsigned int index = 0; index < count; index++) {
        NSString *className = [NSString stringWithCString:classes[index] encoding:NSUTF8StringEncoding];
        Class class = NSClassFromString(className);
        if ([class conformsToProtocol:@protocol(WJRouterProtocol)] && [class respondsToSelector:@selector(pageName)]) {
            NSString *pageName = [class performSelector:@selector(pageName)];
            routerMap[pageName] = className;
        }
        NSLog(@"className %@", className);
    }
    free(classes);
}

+ (void)openWithName:(NSString *)name parameters:(NSDictionary *)parameters object:(id)object {

    @try {
        Class cls = NSClassFromString(routerMap[name]);
        // 1. 检查类是否遵循协议
        if (![cls conformsToProtocol:@protocol(WJRouterProtocol)]) {
            NSLog(@"❌ %@ 不遵循 WJRouterProtocol", NSStringFromClass(cls));
            return;
        }
        NSString *pageName = [cls performSelector:@selector(pageName)];
        NSLog(@"✅ pageName %@", pageName);
        
        UIViewController *vc = [cls performSelector:@selector(createWithParameters:object:) withObject:parameters withObject:object];
        UIViewController *nav = [WJRouter df_getCurrentVC];
        if ([nav isKindOfClass:[UINavigationController class]]) {
            [((UINavigationController *)nav) pushViewController:vc animated:YES];
        }
    }
    @catch (NSException *exception) {
        NSLog(@"❌ 调用 %@ 的 pageName 时发生异常: %@", name, exception);
    }
}

+(UIViewController *)df_getCurrentVC {
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
}

@end
