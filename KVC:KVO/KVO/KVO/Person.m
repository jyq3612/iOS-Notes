//
//  Person.m
//  KVO
//
//  Created by 贾永强 on 2018/7/12.
//  Copyright © 2018年 JYQ. All rights reserved.
//

#import "Person.h"

@interface Person()
@end

@implementation Person

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        _name = name;
    }
    return self;
}

- (void)changeName:(NSString *)name {
    _name = name;
}

- (void)setAge:(NSUInteger)age {
    _age = age;
}

- (void)setSecondDog:(Dog *)secondDog {
    NSLog(@"%s  -- 调用前", __func__);
    _secondDog = secondDog;
    NSLog(@"%s  -- 调用后", __func__);
}

- (void)willChangeValueForKey:(NSString *)key {
    [super willChangeValueForKey:key];
    NSLog(@"%p  key = %@", __func__, key);
}

- (void)didChangeValueForKey:(NSString *)key {
    [super didChangeValueForKey:key];
    NSLog(@"%p  key = %@", __func__, key);
}

///通过重写该方法可以控制是否自动发出通知
//+ (BOOL)automaticallyNotifiesObserversForKey:(NSString *)key {
//    if ([key isEqualToString:@"age"]) {
//        return NO;
//    }
//    return [super automaticallyNotifiesObserversForKey:key];
//}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    NSLog(@"%@", NSStringFromSelector(sel));
    BOOL result = [super resolveInstanceMethod:sel];
    
    return result;
}

@end

@implementation Dog


@end
