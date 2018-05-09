//
//  View3.m
//  JYQActionTest
//
//  Created by 贾永强 on 2018/5/9.
//  Copyright © 2018年 JYQ. All rights reserved.
//

#import "View3.h"

@implementation View3

- (void)setItem:(Model *)item {
    if (_item != item) {
        [_item removeDisplayer:self];
    }
    _item = item;
    [_item addDisplayer:self];
    [self ageChange:item];
}

- (void)ageChange:(Model *)model {
    self.label.text = [NSString stringWithFormat:@"年龄：%ld", model.age];
}

@end
