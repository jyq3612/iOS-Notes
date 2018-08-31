//
//  Person+Body.m
//  KVO
//
//  Created by 贾永强 on 2018/7/12.
//  Copyright © 2018年 JYQ. All rights reserved.
//

#import "Person+Body.h"
#import <objc/runtime.h>

static const void *sexKey =&sexKey;

@implementation Person (Body)

- (void)setSex:(NSString *)sex {
    return objc_setAssociatedObject(self, sexKey, sex, OBJC_ASSOCIATION_COPY);
}

- (NSString *)sex {
    return objc_getAssociatedObject(self, sexKey);
}
@end
