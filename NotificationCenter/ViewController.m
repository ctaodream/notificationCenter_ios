//
//  ViewController.m
//  NotificationCenter
//
//  Created by ct on 15/12/15.
//  Copyright © 2015年 ct. All rights reserved.
//

#import "ViewController.h"
#import "SNotificationCenter.h"
#import "BViewController.h"
@interface ViewController () <SNotificationObserverDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.title = @"A";
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 50, 50)];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(doPress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    [[SNotificationCenter defaultCenter]registerNotificationObserver:self name:kTestNotification];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)dealloc{
    // 这一句其实可以不用写  默认改viewcontroller 释放的时候 会移除
    [[SNotificationCenter defaultCenter]unregisterNotificationObserver:self name:kTestNotification];
}

-(void)doPress{
    BViewController *b = [[BViewController alloc]init];
    [self.navigationController pushViewController:b animated:YES];
}

#pragma mark -- SNotificationObserverDelegate
-(void)didReceivedNotification:(NSString *)notificationName object:(id)object{
    
    NSLog(@"notification name : %@",notificationName);
    NSLog(@"notification object : %@",object);
    
    
    
    
    
}
@end
