//
//  ViewController.m
//  JYQActionTest
//
//  Created by 贾永强 on 2018/5/9.
//  Copyright © 2018年 JYQ. All rights reserved.
//

#import "ViewController.h"
#import "View1.h"
#import "UIResponder+JYQResponderChain.h"
#import "UIButton+Associate.h"
#import "Model.h"
#import "View3.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet View1 *view1;
@property (strong, nonatomic) Model *item;
@property (strong, nonatomic) IBOutletCollection(View3) NSArray *viewArr;
@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIButton *button = [UIButton initButtonWithFrame:CGRectMake(100, 240, 200, 40) Title:@"关联对象" action:^(UIButton *sender) {
        NSLog(@"关联对象 %@", sender);
    }];
    [self.view addSubview:button];
    
    Model *model = [[Model alloc] init];
    model.name = @"JYQ";
    model.age = 18;
    self.item = model;
    self.label.text = [NSString stringWithFormat:@"年龄：%ld", self.item.age];
    
    for (View3 *view in _viewArr) {
        view.item = model;
    }
}

- (IBAction)xibButtonFirstResponder:(id)sender {
    NSLog(@"xib firstResponder action from %@", sender);
}

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo {
    if ([eventName isEqualToString:@"ResponderChainTest"]) {
        NSLog(@"ResponderChainTest %@", [userInfo objectForKey:@"key"]);
    }
}

///协议和弱指针容器
- (IBAction)changeAge:(id)sender {
    self.item.age++;
    self.label.text = [NSString stringWithFormat:@"年龄：%ld", self.item.age];
}

@end
