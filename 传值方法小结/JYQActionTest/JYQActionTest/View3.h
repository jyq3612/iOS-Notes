//
//  View3.h
//  JYQActionTest
//
//  Created by 贾永强 on 2018/5/9.
//  Copyright © 2018年 JYQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Model.h"
#import "XXNibBridge.h"

@interface View3 : UIView<ModelStateUpdate, XXNibBridge>
@property (strong, nonatomic) Model *item;
@property (weak, nonatomic) IBOutlet UILabel *label;
@end
