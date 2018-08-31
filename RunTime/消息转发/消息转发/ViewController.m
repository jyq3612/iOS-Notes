//
//  ViewController.m
//  消息转发
//
//  Created by 贾永强 on 2018/8/6.
//  Copyright © 2018年 JYQ. All rights reserved.
//

#import "ViewController.h"
#import "Dog.h"
#import <objc/runtime.h>

@interface ViewController ()

@end

void functionForTest1(id self, SEL _cmd) {
    NSLog(@"%p", __func__);
}

@implementation ViewController

+ (void)load {
    NSLog(@"%p", __func__);
    [super load];
}

- (instancetype)init {
    NSLog(@"%p", __func__);
    return [super init];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

///动态解析
- (IBAction)onDynamicAlloc:(id)sender {
//    [self performSelector:@selector(onTest1)];
    [[self class] performSelector:@selector(onTest2)];
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    NSLog(@"%d", [super resolveInstanceMethod:sel]);
    if ([NSStringFromSelector(sel) isEqualToString:@"onTest1"]) {
         class_addMethod(self.class, sel, (IMP)functionForTest1, "@:");
    }
    NSLog(@"%d", [super resolveInstanceMethod:sel]);
    return [super resolveInstanceMethod:sel];
}

+ (BOOL)resolveClassMethod:(SEL)sel {
    NSLog(@"%d", [super resolveClassMethod:sel]);
    if ([NSStringFromSelector(sel) isEqualToString:@"onTest2"]) {
        class_addMethod(objc_getMetaClass("ViewController"), sel, (IMP)functionForTest1, "@:");
    }
    NSLog(@"%d", [super resolveClassMethod:sel]);
    return [super resolveClassMethod:sel];
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    if ([NSStringFromSelector(aSelector) isEqualToString:@"test3"]) {
        return [Dog new];
    }
    return [super forwardingTargetForSelector:aSelector];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    if ([anInvocation selector] == @selector(test4)) {
        Animal *animal = [[Animal alloc] init];
        NSString *str = @"1234";
        [anInvocation setArgument:&str atIndex:2];
        anInvocation.selector = @selector(test4:);
        [anInvocation invokeWithTarget:animal];
    }
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    
    if (aSelector == @selector(test4)) {
        return [Animal instanceMethodSignatureForSelector:@selector(test4:)];
    }
    return [super methodSignatureForSelector:aSelector];
}

///备用接收者
- (IBAction)zhuanfa:(id)sender {
    [self performSelector:@selector(test3)];
}

///完整转发
- (IBAction)haha:(id)sender {
    [self performSelector:@selector(test4)];
    
}

@end
