//
//  UITableView+Refresh.m
//  TableViewRefresh
//
//  Created by 郭超 on 16/12/7.
//  Copyright © 2016年 郭超. All rights reserved.
//

#import "UITableView+Refresh.h"
#import <objc/runtime.h>

@interface UITableView ()


@end
@implementation UITableView (Refresh)

-(void)setType:(RefreshType)type
{
    
    if (type ==FLRefreshTypeHeader||type ==FLRefreshTypeAll) {
        
        self.headerRefreshView =[[UIView alloc]initWithFrame:CGRectMake(0, -40, self.frame.size.width, 40)];
       // self.headerRefreshView.backgroundColor =[UIColor redColor];

        self.headerRefreshLabel =[[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width/2 +10, 15, 120, 25)];
        self.headerRefreshLabel.text =@"下拉刷新！";
        [self.headerRefreshView addSubview:self.headerRefreshLabel];
        
        self.headerRefreshImageView=[[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width/2 -40, 15, 15, 25)];
        self.headerRefreshImageView.image =[UIImage imageNamed:@"arrow"];
        [self.headerRefreshView addSubview:self.headerRefreshImageView];
        
        
    } if (type ==FLRefreshTypeFooter||type==FLRefreshTypeAll)
    {
        self.footerRefreshView =[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.window.bounds.size.width, 40)];
        
        self.footerRefreshLabel =[[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width/2 , 10, 120, 25)];
        self.footerRefreshLabel.text =@"加载中！";
        [self.footerRefreshView addSubview:self.footerRefreshLabel];
        
        
        self.footerRefreshImageView =[[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width/2-40, 15, 15, 15)];
        self.footerRefreshImageView.image =[UIImage imageNamed:@"1"];
        [self.footerRefreshView addSubview:self.footerRefreshImageView];
        [self animaitionView:self.footerRefreshImageView dutation:0.7 FromeValue:0.0 ToValue:M_PI*2 repeatCount:100];
        self.contentInset =UIEdgeInsetsMake(0, 0, 40, 0);
    
    }
    //这是KVO监听
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    
    [self addObserver:self forKeyPath:@"contentOffset" options:options context:nil];
    [self addObserver:self forKeyPath:@"contentSize" options:options context:nil];
    [self addObserver:self forKeyPath:@"panGestureRecognizer.state" options:options context:nil];
    
    self.refreshState =RefreshStateNormal;
    
  //  self.isOffsete =0.0;
}
//KVO监听回调函数
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{

    if ([keyPath isEqualToString:@"contentOffset"]) {
 
        [self contentOffsetChange];

    }else if ([keyPath isEqualToString:@"contentSize"])
    {
     
    }else if ([keyPath isEqualToString:@"panGestureRecognizer.state"])
    {
        
    }
}
//KVO检测函数
-(void)contentOffsetChange
{

    //刷新中直接返回
    if (self.refreshState ==RefreshStateDowning||self.refreshState==RefreshStateUping) {
        return;
    }
    
    if (self.contentOffset.y<-40&&self.panGestureRecognizer.state ==UIGestureRecognizerStatePossible&&self.refreshHeader!=nil) {
        
        self.refreshState =RefreshStateDowning;
    }

    if (self.contentOffset.y<self.isOffsete&&self.contentOffset.y<=-40&&self.panGestureRecognizer.state ==UIGestureRecognizerStateChanged) {
        
        self.headerRefreshLabel.text =@"松开即刷新";
        
        if (!self.isFirst) {

            [self animaitionView:self.headerRefreshImageView dutation:0.2 FromeValue:0.0 ToValue:M_PI repeatCount:0];
        }
        self.isFirst =YES;
        
    }else if (self.contentOffset.y>self.isOffsete&&self.contentOffset.y>-40&&self.panGestureRecognizer.state==UIGestureRecognizerStateChanged)
    {
        self.headerRefreshLabel.text =@"下拉刷新";
        
        if (self.isFirst) {

            [self animaitionView:self.headerRefreshImageView dutation:0.2 FromeValue:M_PI ToValue:0.0 repeatCount:0];
        }
        
        self.isFirst =NO;
    }
    
    self.isOffsete =self.contentOffset.y;
    
    //上拉加载
    if ((self.contentOffset.y+self.bounds.size.height>self.contentSize.height)&&self.refreshFooter!=nil)
    {
        self.refreshState =RefreshStateUping;
    }

}

//停止刷新
-(void)endHeaderRefreshing{
    
    if (self.refreshState ==RefreshStateDowning) {

     [UIView animateWithDuration:0.5 animations:^{
         
        self.contentInset =UIEdgeInsetsMake(0, 0, 40, 0);
     }];
     
     self.headerRefreshLabel.text =@"下拉刷新";
    
     [self animaitionView:self.headerRefreshImageView dutation:0.2 FromeValue:-M_PI ToValue:0.0 repeatCount:0];
    
     self.refreshState =RefreshStateNormal;
    }
}
-(void)endFooterRefreshing
{
    if (self.refreshState ==RefreshStateUping) {
    
     self.refreshState =RefreshStateNormal;
    }
}
-(void)noMoreDada{
    
     self.footerRefreshImageView.hidden =YES;

     self.footerRefreshLabel.text =@"加载完毕！";
}

