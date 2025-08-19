//
//  AppDelegate.m
//  OCTemp
//
//  Created by jingwei on 2025/5/27.
//

#import "AppDelegate.h"
#import "ViewController.h"
#import "WJRouter.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
+ (void)load {
    NSLog(@"%s", __func__);
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [WJRouter registerRouterWithAppDelegate:self];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[UINavigationController alloc] initWithRootViewController:[[ViewController alloc] init]];
    [self.window makeKeyAndVisible];
    return YES;
}

@end
