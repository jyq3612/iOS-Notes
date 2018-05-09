//
//  UIButton+Associate.h
//  JYQActionTest
//
//  Created by 贾永强 on 2018/5/9.
//  Copyright © 2018年 JYQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (Associate)

+ (UIButton *)initButtonWithFrame:(CGRect)rect Title:(NSString *)string action:(void(^)(UIButton *))action;

@end
