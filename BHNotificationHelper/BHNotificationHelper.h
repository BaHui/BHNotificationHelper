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

/**
 * 添加通知
 * @param notificationName 通知名称
 * @param response 收到通知的响应
 */
- (void)addNotificationForName:(NSString *)notificationName response:(void (^)(NSDictionary * userInfo))response;

/**
 * 移除某个通知
 * @param notificationName 被移除的通知的名字
 */
- (void)removeNotificationForName:(NSString *)notificationName;

/**
 * 发送通知
 @param notificationName 通知名称
 @param userInfo 通知传值对象
 */
- (void)postNotificationForName:(NSString *)notificationName userInfo:(NSDictionary *)userInfo;

@end
