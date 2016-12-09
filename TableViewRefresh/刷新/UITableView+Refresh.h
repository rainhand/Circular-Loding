//
//  UITableView+Refresh.h
//  TableViewRefresh
//
//  Created by 郭超 on 16/12/7.
//  Copyright © 2016年 郭超. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RefreshHeader.h"
#import "RefreshFooter.h"
typedef NS_ENUM(NSInteger,RefreshType) {

    FLRefreshTypeHeader = 1,
    FLRefreshTypeFooter = 1 << 1,
    FLRefreshTypeAll = FLRefreshTypeHeader | FLRefreshTypeFooter
};
typedef  NS_ENUM(NSInteger ,RefreshState)
{
    RefreshStateNormal =1,
    RefreshStateDowning =1<<1,
    RefreshStateUping =1<<2
};
@interface UITableView (Refresh)

@property (nonatomic ,strong)UIView * footerRefreshView;

@property (nonatomic ,strong)UIView * headerRefreshView;

@property (nonatomic ,strong)UILabel *headerRefreshLabel;

@property (nonatomic ,strong)UIImageView * headerRefreshImageView;

@property (nonatomic ,strong)UILabel *footerRefreshLabel;

@property (nonatomic ,strong)UIImageView * footerRefreshImageView;

@property (nonatomic ,assign)float isOffsete;

@property (nonatomic ,assign)BOOL isFirst;
//@property (nonatomic ,weak)id target;

//@property (nonatomic ,assign)SEL headerRefreshSelecoter;
//
//@property (nonatomic ,assign)SEL footerRefreshSelecoter;

@property (nonatomic ,strong)RefreshHeader * refreshHeader;

@property (nonatomic ,strong)RefreshFooter * refreshFooter;

@property (nonatomic)RefreshType type;

@property (nonatomic ,assign)RefreshState refreshState;
-(void)refreshGoBackMessageSelector:(SEL)selector;
-(void)endHeaderRefreshing;
-(void)endFooterRefreshing;
-(void)noMoreDada;
@end
