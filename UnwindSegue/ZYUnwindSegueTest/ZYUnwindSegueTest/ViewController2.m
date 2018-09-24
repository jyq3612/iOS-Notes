//
//  ViewController2.m
//  RealmObject
//
//  Created by 贾永强 on 2018/9/21.
//  Copyright © 2018年 JYQ. All rights reserved.
//

#import "ViewController2.h"

@interface ViewController2 ()

@end

@implementation ViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)pop:(id)sender {
    [self performSegueWithIdentifier:@"pop" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController *vc = segue.destinationViewController;
    vc.view.backgroundColor = [UIColor redColor];
}
@end
