//
//  Model.m
//  JYQActionTest
//
//  Created by 贾永强 on 2018/5/9.
//  Copyright © 2018年 JYQ. All rights reserved.
//

#import "Model.h"

@interface Model()
@property (strong, nonatomic) NSHashTable<ModelStateUpdate> *displayers;
@end

@implementation Model

- (void)setAge:(NSUInteger)age {
    if (_age != age) {
        _age = age;
        for (id<ModelStateUpdate> item in _displayers) {
            if ([item respondsToSelector:@selector(ageChange:)]) {
                [item ageChange:self];
            }
        }
    }
}

- (NSHashTable<ModelStateUpdate> *)displayers {
    if (!_displayers) {
        _displayers = (NSHashTable<ModelStateUpdate> *)[NSHashTable weakObjectsHashTable];
    }
    return _displayers;
}

-(void)addDisplayer : (id)displayer {
    [self.displayers addObject:displayer];
}

-(void)removeDisplayer : (id)displayer {
    [self.displayers removeObject:displayer];
}

@end
