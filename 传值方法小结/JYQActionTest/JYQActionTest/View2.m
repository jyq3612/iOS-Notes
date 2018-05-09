//
//  View2.m
//  JYQActionTest
//
//  Created by 贾永强 on 2018/5/9.
//  Copyright © 2018年 JYQ. All rights reserved.
//

#import "View2.h"
#import "UIResponder+JYQResponderChain.h"

@interface View2()
@property (strong, nonatomic) UILabel *label;
@end

@implementation View2

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor greenColor];
    UILabel *label = [[UILabel alloc] init];
    label.text = @"通过响应者链传递事件";
    [self addSubview:label];
    self.label = label;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    [self.label sizeToFit];
    self.label.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self routerEventWithName:@"ResponderChainTest" userInfo:@{@"key" : @"ResponderChainTest"}];
}

 @end
