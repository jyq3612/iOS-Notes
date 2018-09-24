//
//  ViewController.m
//  RealmObject
//
//  Created by 贾永强 on 2018/9/20.
//  Copyright © 2018年 JYQ. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    int a[4];
    a[0] = 1;
    a[1] = 2;
    a[2] = 3;
    
    
    NSString *st = @"3456789234567892345678923456782345678234567823456";
    for (int i = 0; i < st.length; i ++) {
        NSLog(@"%d", [st characterAtIndex:i] - '0');
    }
//    const char *b = [st UTF8String];
    
}

- (NSString *)invertedOrderWithStr:(NSString *)str {
    NSMutableString *s = [NSMutableString stringWithCapacity:str.length];
    for (int i = (int)str.length -  1; i >= 0; i--) {
        [s appendFormat:@"%c", [str characterAtIndex:i]];
    }
    return s;
}

- (IBAction)pop:(UIStoryboardSegue *)sender {
    NSLog(@"返回了ViewController页面");
}

//- (BOOL)canPerformUnwindSegueAction:(SEL)action fromViewController:(UIViewController *)fromViewController withSender:(id)sender {
//    return YES;
//}
//
//- (void)unwindForSegue:(UIStoryboardSegue *)unwindSegue towardsViewController:(UIViewController *)subsequentVC {
//    NSLog(@"%@", subsequentVC);
//}

@end