-(BOOL)isFirst
{
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

-(void)setIsFirst:(BOOL)isFirst{
    
    objc_setAssociatedObject(self, @selector(isFirst), @(isFirst), OBJC_ASSOCIATION_RETAIN);
}

-(float)isOffsete
{
    return [objc_getAssociatedObject(self, _cmd) floatValue];
}
-(void)setIsOffsete:(float)isOffsete{
    objc_setAssociatedObject(self, @selector(isOffsete), @(isOffsete), OBJC_ASSOCIATION_RETAIN);
}

-(RefreshState)refreshState
{
    return [objc_getAssociatedObject(self, _cmd) integerValue];
}

-(void)setRefreshState:(RefreshState)refreshState
{
    objc_setAssociatedObject(self, @selector(refreshState), @(refreshState), OBJC_ASSOCIATION_RETAIN);
    
    if (refreshState ==RefreshStateDowning) {

       self.contentInset =UIEdgeInsetsMake(40, 0, 40, 0);
       [self.refreshHeader.target performSelector:self.refreshHeader.refreshSelector withObject:nil afterDelay:0];
        self.headerRefreshLabel.text =@"刷新中!";
        
        if (self.refreshFooter!=nil) {
            self.footerRefreshImageView.hidden =NO;
            self.footerRefreshLabel.text =@"加载中";
        }
    }else if (refreshState ==RefreshStateUping){
    
        [self.refreshFooter.target performSelector:self.refreshFooter.refreshSelector withObject:nil afterDelay:0];
        
    }else if (refreshState ==RefreshStateNormal)
    {
  
    }
    
}
-(RefreshFooter *)refreshFooter
{
    return objc_getAssociatedObject(self, _cmd);
}
-(void)setRefreshFooter:(RefreshFooter *)refreshFooter{
    objc_setAssociatedObject(self, @selector(refreshFooter), refreshFooter, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(RefreshHeader *)refreshHeader
{
    return objc_getAssociatedObject(self, _cmd);
}
-(void)setRefreshHeader:(RefreshHeader *)refreshHeader{
    objc_setAssociatedObject(self, @selector(refreshHeader), refreshHeader, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIImageView*)headerRefreshImageView{
    
    return objc_getAssociatedObject(self, _cmd);
}
-(void)setHeaderRefreshImageView:(UIImageView *)headerRefreshImageView{

    objc_setAssociatedObject(self, @selector(headerRefreshImageView), headerRefreshImageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UIImageView*)footerRefreshImageView{
    
    return objc_getAssociatedObject(self, _cmd);
}
-(void)setFooterRefreshImageView:(UIImageView *)footerRefreshImageView{
    
    objc_setAssociatedObject(self, @selector(footerRefreshImageView), footerRefreshImageView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(UILabel *)footerRefreshLabel{
    
    return objc_getAssociatedObject(self, _cmd);
}
-(void)setFooterRefreshLabel:(UILabel *)footerRefreshLabel{
 
    objc_setAssociatedObject(self, @selector(footerRefreshLabel), footerRefreshLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    footerRefreshLabel.font =[UIFont systemFontOfSize:12];
    
    footerRefreshLabel.textColor =[UIColor grayColor];
    
    footerRefreshLabel.textAlignment =NSTextAlignmentLeft;
    
}

-(UILabel *)headerRefreshLabel{
   
    return objc_getAssociatedObject(self, _cmd);
}
-(void)setHeaderRefreshLabel:(UILabel *)headerRefreshLabel{
 
    objc_setAssociatedObject(self, @selector(headerRefreshLabel), headerRefreshLabel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    headerRefreshLabel.font =[UIFont systemFontOfSize:12];
    
    headerRefreshLabel.textColor =[UIColor grayColor];
    
    headerRefreshLabel.textAlignment =NSTextAlignmentLeft;
}


-(UIView*)headerRefreshView
{
    return objc_getAssociatedObject(self, _cmd);
}
-(void)setHeaderRefreshView:(UIView *)headerRefreshView{
    
    objc_setAssociatedObject(self, @selector(headerRefreshView), headerRefreshView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
     [self addSubview:self.headerRefreshView];
}


-(UIView*)footerRefreshView
{
    return objc_getAssociatedObject(self, _cmd);
}
-(void)setFooterRefreshView:(UIView *)footerRefreshView
{
    objc_setAssociatedObject(self, @selector(footerRefreshView), footerRefreshView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self addSubview:self.footerRefreshView];
    
}

-(void)animaitionView:(UIView *)view dutation:(CGFloat)duration FromeValue:(CGFloat)fromeValue ToValue:(CGFloat)toValue repeatCount:(NSInteger)repeatCount
{
    CABasicAnimation *animation =  [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    
    animation.fromValue = [NSNumber numberWithFloat:fromeValue];
    
    animation.toValue =  [NSNumber numberWithFloat: toValue];
    
    animation.duration  = duration;
    
    animation.repeatCount =repeatCount ==100?HUGE_VALF :1;
    
    [animation setRemovedOnCompletion:NO];
    
    animation.fillMode =kCAFillModeForwards;
    
    [view.layer addAnimation:animation forKey:nil];
}
-(void)setContentSize:(CGSize)contentSize
{
    [super setContentSize:contentSize];
    
    CGRect frame =self.footerRefreshView.frame;
    frame.origin.y =contentSize.height;
    self.footerRefreshView.frame =frame;
}

@end
