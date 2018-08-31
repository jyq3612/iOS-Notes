//
//  ViewController2.m
//  RunTime-Test
//
//  Created by 贾永强 on 2018/7/10.
//  Copyright © 2018年 JYQ. All rights reserved.
//

#import "ViewController2.h"

@interface ViewController2 ()

@end

@implementation ViewController2

+ (void)initialize {
    [super initialize];
    NSLog(@"%s", __func__);
}

- (void)loadView {
//    [super loadView];
    NSLog(@"%s", __func__);
//    if (!self.view) {
        self.view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 600)];
        self.view.backgroundColor = [UIColor redColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(100, 100, 100, 100);
    button.backgroundColor = [UIColor blueColor];
    [button addTarget:self action:@selector(clearView:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
//    }
//    else {
//        self.view.backgroundColor = [UIColor greenColor];
//    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%s", __func__);
    
    [UINib nibWithNibName:@"" bundle:nil];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"%s", __func__);
}

- (void)dealloc {
    if (self.view) {
        NSLog(@"%s--self.view = %@", __func__, self.view);
        if (self.view.superview) {
            NSLog(@"%s--self.view.superview = %@", __func__, self.view.superview);
        }
    }
}

- (IBAction)clearView:(id)sender {
//    [self.view removeFromSuperview];
    self.view = nil;
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 10, 10)];
    label.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:label];
}


@end
