//
//  ProgoressView.m
//  圆形渐变下载框
//
//  Created by 郭超 on 2017/5/2.
//  Copyright © 2017年 郭超. All rights reserved.
//

#import "ProgressView.h"

@interface ProgressView()<CAAnimationDelegate>
{
    int _oldPregress;
    int _nowProgress;
    CAShapeLayer * shapeLayer3;
    NSTimer * _timer;
}
@property(nonatomic,strong)CAGradientLayer * gradLayerL;
@property(nonatomic,strong)CAGradientLayer * gradLayerL2;
@end
@implementation ProgressView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self =[super initWithFrame:frame]) {
        _oldPregress = 0;
        _nowProgress = 0;
    }
    
    return self;
}

-(void)setColors:(NSArray *)colors
{
    _colors =colors;
    
    CAShapeLayer * shapeLayer =[[CAShapeLayer alloc]init];
    shapeLayer.frame =CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    shapeLayer.position = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    UIBezierPath * calvePath =[UIBezierPath bezierPathWithArcCenter:shapeLayer.position radius:self.bounds.size.width/2 startAngle:-M_PI_2 endAngle:M_PI_2*3 clockwise:YES];
    shapeLayer.path = calvePath.CGPath;
    [self.layer addSublayer:shapeLayer];
    //创建渐变颜色
    _gradLayerL = [CAGradientLayer layer];
    _gradLayerL.bounds = CGRectMake(0, 0, self.bounds.size.width/2, self.bounds.size.height);
    _gradLayerL.locations = @[@0.2];
    [_gradLayerL setColors:@[(id)[UIColor redColor].CGColor,(id)[UIColor purpleColor].CGColor]];
    _gradLayerL.position = CGPointMake(_gradLayerL.bounds.size.width/2, _gradLayerL.bounds.size.height/2);
    [self.layer addSublayer:_gradLayerL];
    
    _gradLayerL2 = [CAGradientLayer layer];
    _gradLayerL2.bounds = CGRectMake(self.bounds.size.width/2, 0, self.bounds.size.width/2, self.bounds.size.height);
    _gradLayerL2.locations = @[@0.2];
    [_gradLayerL2 setColors:@[(id)[UIColor blueColor].CGColor,(id)[UIColor greenColor].CGColor]];
    _gradLayerL2.position = CGPointMake(_gradLayerL2.bounds.size.width/2+_gradLayerL2.bounds.size.width, _gradLayerL2.bounds.size.height/2);
    [self.layer addSublayer:_gradLayerL2];
    //截取外圆框
    [self.layer setMask:shapeLayer];
    
    CAShapeLayer * shapeLayer2 =[[CAShapeLayer alloc]init];
    shapeLayer2.frame =CGRectMake(-2, -2, self.bounds.size.width, self.bounds.size.height);
    shapeLayer2.backgroundColor = [UIColor clearColor].CGColor;
    shapeLayer2.position = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    UIBezierPath * calvePath2 =[UIBezierPath bezierPathWithArcCenter:shapeLayer2.position radius:self.bounds.size.width/2-4 startAngle:-M_PI_2 endAngle:M_PI_2*3 clockwise:YES];
    shapeLayer2.path = calvePath2.CGPath;
    shapeLayer2.fillColor = [UIColor whiteColor].CGColor;
    shapeLayer2.lineWidth = 4;
    shapeLayer2.strokeColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:shapeLayer2];
 
    shapeLayer3 =[[CAShapeLayer alloc]init];
    shapeLayer3.frame =CGRectMake(-2, -2, self.bounds.size.width, self.bounds.size.height);
    shapeLayer3.backgroundColor = [UIColor clearColor].CGColor;
    shapeLayer3.position = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    UIBezierPath * calvePath3 =[UIBezierPath bezierPathWithArcCenter:shapeLayer2.position radius:self.bounds.size.width/2-2 startAngle:-M_PI_2 endAngle:M_PI_2*3 clockwise:YES];
    shapeLayer3.path = calvePath3.CGPath;
     shapeLayer3.lineCap = kCALineCapRound;
    shapeLayer3.fillColor = [UIColor clearColor].CGColor;
    shapeLayer3.lineWidth = 4;
    shapeLayer3.strokeColor = [UIColor clearColor].CGColor;
    [self.layer addSublayer:shapeLayer3];
    //显示进度的label
    _progressLabel =[[UILabel alloc]initWithFrame:CGRectMake(shapeLayer3.lineWidth *2, self.bounds.size.height/2-10, self.bounds.size.width - shapeLayer3.lineWidth *4, 20)];
    _progressLabel.textAlignment =NSTextAlignmentCenter;
    [self addSubview:_progressLabel];
}

-(void)setProgressValue:(float)progressValue{
     shapeLayer3.strokeColor = [UIColor grayColor].CGColor;
    _oldPregress = _nowProgress;
    _nowProgress =(int)(progressValue*100);
    _progressValue = progressValue;
    
    CABasicAnimation * animation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    animation.fromValue =@(_oldPregress/100.0);
    animation.toValue = @(progressValue);
    animation.duration =2;
    animation.delegate=self;
    animation.removedOnCompletion = NO;
    animation.fillMode =kCAFillModeForwards;
    [shapeLayer3 addAnimation:animation forKey:nil];
    NSString * num =[NSString stringWithFormat:@"%d",_nowProgress -_oldPregress];
    if ([num isEqualToString:@"0"]) {
        return;
    }
    _timer =[NSTimer scheduledTimerWithTimeInterval:(2/ABS([num floatValue])) target:self selector:@selector(updateProgress) userInfo:nil repeats:YES];
    [_timer fire];
}
-(void)updateProgress
{
    if (_oldPregress >=_nowProgress) {
        _oldPregress =_oldPregress -1;
    }else{
    _oldPregress =_oldPregress +1;
    }
    
    NSString * symbol =@"%";
    _progressLabel.text = [NSString stringWithFormat:@"%d%@",_oldPregress,symbol];
    if (_oldPregress == _nowProgress) {
        _timer.fireDate = [NSDate distantFuture];
        [_timer invalidate];
        _timer =nil;
    }
}
@end
