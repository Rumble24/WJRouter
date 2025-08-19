//
//  ViewController+b.m
//  OCTemp
//
//  Created by jingwei on 2025/5/27.
//

#import "ViewController+b.h"
#import "NSObject+Swizzling.h"

@implementation ViewController (b)
+ (void)load {
    NSLog(@"%s", __func__);
    
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        [NSObject exchangeInstanceMethodWithSelfClass:self originalSelector:@selector(viewDidLoad) swizzledSelector:@selector(swizzled_viewDidLoad)];
//    });
}
//- (void)swizzled_viewDidLoad {
//    [self swizzled_viewDidLoad];
//    NSLog(@"%s", __func__);
//}

- (void)test {
    NSLog(@"ViewController+b.h");
}

NSInteger partition(NSMutableArray<NSNumber *> *nums, NSInteger low, NSInteger high) {
    NSInteger pivot = [nums[high] integerValue];  // 选择最后一个元素作为基准值
    NSInteger i = low - 1;
    
    for (NSInteger j = low; j < high; j++) {
        if ([nums[j] integerValue] >= pivot) {  // 降序排列，保留大于等于基准值的元素在左侧
            i++;
            [nums exchangeObjectAtIndex:i withObjectAtIndex:j];
        }
    }
    [nums exchangeObjectAtIndex:i+1 withObjectAtIndex:high];
    return i + 1;
}

NSInteger quickSelect(NSMutableArray<NSNumber *> *nums, NSInteger low, NSInteger high, NSInteger k) {
    if (low == high) {
        return [nums[low] integerValue];
    }
    NSInteger pos = partition(nums, low, high);
    if (pos == k - 1) {
        return [nums[pos] integerValue];
    } else if (pos > k - 1) {
        return quickSelect(nums, low, pos - 1, k);
    } else {
        return quickSelect(nums, pos + 1, high, k);
    }
}
@end
