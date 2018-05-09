//
//  Model.h
//  JYQActionTest
//
//  Created by 贾永强 on 2018/5/9.
//  Copyright © 2018年 JYQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Modelupdate;

@interface Model : NSObject<Modelupdate>

@property (strong, nonatomic) NSString *name;
@property (nonatomic) NSUInteger age;
@end

@protocol ModelStateUpdate <NSObject>
- (void)ageChange:(Model *)model;
@end

@protocol Modelupdate <NSObject>
@optional
@property (readonly, nonatomic) NSHashTable<ModelStateUpdate> *displayers;
- (void)addDisplayer:(id)displayer;
- (void)removeDisplayer:(id)displayer;

@end

