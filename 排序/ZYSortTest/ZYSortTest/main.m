//
//  main.m
//  ZYSortTest
//
//  Created by 贾永强 on 2018/4/23.
//  Copyright © 2018年 JYQ. All rights reserved.
//

#import <Foundation/Foundation.h>

void bubbleDescendingOrderSortWithArray(NSMutableArray <NSNumber *> *arr);
void selectionOrderSortWithArray(NSMutableArray<NSNumber *> *arr);
void insertionOrderSortWithArray(NSMutableArray<NSNumber *> *arr);
void shellOrderSortWithArray(NSMutableArray<NSNumber *> *arr);
NSArray<NSNumber *> *mergeOrderSortWithArray(NSArray<NSNumber *> *arr);
NSArray<NSNumber *> *quickOrderSortWithArray(NSArray<NSNumber *> *arr);
NSArray<NSNumber *> *heapOrderSortWithArray(NSArray<NSNumber *> *arr);
void countingOrderSortWithArray(unsigned int arr[], int count);
NSArray<NSNumber *> *bucketOrderSortWithArray(NSArray<NSNumber *> *arr);
NSArray<NSNumber *> *radixOrderSortWithArray(NSArray<NSNumber *> *arr);

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSMutableArray<NSNumber *> *a = [@[@2, @3, @1, @23, @43, @21, @5] mutableCopy];
        NSLog(@"%@", a);
        bubbleDescendingOrderSortWithArray(a);
        NSLog(@"%@", a);
        
        NSMutableArray<NSNumber *> *b = [@[@2, @3, @1, @23, @43, @21, @5] mutableCopy];
        NSLog(@"%@", b);
        selectionOrderSortWithArray(b);
        NSLog(@"%@", b);
        
        NSMutableArray<NSNumber *> *c = [@[@2, @3, @1, @23, @43, @21, @5] mutableCopy];
        NSLog(@"%@", c);
        insertionOrderSortWithArray(c);
        NSLog(@"%@", c);
        
        
        NSMutableArray<NSNumber *> *d = [@[@2, @4, @32, @31, @5254, @1, @423, @9, @132, @98, @76, @0, @54, @121, @123, @3, @1, @23, @43, @21, @5] mutableCopy];
        NSLog(@"%@", d);
        shellOrderSortWithArray(d);
        NSLog(@"%@", d);
     
        NSArray<NSNumber *> *e = @[@2, @4, @32, @31, @5254, @1, @423, @9, @132, @98, @76, @0, @54, @121, @123, @3, @1, @23, @43, @21, @5];
        NSLog(@"%@", e);
        e = mergeOrderSortWithArray(e);
        NSLog(@"%@", e);
        
        NSArray<NSNumber *> *f = @[@2, @4, @32, @31, @5254, @1, @423, @9, @132, @98, @76, @0, @54, @121, @123, @3, @1, @23, @43, @21, @5];
        NSLog(@"%@", f);
        f = quickOrderSortWithArray(f);
        NSLog(@"%@", f);
        
        NSArray<NSNumber *> *g = @[@2, @4, @32, @31, @5254, @1, @423, @9, @132, @98, @76, @0, @54, @121, @123, @3, @1, @23, @4873, @2011, @598];
        NSLog(@"%@", g);
        g = heapOrderSortWithArray(g);
        NSLog(@"%@", g);
        
        unsigned int h[] = {3,5,7,3,23,23,5,2,6,8,33,867,43,576,2345};
        countingOrderSortWithArray(h, sizeof(h)/sizeof(int));
        for (int i = 0; i < sizeof(h)/sizeof(int); i++) {
            printf("%d\n",h[i]);
        }
        
        NSArray<NSNumber *> *i = @[@2, @4, @32, @31, @5254, @1, @423, @9, @132, @98, @76, @0, @54, @121, @123, @3, @1, @23, @4873, @2011, @598];
        NSLog(@"%@", i);
        i = bucketOrderSortWithArray(i);
        NSLog(@"%@", i);
        
        NSArray<NSNumber *> *j = @[@2, @4, @32, @31, @5254, @1, @423, @9, @132, @98, @76, @0, @54, @121, @123, @3, @1, @23, @4873, @2011, @598];
        NSLog(@"%@", j);
        j = radixOrderSortWithArray(j);
        NSLog(@"%@", j);
        
    }
    return 0;
}

#pragma mark -- 冒泡算法
void bubbleDescendingOrderSortWithArray(NSMutableArray <NSNumber *> *arr) {
    NSNumber *temp; BOOL complete;
    for (int i = 0; i < arr.count; i++) {
        complete = YES;
        for (int j = 0; j < arr.count - i - 1; j++) {
            if ([arr[j] compare:arr[j + 1]] == NSOrderedAscending) {
                temp = arr[j];
                arr[j] = arr[j + 1];
                arr[j + 1] = temp;
                complete = NO;
            }
        }
        if (complete  == YES) return;
    }
}

