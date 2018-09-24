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
    [[NSNotificationCenter defaultCenter] postNotificationName:@"notification" object:self userInfo:nil];
}


@end
