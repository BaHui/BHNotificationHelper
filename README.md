## NotificationHelper (iOS通知的封装)

### 简介
>   **NSNotification，是iOS开发中一种重要的设计模式，它的实质是程序内部提供的一种广播机制。把接受到的消息根据内部消息转发表，将消息转发给需要的对象。**

### 特点
```
1. 一句话添加
2. block方式回调;
3. 无需考虑内存泄露.
```

### 涉及知识点:
######  使用Notification最重要的就是要注意内存泄露问题, 在此工具中, 无需使用者考虑内存泄露的问题, 工具中的实现思路是: 
1.建立NSObject的类别; (因为 NSObject 为顶级父类);

2.为NSObject添加一个数组(`helperObserverInfos`)的私有属性, 用来存储当前类(self)的所有Observer;

3.运用runtime动态关联属性, 将数组与self动态关联, 达到属性的拥有.

4.新建一个释放Observe的方法, 运用runtime, 将新建的方法与系统的dealloc方法内部实现交换, 达到移除Observers的目的.

#### 实现代码:
```objectivec
@interface NSObject (BHNotificationHelper)

/**
* 添加通知
* @param notificationName 通知名称
* @param response 收到通知的响应
*/
- (void)addNotificationForName:(NSString *)notificationName response:(void (^)(NSDictionary *userInfo))response;

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
```
### 使用示例

```objectivec
// 添加通知接收
[self addNotificationForName:BHChangeFirstBGColorNFName response:^(NSDictionary *userInfo) {
UIColor *color = [userInfo objectForKey:@"color"];
weakSelf.view.backgroundColor = color;
}];

// 发送通知
[self postNotificationForName:BHChangeFirstBGColorNFName userInfo:@{@"color" : [UIColor redColor]}];
```

-------
```
提示: 可以新建一个Header文件, 统一的管理通知的名称, 如

#ifndef BHNotificationName_h
#define BHNotificationName_h

static NSString *const BHChangeFirstTitleNFName = @"BHChangeFirstTitleNFName"; // 改变第一个界面的标题
static NSString *const BHChangeFirstBGColorNFName = @"BHChangeFirstBGColorNFName"; // 改变第一个界面的背景颜色
static NSString *const BHChangeSecondBGColorNFName = @"BHChangeSecondBGColorNFName"; // 改变第二个界面背景颜色

#endif
```

### 个人对通知的见解:
通知是一个逻辑跨度比较大的概念, 项目中, 使用过多的通知会导致项目的可读性和业务的连贯性变差, 不利于代码维护和他人阅读代码. 建议尽量减少对通知的使用, 或者设计出更优雅的通知架构来妥善的处理项目中的通知. 

### 交流与建议
- GitHub：<https://github.com/BaHui>
- 邮  箱：<qiaobahuiyouxiang@163.com>
