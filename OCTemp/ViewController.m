//
//  ViewController.m
//  OCTemp
//
//  Created by jingwei on 2025/5/27.
//

#import "ViewController.h"
#import "View1.h"
#import "WJRouterProtocol.h"
#import "WJRouter.h"


@interface NSString (Times33)
- (NSUInteger)times33Hash;
@end

@implementation NSString (Times33)

- (NSUInteger)times33Hash {
    const char *str = [self UTF8String];
    NSUInteger hash = 5381; // 初始值
    
    while (*str) {
        // hash = hash * 33 + c;
        hash = ((hash << 5) + hash) + (*str++); // 等价于hash * 33 + c
    }
    
    return hash;
}

@end

@interface ViewController ()<WJRouterProtocol>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    View1 *viewa = View1.new;
    
    NSString *str = @"11";
    NSLog(@"%zd   %zd",str.hash, viewa.hash);
    NSLog(@"%zd ",[str times33Hash]);
    
    /*
     需要了解堆和栈的关系。对象创建后是在堆上还是栈上，什么时候发生变化。
     栈 一般存储的是函数的参数 局部变量 函数的调用信息 返回地址等等 直接操作寄存器 速度快。操作系统自己分配和释放 地址是由高到低
     比如 swift 的结构体值类型一般是在栈上
     我们的class block 一般是在堆上 内存大 由我们自己管理内存 由低到高
     因为 block默认是在栈上 我们使用copy 的时候让他 存储在堆上 由我们自己管理内存
     
     
     
     calayer 可以在 iOS 和 macos中 共用
     
     calayer 和 uiview 的设计 体现了 iOS 单一职能的设计原则
     calayer 包含模型书/呈现树/渲染树  呈现树我们可以直接获取到
     calayer和uiview一样也是 层级的树形结构
     */
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [WJRouter openWithName:@"Setting" parameters:@{@"a": @"1"} object:UIColor.yellowColor];
}

+  (UIViewController<WJRouterProtocol> *)createWithParameters:(NSDictionary *)parameters object:(id)object {
    NSLog(@"createWithParameters %@", parameters);
    ViewController *vc = ViewController.new;
    if ([object isKindOfClass:[UIColor class]]) {
        vc.view.backgroundColor = object;
    }
    return vc;
}

+  (NSString *)pageName { 
    return @"Login";
}

@end





















