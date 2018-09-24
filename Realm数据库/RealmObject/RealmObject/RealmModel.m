//
//  RealmModel.m
//  RealmObject
//
//  Created by 贾永强 on 2018/9/20.
//  Copyright © 2018年 JYQ. All rights reserved.
//

#import "RealmModel.h"

@implementation ZYRealmModel


@end

@interface Dog : RLMObject
@property NSString *name;
@property NSData   *picture;
@property NSInteger age;
@end

@implementation Dog
@end

RLM_ARRAY_TYPE(Dog)
@interface Person : RLMObject
@property NSString             *name;
@property RLMArray<Dog *><Dog> *dogs;
@end
@implementation Person
@end

