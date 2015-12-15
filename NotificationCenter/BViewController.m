//
//  BViewController.m
//  NotificationCenter
//
//  Created by ct on 15/12/15.
//  Copyright © 2015年 ct. All rights reserved.
//

#import "BViewController.h"
#import "SNotificationCenter.h"

@interface BViewController ()

@end

@implementation BViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"B";
    
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 50, 50)];
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(doPress) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)doPress{
    [[SNotificationCenter defaultCenter] dispatchNotification:kTestNotification object:@{@"test":@"this is a test"}];
    
    
//    [self.navigationController popViewControllerAnimated:YES];
}




@end
