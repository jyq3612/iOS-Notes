//
//  View1.m
//  JYQActionTest
//
//  Created by 贾永强 on 2018/5/9.
//  Copyright © 2018年 JYQ. All rights reserved.
//

#import "View1.h"

@implementation View1

- (IBAction)button2Tapped:(id)sender {
    [[UIApplication sharedApplication] sendAction:@selector(xibButtonFirstResponder:) to:nil from:sender forEvent:nil];
}

@end
