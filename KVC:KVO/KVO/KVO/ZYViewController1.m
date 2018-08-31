//
//  ZYViewController1.m
//  KVO
//
//  Created by 贾永强 on 2018/7/12.
//  Copyright © 2018年 JYQ. All rights reserved.
//

#import "ZYViewController1.h"
#import <objc/runtime.h>
#import "Person.h"

@interface ZYViewController1 ()
@property (assign, nonatomic) int testCount;
@end

@implementation ZYViewController1


- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    [self.item addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:@"person.name"];
    [self.item addObserver:self forKeyPath:@"secondDog" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:@"person.secondDog"];
    [self addObserver:self forKeyPath:@"testCount" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:@"testCount"];

    unsigned int methCount = 0;
    Method *meths = class_copyMethodList([self.item class], &methCount);
    for (int i = 0; i < methCount; i++) {
        Method m = meths[i];
        SEL sel = method_getName(m);
        const char *name = sel_getName(sel);
        NSLog(@"%s", name);

    }
   
}

- (IBAction)KVO:(id)sender {
//    [self.item setValue:@"vc2" forKey:@"name"];///readonly修饰可以被监听
//    [self.item changeName:@"vc2"];///直接修改变量不修饰可以被监听
    self.testCount = 2;///可以监听到
//    _testCount = 2;///不可以监听到
    Dog *sDog = [Dog new];
    [self.item setValue:sDog forKey:@"secondDog"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"%s\nkeyPath = %@\n object = %@\n change = %@\n context = %@", __func__, keyPath, object, change, context);
}

- (void)dealloc {
    [self removeObserver:self forKeyPath:@"testCount"];
    [self.item removeObserver:self forKeyPath:@"secondDog"];
//    [self.item removeObserver:self forKeyPath:@"name"];
}

@end
