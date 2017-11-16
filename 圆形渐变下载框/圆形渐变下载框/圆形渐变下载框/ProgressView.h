//
//  ProgoressView.h
//  圆形渐变下载框
//
//  Created by 郭超 on 2017/5/2.
//  Copyright © 2017年 郭超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressView : UIView
@property(nonatomic ,strong)NSArray * colors;

@property(nonatomic ,strong)UILabel * progressLabel;
@property(nonatomic, assign)float progressValue;
@end
