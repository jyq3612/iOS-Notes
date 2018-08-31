//
//  Animal.m
//  消息转发
//
//  Created by 贾永强 on 2018/8/6.
//  Copyright © 2018年 JYQ. All rights reserved.
//

#import "Animal.h"

@implementation Animal
- (void)test4:(NSString *)str {
    NSLog(@"%@----%p", str, __func__);
}
@end
