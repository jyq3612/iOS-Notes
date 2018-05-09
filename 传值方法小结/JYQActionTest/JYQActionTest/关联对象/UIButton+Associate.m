//
//  UIButton+Associate.m
//  JYQActionTest
//
//  Created by 贾永强 on 2018/5/9.
//  Copyright © 2018年 JYQ. All rights reserved.
//

#import "UIButton+Associate.h"
#import <objc/runtime.h>

static NSString *actionKey = @"action";

@implementation UIButton (Associate)

+ (UIButton *)initButtonWithFrame:(CGRect)rect Title:(NSString *)string action:(void (^)(UIButton *))action {
    UIButton *b = [UIButton buttonWithType:UIButtonTypeCustom];
    b.backgroundColor = [UIColor yellowColor];
    b.frame = rect;
    [b setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [b setTitle:string forState:UIControlStateNormal];
    objc_setAssociatedObject(b, &actionKey, action, OBJC_ASSOCIATION_COPY);
    [b addTarget:b action:@selector(buttonTapped:) forControlEvents:UIControlEventTouchUpInside];
    return b;
}

- (void)buttonTapped:(UIButton *)sender {
    void (^action)(UIButton *) = objc_getAssociatedObject(sender, &actionKey);
    if (action) {
        action(sender);
    }
}
@end
