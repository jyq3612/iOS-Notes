//
//  RealmModel.h
//  RealmObject
//
//  Created by 贾永强 on 2018/9/20.
//  Copyright © 2018年 JYQ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Realm/Realm.h>

@interface ZYRealmModel : RLMObject

@property NSString *ID;
@property NSString *name;
@property NSString *sex;
@property NSString *collageName;
@property int age;
@end
