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
 * 仅用于移除单个通知
 * 提示: 界面释放时, 会自动移除所有的Observer, 无需手动调用.
 * @param notificationName 被移除的通知的名字
 */
- (void)removeNotificationForName:(NSString *)notificationName;

/**
 * 发送通知
 * @param notificationName 通知名称
 * @param userInfo 通知传值
 */
- (void)postNotificationForName:(NSString *)notificationName userInfo:(NSDictionary *)userInfo;

@end