#pragma mark -- 选择排序
void selectionOrderSortWithArray(NSMutableArray<NSNumber *> *arr) {
    int minIndex = 0; NSNumber *temp;
    for (int i = 0; i < arr.count; i++) {
        minIndex = i;
        for (int j = i + 1; j < arr.count; j++) {
            if ([arr[minIndex] compare:arr[j]] == NSOrderedDescending) {
                minIndex = j;
            }
        }
        if (minIndex != i) {
            temp = arr[i];
            arr[i] = arr[minIndex];
            arr[minIndex] = temp;
        }
    }
}

#pragma mark -- 插入排序
void insertionOrderSortWithArray(NSMutableArray<NSNumber *> *arr) {
    NSNumber *temp; int current;
    for (int i = 0; i < arr.count; i++) {
        temp = arr[i];
        current = i - 1;
        while (current >= 0 && [temp compare:arr[current]] == NSOrderedAscending) {
            arr[current + 1] = arr[current];
            current--;
        }
        arr[current + 1] = temp;
    }
}

#pragma mark -- 希尔排序
void shellOrderSortWithArray(NSMutableArray<NSNumber *> *arr) {
    NSUInteger count = arr.count;
    NSNumber *temp;
    int gap = 1, j;
    while (gap < count / 3) { // 动态定义间隔序列
        gap = gap * 3 + 1;
    }
    
    while (gap > 0) {
        for (int i = gap; i < count; i++) {
            temp = arr[i];
            j = i - gap;
            while (j >= 0 && [arr[j] compare:temp] == NSOrderedDescending) {
                arr[j + gap] = arr[j];
                j = j - gap;
            }
            arr[j + gap] = temp;
        }
        gap = gap / 3;//缩小增量
    }
}

#pragma mark -- 归并排序
NSArray<NSNumber *> * mergeArray(NSArray<NSNumber *> *left, NSArray<NSNumber *> *right);
NSArray<NSNumber *> * mergeOrderSortWithArray(NSArray<NSNumber *> *arr) {
    NSUInteger count = arr.count;
    if (count < 2) {
        return arr;
    }
    
    NSUInteger mid = count % 2 == 1 ? count/2 + 1 : count/2;
    return mergeArray(mergeOrderSortWithArray([arr subarrayWithRange:NSMakeRange(0, mid)]), mergeOrderSortWithArray([arr subarrayWithRange:NSMakeRange(mid, count - mid)]));
}

NSArray<NSNumber *> * mergeArray(NSArray<NSNumber *> *left, NSArray<NSNumber *> *right) {
    NSMutableArray<NSNumber *> *con = [NSMutableArray arrayWithCapacity:left.count + right.count];
    NSUInteger leftSign = 0,rightSign = 0;
    while (leftSign < left.count && rightSign < right.count) {
        if ([left[leftSign] compare:right[rightSign]] == NSOrderedDescending) {
            [con addObject:right[rightSign]];
            rightSign++;
        }
        else {
            [con addObject:left[leftSign]];
            leftSign++;
        }
    }
    [con addObjectsFromArray:[left subarrayWithRange:NSMakeRange(leftSign, left.count - leftSign)]];
    [con addObjectsFromArray:[right subarrayWithRange:NSMakeRange(rightSign, right.count - rightSign)]];
    return con.copy;
}

#pragma mark -- 快速排序
void quickSort(NSMutableArray<NSNumber *> *arr, int left, int right);

NSArray<NSNumber *> *quickOrderSortWithArray(NSArray<NSNumber *> *arr) {
    NSMutableArray *a = [arr mutableCopy];
    quickSort(a, 0, (int)arr.count - 1);
    return [a copy];
}

void quickSort(NSMutableArray<NSNumber *> *arr, int left, int right) {
    if (left < 0 || right >= arr.count || left >= right) return;
    
    int leftIndex = left, rightIndex = right;
    NSNumber *temp = arr[leftIndex];
    while (leftIndex < rightIndex) {
        while (leftIndex < rightIndex && [arr[rightIndex] compare:temp] != NSOrderedAscending) {
            rightIndex--;
        }
        if (leftIndex < rightIndex) {
            arr[leftIndex] = arr[rightIndex];
        }
        while (leftIndex < rightIndex && [arr[leftIndex] compare:temp] != NSOrderedDescending) {
            leftIndex++;
        }
        if (leftIndex < rightIndex) {
            arr[rightIndex] = arr[leftIndex];
        }
    }
    arr[leftIndex] = temp;
    quickSort(arr, left, leftIndex - 1);
    quickSort(arr, rightIndex + 1, right);
}

