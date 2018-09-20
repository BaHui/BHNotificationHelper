//
//  BHNotificationHelper.m
//  BHDemo
//
//  Created by QiaoBaHui on 2018/9/20.
//  Copyright © 2018年 QiaoBaHui. All rights reserved.
//

#import "BHNotificationHelper.h"
#import <objc/runtime.h>

@interface NSObject ()

@property (nonatomic, strong) NSMutableArray *helperObserverInfos;

@end

static void *observers_key = &observers_key;

static NSString *const ObserverInfoNameKey = @"Name";
static NSString *const ObserverInfoObserverKey = @"Observer";

@implementation NSObject (BHNotificationHelper)

- (void)addNotificationForName:(NSString *)notificationName response:(void (^)(NSDictionary * userInfo))response {
  id observer = [[NSNotificationCenter defaultCenter] addObserverForName:notificationName object:nil queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification * _Nonnull note) {
    if (response) {
      response(note.userInfo);
    }
  }];

  [self addHelperObserverInfo:[self assembleObserverInfoWithNotificationName:notificationName observer:observer]];
}

- (void)removeNotificationForName:(NSString *)notificationName {
  [self.helperObserverInfos enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    if ([notificationName isEqualToString:[obj objectForKey:ObserverInfoNameKey]]) {
      [[NSNotificationCenter defaultCenter] removeObserver:[obj objectForKey:ObserverInfoObserverKey]];
    }
  }];
}

- (void)postNotificationForName:(NSString *)notificationName userInfo:(NSDictionary *)userInfo {
  [[NSNotificationCenter defaultCenter] postNotificationName:notificationName object:self userInfo:userInfo];
}

#pragma mark - Overwrite Load Method

+ (void)load {
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    SEL systemDeallocSelector = NSSelectorFromString(@"dealloc");
    SEL helperDeallocSelector = @selector(helper_dealloc);

    Class class = [self class];
    Method systemDeallocMethod = class_getInstanceMethod(class, systemDeallocSelector);
    Method helperDeallocMethod = class_getInstanceMethod(class, helperDeallocSelector);

    // 动态添加方法
    BOOL addMethodSucceed = class_addMethod(class, systemDeallocSelector, method_getImplementation(helperDeallocMethod), method_getTypeEncoding(helperDeallocMethod));
    if (addMethodSucceed) {
      class_replaceMethod(class, helperDeallocSelector, method_getImplementation(systemDeallocMethod), method_getTypeEncoding(systemDeallocMethod));
    } else {
      method_exchangeImplementations(systemDeallocMethod, helperDeallocMethod);
    }
  });
}

- (void)helper_dealloc {
  if (self.helperObserverInfos) {
    [self.helperObserverInfos enumerateObjectsUsingBlock:^(id _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
      [[NSNotificationCenter defaultCenter] removeObserver:[obj objectForKey:ObserverInfoObserverKey]];
    }];

    [self.helperObserverInfos removeAllObjects];
    self.helperObserverInfos = nil;
  }

  [self helper_dealloc];
}

#pragma mark - Getter & Setter

- (void)setHelperObserverInfos:(NSMutableArray *)helperObserverInfos {
  objc_setAssociatedObject(self, &observers_key, helperObserverInfos, OBJC_ASSOCIATION_RETAIN);
}

- (NSMutableArray *)helperObserverInfos {
  return objc_getAssociatedObject(self, &observers_key);
}

#pragma mark - Private Methods

- (NSDictionary *)assembleObserverInfoWithNotificationName:(NSString *)name observer:(id)observer {
  return @{ObserverInfoNameKey : name, ObserverInfoObserverKey : observer};
}

- (void)addHelperObserverInfo:(NSDictionary *)observerInfo {
  if (!self.helperObserverInfos) {
    self.helperObserverInfos = [NSMutableArray new];
  }

  [self.helperObserverInfos addObject:observerInfo];
}

@end
