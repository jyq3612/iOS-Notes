//
//  UIResponder+JYQResponderChain.h
//  JYQActionTest
//
//  Created by 贾永强 on 2018/5/9.
//  Copyright © 2018年 JYQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIResponder (JYQResponderChain)
- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo;
@end
