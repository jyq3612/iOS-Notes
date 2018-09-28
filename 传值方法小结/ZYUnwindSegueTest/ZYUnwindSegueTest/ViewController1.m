//
//  ViewController1.m
//  RealmObject
//
//  Created by 贾永强 on 2018/9/21.
//  Copyright © 2018年 JYQ. All rights reserved.
//

#import "ViewController1.h"

@interface ViewController1 ()

@end

@implementation ViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//
//- (BOOL)canPerformUnwindSegueAction:(SEL)action fromViewController:(UIViewController *)fromViewController withSender:(id)sender {
//    return NO;
//}
//
//- (void)unwindForSegue:(UIStoryboardSegue *)unwindSegue towardsViewController:(UIViewController *)subsequentVC {
//    NSLog(@"%@", subsequentVC);
//}

- (IBAction)pop:(UIStoryboardSegue *)sender {
    NSLog(@"返回了ViewController页面");
}

@end
