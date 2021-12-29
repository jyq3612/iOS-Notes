//
//  ViewController.m
//  TraitTest
//
//  Created by jiayongqiang on 2021/12/28.
//

#import "ViewController.h"

/*
 关于使用dispatch_semaphore_t的过程中的崩溃问题，可以参考以下的demo和博客：https://zhangbuhuai.com/post/dispatch-semaphore.html
 */

@interface ViewController ()
@property (nonatomic, strong) dispatch_semaphore_t sema;
@property (nonatomic) CGRect viewRect;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    NSLog(@"touchesEnded");
    
    // crash!
    // 当某个dispatch_semaphore_t正处于dispatch_semaphore_wait的时候
    // 释放这个dispatch_semaphore_t的引用，将会导致崩溃
    self.sema = nil;
}

- (IBAction)button1Tap:(id)sender {
    
    self.sema = dispatch_semaphore_create(0);
    
    // 每隔1秒释放一个信号量
    __weak typeof(self) weakSelf = self;
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.0 repeats:YES block:^(NSTimer * _Nonnull timer) {
        if (weakSelf.sema) {
            NSLog(@"dispatch_semaphore_signal");
            dispatch_semaphore_signal(weakSelf.sema);
        }
    }];
    
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 模拟10个任务
        for (NSInteger index = 1; index <= 3; ++ index) {
            // 每个任务都需要等待到有信号量才能开始
            NSLog(@"将要执行任务%@...", @(index));
            dispatch_semaphore_wait(self.sema, DISPATCH_TIME_FOREVER);
            NSLog(@"已执行任务%@...", @(index));
        }
        
        // 全部任务执行完毕
        NSLog(@"NSTimer 释放");
        [timer invalidate];
    });
}

- (IBAction)button2Tap:(id)sender {
    
    NSLog(@"%@",self.sema);
    self.sema = dispatch_semaphore_create(3);
    NSLog(@"current thread = %@，将要执行任务", [NSThread currentThread]);
    intptr_t value = dispatch_semaphore_wait(self.sema, DISPATCH_TIME_FOREVER);
    NSLog(@"current thread = %@，已经执行任务, value = %ld", [NSThread currentThread], value);
}

- (IBAction)button3Tap:(id)sender {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        for (int i = 0; i < 100; i++) {
            sleep(1);
            NSLog(@"current num = %d",i);
        }
    });
}


- (IBAction)button4Tap:(id)sender {
    if (self.sema) {
        NSLog(@"button4:dispatch_semaphore_signal");
        intptr_t value = dispatch_semaphore_signal(self.sema);
        NSLog(@"button4:dispatch_semaphore_signal value值为：%ld", value);
    }
}
@end