/*
 - (void)viewDidLoad {
     [super viewDidLoad];

     self.lock = [[NSLock alloc] init];
     self.recursiveLock = [[NSRecursiveLock alloc] init];
     self.recursiveLock1 = [[NSRecursiveLock alloc] init];

     //[self moneyTest];
     [self lockTest];
     NSLog(@"11");
 }
 //存钱取钱测试
 -(void)moneyTest {
     self.money = 100;
     
     dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
     
     dispatch_async(queue, ^{
         for (int i= 0; i<10; i++) {
             [self saveMoney];
         }
         
     });
     dispatch_async(queue, ^{
         for (int i = 0; i<10; i++) {
             [self drawMoney];
         }
     });
 }

 -(void)saveMoney {
     [self.lock lock];
     NSInteger oldMoney = self.money;
     sleep(.2);//模拟任务时长，便于问题显现
     oldMoney += 50;
     self.money = oldMoney;
     NSLog(@"存了50元，账户余额%ld-------%@",(long)oldMoney, [NSThread currentThread]);
     [self.lock unlock];
 }

 -(void)drawMoney {
     [self.lock lock];
     NSInteger oldMoney = self.money;
     sleep(.2);//模拟任务时长，便于问题显现
     oldMoney -= 20;
     self.money = oldMoney;
     NSLog(@"取了20元，账户余额%ld-------%@",(long)oldMoney, [NSThread currentThread]);
     [self.lock unlock];
 }


 //卖票问题
 -(void)sellTicketTest {
     self.ticketsCount = 30;
     
     dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
     
     dispatch_async(queue, ^{
         for (int i= 0; i<5; i++) {
             [self sellTicket];
         }
         
     });
     dispatch_async(queue, ^{
         for (int i = 0; i<5; i++) {
             [self sellTicket];
         }
     });
     dispatch_async(queue, ^{
         for (int i = 0; i<5; i++) {
             [self sellTicket];
         }
     });
 }

 -(void)sellTicket {
     NSInteger oldTicketsCount = self.ticketsCount;
     sleep(.2);//模拟任务时长，便于问题显现
     oldTicketsCount--;
     self.ticketsCount = oldTicketsCount;
     NSLog(@"还剩%ld张票-------%@",(long)oldTicketsCount, [NSThread currentThread]);
 }



 //MARK: NSLock
 - (void)lockTest {
         dispatch_async(dispatch_get_global_queue(0, 0), ^{
             static void (^testMethod)(int);
             testMethod = ^(int value) {
                 if (value > 0) {
                     [self.recursiveLock lock];
                     [self.recursiveLock1 lock];
                     NSLog(@"value:%d  %@",value, [NSThread currentThread]);
                     testMethod(value - 1);
                     [self.recursiveLock unlock];
                 }
             };
             testMethod(10);
         });
     dispatch_async(dispatch_get_global_queue(0, 0), ^{
         static void (^testMethod)(int);
         testMethod = ^(int value) {
             if (value > 0) {
                 [self.recursiveLock lock];
                 [self.recursiveLock1 lock];
                 NSLog(@"value:%d  %@",value, [NSThread currentThread]);
                 testMethod(value - 1);
                 [self.recursiveLock unlock];
             }
         };
         testMethod(10);
     });
     dispatch_async(dispatch_get_global_queue(0, 0), ^{
         static void (^testMethod)(int);
         testMethod = ^(int value) {
             if (value > 0) {
                 [self.recursiveLock lock];
                 NSLog(@"value:%d  %@",value, [NSThread currentThread]);
                 testMethod(value - 1);
                 [self.recursiveLock unlock];
             }
         };
         testMethod(10);
     });
     dispatch_async(dispatch_get_global_queue(0, 0), ^{
         static void (^testMethod)(int);
         testMethod = ^(int value) {
             if (value > 0) {
                 [self.recursiveLock lock];
                 NSLog(@"value:%d  %@",value, [NSThread currentThread]);
                 testMethod(value - 1);
                 [self.recursiveLock unlock];
             }
         };
         testMethod(10);
     });
 }
 */

//串行队列（DISPATCH_QUEUE_SERIAL）同一时间只能执行一个任务，后续任务需等待当前任务完成
//dispatch_sync 会阻塞当前线程，直到目标队列执行完提交的任务。若目标队列是当前正在执行的队列，会导致自我等待：

/*
 + (void)load {
     NSLog(@"%s", __func__);
 }

 + (void)initialize {
     NSLog(@"%s", __func__);
 }

 - (void)viewDidLoad {
     [super viewDidLoad];

     
     View1 *view1 = [[View1 alloc]initWithFrame:CGRectMake(0, 100, 200, 200)];
     View2 *view2 = [[View2 alloc]initWithFrame:CGRectMake(0, 50, 100, 100)];

     view1.backgroundColor = UIColor.redColor;
     view2.backgroundColor = UIColor.yellowColor;

     [self.view addSubview:view1];
     [view1 addSubview:view2];
     UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(view1Action)];
     // cancelsTouchesInView
     [view2 addGestureRecognizer:tap];
 //    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(viewAction)]];
 }


 /// touchesBegan 可以 看响应者链  先响应view2  view1 self.view
 /// view2不调用super那么久不显影事件
 ///   -[View2 touchesBegan:withEvent:] [View2 touchesEnded:withEvent:] 无手势
 ///   [View2 touchesBegan:withEvent:] [View2 touchesCancelled:withEvent:] 有手势
 - (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
     [super touchesBegan:touches withEvent:event];
     NSLog(@"%s", __func__);

 }

 - (void)viewAction {
     NSLog(@"%s", __func__);
 }
 - (void)view1Action{
     NSLog(@"%s", __func__);

      crash copy修饰生成不可变对象
      self.mArr = [NSMutableArray array];
      [self.mArr addObject:@""];
     
     
      self.mDic = [NSMutableDictionary dictionary];
      Teacher *t = [[Teacher alloc]init];
      Student *s = [[Student alloc]init];
      [self.mDic setObject:s forKey:t];
      // 明显可以看出key必须要遵循NSCoping协议
      NSLog(@"%@ %@", t, self.mDic.allKeys);
     
 }
 */
