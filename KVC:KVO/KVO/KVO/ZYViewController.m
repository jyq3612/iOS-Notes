//
//  ZYViewController.m
//  KVO
//
//  Created by 贾永强 on 2018/7/12.
//  Copyright © 2018年 JYQ. All rights reserved.
//

#import "ZYViewController.h"
#import "Person.h"
#import <objc/runtime.h>
#import "Person+Body.h"
#import "ZYViewController1.h"

@interface ZYViewController ()
@property (strong, nonatomic) Person *person;
@end

@implementation ZYViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.person = [[Person alloc] initWithName:@"JYQ"];
//    [NSLog(@"self.person = %s", object_getClassName(self.person))];
    [self.person addObserver:self forKeyPath:@"name" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:@"person.name"];
    [self.person addObserver:self forKeyPath:@"age" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:@"person.age"];
    [self.person addObserver:self forKeyPath:@"sex" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:@"person.sex"];
    [self.person addObserver:self forKeyPath:@"date" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:@"person.date"];
    [self.person addObserver:self forKeyPath:@"myDog" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:@"person.myDog"];
    
    
//    [NSLog(@"self.person = %s", object_getClassName(self.person))];
    
    
/*
 结论：readonly修饰的属性可以被KVO监听,数据类型可以通过KVO监听；分类绑定的变量可以通过KVO监听;甚至自定义数据对象可是可以被KVO监听的。🐂🐂🐂
 
 BUT：
 
 如果在类内部直接通过成员变量修改属性值是监听不到的。。。可以看ZYViewController中的例子
 
 
 
 */
    
}

- (IBAction)KVC:(id)sender {
    [self.person setValue:@"haha" forKey:@"name"];
    [self.person setValue:@"M" forKey:@"sex"];
    [self.person setValue:[NSDate date] forKey:@"date"];
    [self.person setValue:({
        Dog *dog = [Dog new];
        dog.name = @"GG";
        dog;
    }) forKey:@"myDog"];
    [self.person setValue:@"dog" forKeyPath:@"myDog.name"];
    
/*
 结论：
 */
}

- (IBAction)KVO:(id)sender {
    self.person.age = 12;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    ZYViewController1 *vc = segue.destinationViewController;
    if ([vc respondsToSelector:@selector(setItem:)]) {
        [vc setItem:self.person];
    }
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    NSLog(@"%s\nkeyPath = %@\n object = %@\n change = %@\n context = %@", __func__, keyPath, object, change, context);
}

- (void)dealloc {
    [self.person removeObserver:self forKeyPath:@"name"];
    [self.person removeObserver:self forKeyPath:@"age"];
    [self.person removeObserver:self forKeyPath:@"sex"];
    [self.person removeObserver:self forKeyPath:@"date"];
    [self.person removeObserver:self forKeyPath:@"myDog"];
}

@end
