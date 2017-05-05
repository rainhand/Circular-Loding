//
//  ViewController.m
//  DLS
//
//  Created by 郭超 on 2017/4/20.
//  Copyright © 2017年 郭超. All rights reserved.
//

#import "ViewController.h"
#import "UIButton+utils.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
  /**
   通过Block重写属性以后，可以直接点语法直接赋值属性

   @param @"aaaa" 设置Title
   @param UIControlStateNormal 设置类型
   @return 返回值是一个button
   */
    
  [self.view addSubview: UIButton.
   creatButton.
   buttonUtil.
   titl(@"aaaa", UIControlStateNormal).
   frame(CGRectMake(10, 10, 200, 200)).
   buttonTyp(UIButtonTypeCustom)];
    
}


@end
