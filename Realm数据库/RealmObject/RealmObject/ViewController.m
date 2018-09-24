//
//  ViewController.m
//  RealmObject
//
//  Created by 贾永强 on 2018/9/20.
//  Copyright © 2018年 JYQ. All rights reserved.
//

#import "ViewController.h"
#import "RealmModel.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (nonatomic, readwrite, strong) RLMRealm *sharedStorage;
@property (strong, nonatomic) RLMResults<ZYRealmModel *> *result;
@property (strong, nonatomic) RLMRealm *realm;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self sharedStorage];
}

- (RLMRealm *)sharedStorage
{
    if (!_sharedStorage) {
        _sharedStorage = [self realmWithURL:[[self realmDirURL] URLByAppendingPathComponent:@"main.db"]];
    }
    return _sharedStorage;
}

- (NSURL *)realmDirURL {
    NSFileManager *fm = [NSFileManager defaultManager];
    NSURL *supportDirURL = [fm URLForDirectory:NSApplicationSupportDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:YES error:nil];
    
    [fm setAttributes:@{ NSFileProtectionKey : NSFileProtectionNone } ofItemAtPath:supportDirURL.path error:nil];
    return supportDirURL;
}

- (NSString *)getDocumentsPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSLog(@"path:%@", path);
    return path;
}


- (RLMRealm *)realmWithURL:(NSURL *)url
{
    
    NSError __autoreleasing *e = nil;
    RLMRealm *s = [RLMRealm realmWithConfiguration:[self realmConfigurationWithPath:url] error:&e];
    if (s) return s;
    
    return nil;
}

- (RLMRealmConfiguration *)realmConfigurationWithPath:(NSURL *)path
{
    RLMRealmConfiguration *conf = [[RLMRealmConfiguration alloc] init];
    ;
    conf.fileURL = path;
    conf.schemaVersion = 25;
    [conf setMigrationBlock:^(RLMMigration * _Nonnull migration, uint64_t oldSchemaVersion) {
        if (oldSchemaVersion < 25) {
            
            [migration enumerateObjects:[ZYRealmModel className] block:^(RLMObject * _Nullable oldObject, RLMObject * _Nullable newObject) {
                newObject[@"collageName"] = @"collageName1";
            }];
        }
        NSLog(@"current thread = %@", [NSThread currentThread]);
    }];
    

    [RLMRealmConfiguration setDefaultConfiguration:conf];
    return conf;
}

- (IBAction)saveData:(id)sender {
    RLMRealm *realm = [RLMRealm defaultRealm];
    
    for (int i = 0; i < 1000; i++) {
        [realm transactionWithBlock:^{
            ZYRealmModel *m = [[ZYRealmModel alloc] init];
            m.name = [NSString stringWithFormat:@"name-%d", i];
            m.sex = i%2 ? @"F" : @"M";
            m.age = arc4random()%60 + 20;
            [realm addObject:m];
        }];
    }
}

- (IBAction)save2:(id)sender {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        RLMRealm *realm = [RLMRealm defaultRealm];
        for (int i = 1000; i < 2000; i++) {
            [realm transactionWithBlock:^{
                ZYRealmModel *m = [[ZYRealmModel alloc] init];
                m.name = [NSString stringWithFormat:@"name-%d", i];
                m.sex = i%2 ? @"F" : @"M";
                m.age = arc4random()%60 + 20;
                m.collageName = [NSString stringWithFormat:@"collage--%d", i];
                [realm addObject:m];
            }];
        }
    });
}



- (IBAction)readData:(id)sender {
//    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        RLMResults<ZYRealmModel *> *result = [ZYRealmModel objectsWhere:@"age > 75"];
        self.result = result;
//    });
    
}

- (IBAction)printResult:(id)sender {
    NSMutableString *str = [NSMutableString string];
    for (ZYRealmModel *m in self.result) {
        [str appendFormat:@"name = %@, sex = %@, age = %d\n", m.name, m.sex, m.age];
    }
    dispatch_async(dispatch_get_main_queue(), ^{
        self.textView.text = str;
    });
}

- (IBAction)clearAll:(id)sender {
    RLMRealm *realm = [RLMRealm defaultRealm];
    [realm beginWriteTransaction];
    [realm deleteAllObjects];
    [realm commitWriteTransaction];
}


@end
