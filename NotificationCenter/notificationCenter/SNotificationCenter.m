//
//  SNotificationCenter.m
//  NotificationCenter
//
//  Created by ct on 15/12/15.
//  Copyright © 2015年 ct. All rights reserved.
//

#import "SNotificationCenter.h"

@interface SNotificationCenter ()

@property(nonatomic,strong)NSMutableDictionary *notificationObserverDictionary;

@end

@implementation SNotificationCenter


#pragma mark -- lifecycle

+(instancetype)defaultCenter{
    static dispatch_once_t onceToken;
    static SNotificationCenter *defaultCenter;
    dispatch_once(&onceToken, ^{
        defaultCenter = [[SNotificationCenter alloc]init];
        [defaultCenter configure];
    });
    
    return defaultCenter;
}

-(void)dealloc{
    _notificationObserverDictionary = nil;
}


#pragma mark -- private
//初始化一些必要参数
-(void)configure{
    _notificationObserverDictionary = [[NSMutableDictionary alloc]init];
}


#pragma mark -- public
/**
 *  注册消息监听器 (可以一次注册多种消息)
 *
 *  @param observer          需要监听消息的对象  该对象必须实现协议 SNotificationObserverDelegate
 *  @param notificationNames 一连串的消息名 可以一次性注册监听多种通知  如果只需监听一个 可以用下面的
 */
-(void)registerNotificationObserver:(id<SNotificationObserverDelegate>)observer names:(NSArray *)notificationNames{
    for (NSString *notificationName in notificationNames) {
        [self registerNotificationObserver:observer name:notificationName];
    }
}

/**
 *  注册消息监听器
 *
 *  @param observer         需要监听消息的对象  该对象必须实现协议 SNotificationObserverDelegate
 *  @param notificationName 消息名
 */
-(void)registerNotificationObserver:(id<SNotificationObserverDelegate>)observer name:(NSString *)notificationName{
    NSHashTable *notificationObserverTable = [_notificationObserverDictionary objectForKey:notificationName];
    if (notificationObserverTable == nil) {
        notificationObserverTable = [NSHashTable weakObjectsHashTable];
        [_notificationObserverDictionary setObject:notificationObserverTable forKey:notificationName];
    }
    if ([notificationObserverTable containsObject:observer]) {
        return;
    }
    [notificationObserverTable addObject:observer];
}

/**
 *  取消消息监听
 *
 *  @param observer          需要监听消息的对象  该对象必须实现协议 SNotificationObserverDelegate
 *  @param notificationNames 一连串的消息名 可以一次性取消监听多种通知  如果只需取消监听一种消息 可以用下面的
 */
-(void)unregisterNotificationObserver:(id<SNotificationObserverDelegate>)observer names:(NSArray *)notificationNames{
    for (NSString *notificationName in notificationNames) {
        [self unregisterNotificationObserver:observer name:notificationName];
    }
}


/*
 *  取消消息监听
 *
 *  @param observer         需要监听消息的对象  该对象必须实现协议 SNotificationObserverDelegate
 *  @param notificationName 消息名
 */
-(void)unregisterNotificationObserver:(id<SNotificationObserverDelegate>)observer name:(NSString *)notificationName{
    NSHashTable *notificationObserverTable = [_notificationObserverDictionary objectForKey:notificationName];
    if (notificationObserverTable == nil) {
        return;
    }
    if ([notificationObserverTable containsObject:observer]) {
        
        [notificationObserverTable removeObject:observer];
    }
}

/**
 *  发送消息
 *
 *  @param notificationName 消息名
 *  @param object           发送消息时需要带的参数
 */
-(void)dispatchNotification:(NSString *)notificationName object:(id)object{
    if (notificationName == nil || [[notificationName stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]isEqualToString:@""]) {
        return;
    }
    
    NSHashTable *notificationObserverTable = [_notificationObserverDictionary objectForKey:notificationName];
    if (notificationObserverTable == nil) {
        return;
    }
    NSEnumerator *enumerator = [notificationObserverTable objectEnumerator];
    id value;
    while ((value = [enumerator nextObject])) {
        if (value != nil && [value conformsToProtocol:@protocol(SNotificationObserverDelegate)]) {
            //执行方法
            [value didReceivedNotification:notificationName object:object];
        }
    }

}

@end
