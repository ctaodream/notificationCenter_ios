//
//  SNotificationCenter.h
//  NotificationCenter
//
//  Created by ct on 15/12/15.
//  Copyright © 2015年 ct. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SNotificationObserverDelegate;
@interface SNotificationCenter : NSObject

+(instancetype)defaultCenter;


/**
 *  注册消息监听器 (可以一次注册多种消息)
 *
 *  @param observer          需要监听消息的对象  该对象必须实现协议 SNotificationObserverDelegate
 *  @param notificationNames 一连串的消息名 可以一次性注册监听多种通知  如果只需监听一个 可以用下面的
 */
-(void)registerNotificationObserver:(id<SNotificationObserverDelegate>)observer names:(NSArray *)notificationNames;

/**
 *  注册消息监听器
 *
 *  @param observer         需要监听消息的对象  该对象必须实现协议 SNotificationObserverDelegate
 *  @param notificationName 消息名
 */
-(void)registerNotificationObserver:(id<SNotificationObserverDelegate>)observer name:(NSString *)notificationName;


/**
 *  取消消息监听
 *
 *  @param observer          需要监听消息的对象  该对象必须实现协议 SNotificationObserverDelegate
 *  @param notificationNames 一连串的消息名 可以一次性取消监听多种通知  如果只需取消监听一种消息 可以用下面的
 */
-(void)unregisterNotificationObserver:(id<SNotificationObserverDelegate>)observer names:(NSArray *)notificationNames;


/*
 *  取消消息监听
 *
 *  @param observer         需要监听消息的对象  该对象必须实现协议 SNotificationObserverDelegate
 *  @param notificationName 消息名
 */
-(void)unregisterNotificationObserver:(id<SNotificationObserverDelegate>)observer name:(NSString *)notificationName;

/**
 *  发送消息
 *
 *  @param notificationName 消息名
 *  @param object           发送消息时需要带的参数
 */
-(void)dispatchNotification:(NSString *)notificationName object:(id)object;

@end


@protocol SNotificationObserverDelegate <NSObject>

@required
/**
 *  接收消息
 *
 *  @param notificationName 消息名
 *  @param object           消息需要带的参数
 */
-(void)didReceivedNotification:(NSString *)notificationName object:(id)object;

@end