#pragma mark -- 堆排序
void adjustHeapOrder(NSMutableArray<NSNumber *> *arr, int position, int count);
NSArray<NSNumber *> *heapOrderSortWithArray(NSArray<NSNumber *> *arr) {
    
    NSMutableArray *a = [arr mutableCopy];
    int count = (int)arr.count;
    for (int i = count/2 - 1; i >= 0; i--) {
        adjustHeapOrder(a, i, count);
    }
    
    for (int i = count - 1; i > 0; i--) {
        NSNumber *temp = a[0];
        a[0] =  a[i];
        a[i] = temp;
        adjustHeapOrder(a, 0, i);
    }
    return [a copy];
}

void adjustHeapOrder(NSMutableArray<NSNumber *> *arr, int position, int count) {
    
    if (position >= count || position < 0) return;
    NSNumber *temp = arr[position];
    int p = position;
    for (int i = 2 * p + 1; i < count; i = 2 * i + 1) {
        if ([arr[i] compare:arr[i + 1]] == NSOrderedAscending) {
            if (i + 1 < count) i++;
        }
        if ([arr[i] compare:temp] == NSOrderedDescending && i < count) {
            arr[p] = arr[i];
            p = i;
        }
        else {
            break;
        }
    }
    if (p != position) {
        arr[p] = temp;
    }
}

#pragma mark -- 计数排序

void countingOrderSortWithArray(unsigned int arr[], int count) {
    
    if (count <= 0) return;
    
    unsigned int max = arr[0];
    for (int i = 0; i < count; i++) {
        if (arr[i] > max) {
            max = arr[i];
        }
    }
    
    int *bucket = (int *)calloc(max + 1, sizeof(int));
    for (int i = 0; i < count; i++) {
        (bucket[arr[i]])++;
    }
    
    int index = 0;
    for (int i = 0; i < max + 1; i++) {
        while (bucket[i] > 0) {
            arr[index] = i;
            index++;
            bucket[i]--;
        }
    }
    free(bucket);
}

#pragma mark -- 桶排序

#define kGreater(A,B) [A compare:B] == NSOrderedDescending
#define kLess(A,B) [A compare:B] == NSOrderedAscending

NSArray<NSNumber *> *bucketOrderSortWithArray(NSArray<NSNumber *> *arr) {
    if (arr.count <= 0) return arr;
    
    NSNumber *max = arr[0], *min = arr[0];
    for (NSNumber *num in arr) {
        if (kGreater(num, max)) {
            max = num;
        }
        else if (kLess(num, min)) {
            min = num;
        }
    }
    
    int bucketCount = ([max intValue] - [min intValue])/10 + 1;
    
    NSMutableArray<NSMutableArray<NSNumber *> *> *buckets = [NSMutableArray arrayWithCapacity:bucketCount];
    for (int i = 0; i < bucketCount; i++) {
        [buckets addObject:[NSMutableArray array]];
    }
    for (NSNumber *num in arr) {
        int index = ([num intValue] - [min intValue])/10;
        NSMutableArray *tempArr = buckets[index];
        [tempArr addObject:num];
    }
    
    NSMutableArray *results = [NSMutableArray arrayWithCapacity:arr.count];
    for (NSMutableArray *arr in buckets) {
        insertionOrderSortWithArray(arr);
        [results addObjectsFromArray:arr];
    }
    return results.copy;
}

NSArray<NSNumber *> *radixOrderSortWithArray(NSArray<NSNumber *> *arr) {
    if (arr.count <= 0) return arr;
    int max = [arr[0] intValue], index = 1;//index表示当前是按照数据那一位排序，1表示个位，2表示百位
    for (NSNumber *num in arr) {
        if (num.intValue > max) max = num.intValue;
    }
    
    NSMutableArray<NSNumber *> *a = [NSMutableArray arrayWithArray:arr];
    
    NSMutableArray<NSMutableArray<NSNumber *> *> *buckets = [NSMutableArray arrayWithCapacity:10];
    for (int i = 0; i < 10; i++) {
        NSMutableArray<NSNumber *> *temp = [NSMutableArray array];
        buckets[i] = temp;
    }
    while (max > 1) {
        
        for (NSNumber *num in a) {
            int n = num.intValue;
            NSMutableArray<NSNumber *> *bucket = buckets[n%(10 * index)/index];
            [bucket addObject:num];
        }
        
        [a removeAllObjects];
        for (NSMutableArray<NSNumber *> *bucket  in buckets) {
            [a addObjectsFromArray:bucket];
            [bucket removeAllObjects];
        }
        
        index = index * 10;
        max = max/10;
    }
    
    return a.copy;
}


