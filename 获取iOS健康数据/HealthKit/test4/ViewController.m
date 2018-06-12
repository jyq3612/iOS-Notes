//
//  ViewController.m
//  test4
//
//  Created by 贾永强 on 2018/5/10.
//  Copyright © 2018年 JYQ. All rights reserved.
//

#import "ViewController.h"
#import <HealthKit/HealthKit.h>

@interface ViewController ()
@property (strong, nonatomic) HKHealthStore *healthStore;
@property (weak, nonatomic) IBOutlet UILabel *stepNumberLabel;
@property (weak, nonatomic) IBOutlet UITextField *stepNumberTextfield;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)isHealthDataAvailable{
    if ([HKHealthStore isHealthDataAvailable]) {
        HKHealthStore *healthStore = [[HKHealthStore alloc]init];
        NSSet *writeDataTypes = [self dataTypesToWrite];
        NSSet *readDataTypes = [self dataTypesToRead];
        [healthStore requestAuthorizationToShareTypes:writeDataTypes readTypes:readDataTypes completion:^(BOOL success, NSError *error) {
            if (!success) {
                NSLog(@"不允许包来访问这些读/写数据类型。error === %@", error);
                return;
            }
        }];
        self.healthStore = healthStore;
    }
}

#pragma mark - 设置写入权限
- (NSSet *)dataTypesToWrite {
    HKQuantityType *stepType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    HKQuantityType *distanceType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
    return [NSSet setWithObjects:stepType,distanceType, nil];
}

#pragma mark - 设置读取权限
- (NSSet *)dataTypesToRead {
    HKQuantityType *stepType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    HKQuantityType *distanceType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning];
    
    return [NSSet setWithObjects:stepType,distanceType, nil];
}

- (IBAction)getStepsFromHealthKit{
    HKQuantityType *stepType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    [self fetchSumOfSamplesTodayForType:stepType unit:[HKUnit countUnit] completion:^(double stepCount, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.stepNumberLabel.text = [NSString stringWithFormat:@"今天共走%.0f步", stepCount];
        });
    }];
}

- (void)fetchSumOfSamplesTodayForType:(HKQuantityType *)quantityType unit:(HKUnit *)unit completion:(void (^)(double, NSError *))completionHandler {
    NSPredicate *predicate = [self predicateForSamplesToday];
    
    HKStatisticsQuery *query = [[HKStatisticsQuery alloc] initWithQuantityType:quantityType quantitySamplePredicate:predicate options:HKStatisticsOptionCumulativeSum | HKStatisticsOptionSeparateBySource completionHandler:^(HKStatisticsQuery *query, HKStatistics *result, NSError *error) {
        HKQuantity *sum = [result sumQuantity];
        
        for (HKSource *s in result.sources) {
            HKQuantity *q = [result sumQuantityForSource:s];
            double step = [q doubleValueForUnit:[HKUnit countUnit]];
            NSLog(@"来源：%@, 步数：%.0f",s.bundleIdentifier, step);
        }
        if (completionHandler) {
            double value = [sum doubleValueForUnit:unit];
            completionHandler(value, error);
        }
    }];
    [self.healthStore executeQuery:query];
}

- (NSPredicate *)predicateForSamplesToday {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *now = [NSDate date];
    NSDate *startDate = [calendar startOfDayForDate:now];
    NSDate *endDate = [calendar dateByAddingUnit:NSCalendarUnitDay value:1 toDate:startDate options:0];
    return [HKQuery predicateForSamplesWithStartDate:startDate endDate:endDate options:HKQueryOptionStrictStartDate];
}

- (IBAction)addstepWithStepNum {
    
    for (int i = 0; i < 5; i++) {
        double stepNum = [self.stepNumberTextfield.text doubleValue];
        HKQuantitySample *stepCorrelationItem = [self stepCorrelationWithStepNum:stepNum];
        [self.healthStore saveObject:stepCorrelationItem withCompletion:^(BOOL success, NSError *error) {
            NSLog(@"写入结果：%@", success ? @"成功" : @"失败");
        }];
    }
}

- (HKQuantitySample *)stepCorrelationWithStepNum:(double)stepNum {
    static NSInteger timeInterval = 0;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *startDate = [calendar startOfDayForDate:[NSDate date]];
    
    NSDate *endDate = [NSDate dateWithTimeInterval:timeInterval+3600 sinceDate:[NSDate dateWithTimeInterval:timeInterval sinceDate:startDate]];
    
    timeInterval = timeInterval + 3600;
    
    HKQuantity *stepQuantityConsumed = [HKQuantity quantityWithUnit:[HKUnit countUnit] doubleValue:stepNum];
    HKQuantityType *stepConsumedType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount];
    
    NSString *strName = [[UIDevice currentDevice] name];
    NSString *strModel = [[UIDevice currentDevice] model];
    NSString *strSysVersion = [[UIDevice currentDevice] systemVersion];
    NSString *localeIdentifier = [[NSLocale currentLocale] localeIdentifier];
    
    HKDevice *device = [[HKDevice alloc] initWithName:strName manufacturer:@"Apple" model:strModel hardwareVersion:strModel firmwareVersion:strModel softwareVersion:strSysVersion localIdentifier:localeIdentifier UDIDeviceIdentifier:localeIdentifier];
    
    HKQuantitySample *stepConsumedSample = [HKQuantitySample quantitySampleWithType:stepConsumedType quantity:stepQuantityConsumed startDate:startDate endDate:endDate device:device metadata:nil];
    
    return stepConsumedSample;
}

@end
