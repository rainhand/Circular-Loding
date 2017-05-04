//
//  ViewController.m
//  圆形渐变下载框
//
//  Created by 郭超 on 2017/5/2.
//  Copyright © 2017年 郭超. All rights reserved.
//

#import "ViewController.h"
#import "ProgressView.h"
@interface ViewController ()
{
    ProgressView * progress;
}
@property(nonatomic,strong)NSArray * colors;
@property(nonatomic,strong)NSArray * locations;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    progress =[[ProgressView alloc]initWithFrame:CGRectMake(100, 200, 100, 100)];
    [self.view addSubview:progress];
    progress.colors = @[@""];
    progress.progressValue = 0.8;
    
    UIButton * button =[UIButton buttonWithType:(UIButtonTypeCustom)];
    button.frame =CGRectMake(100, 500, 50, 50);
    [button setBackgroundColor:[UIColor greenColor]];
    [button setTitle:@"改变" forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(changeClcik) forControlEvents:(UIControlEventTouchDown)];
    [self.view addSubview:button];
}
-(void)changeClcik
{
    progress.progressValue = arc4random()%100/100.0;
}


@end
