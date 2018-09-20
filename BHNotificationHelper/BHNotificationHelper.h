//
//  BHNotificationHelper.h
//  BHDemo
//
//  Created by QiaoBaHui on 2018/9/20.
//  Copyright © 2018年 QiaoBaHui. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BHNotificationName.h"

@interface NSObject (BHNotificationHelper)

// 添加和移除通知
- (void)addNotificationForName:(NSString *)notificationName response:(void (^)(NSDictionary * userInfo))response;
- (void)removeNotificationForName:(NSString *)notificationName;

// 发送通知
- (void)postNotificationForName:(NSString *)notificationName userInfo:(NSDictionary *)userInfo;

@end
