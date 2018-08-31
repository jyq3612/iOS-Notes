//
//  Person.h
//  KVO
//
//  Created by 贾永强 on 2018/7/12.
//  Copyright © 2018年 JYQ. All rights reserved.
//

#import <Foundation/Foundation.h>
@class Dog;

@interface Person : NSObject
@property (nonatomic, strong, readonly) NSString *name;
@property (assign, nonatomic) NSUInteger age;
@property (strong, nonatomic) NSDate *date;
@property (strong, nonatomic) Dog *myDog;

///用来验证KVO是否会重写readonly修饰变量的setting方法
@property (nonatomic, strong) Dog *secondDog;

- (instancetype)initWithName:(NSString *)name;
- (void)changeName:(NSString *)name;

@end


@interface Dog : NSObject
@property (strong, nonatomic) NSString *name;
@end
