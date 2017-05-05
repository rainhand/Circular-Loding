//
//  UIButton+utils.m
//  DLS
//
//  Created by 郭超 on 2017/4/25.
//  Copyright © 2017年 郭超. All rights reserved.
//

#import "UIButton+utils.h"
@interface ButtonUtil()
@property(nonatomic,strong)UIButton *button;
@end

@implementation ButtonUtil
-(ButtonUtil *(^)(CGRect))frame
{
    return  ^(CGRect frame)
    {
        self.button.frame =frame;
        return self;
    };
}

-(ButtonUtil *(^)(NSString *, UIControlState))titl
{
   return ^(NSString * str ,UIControlState state)
    {
        [self.button setTitle:str forState:state];
        return self;
    };
}

-(UIButton *(^)(UIButtonType))buttonTyp{

    return ^(UIButtonType type){
        
        return self.button;
    };
}


@end

@implementation UIButton (utils)

static ButtonUtil *_maker = nil;
-(ButtonUtil *)buttonUtil{
    return _maker;
}

+(UIButton *)creatButton
{
    ButtonUtil * util =[[ButtonUtil alloc]init];
    _maker = util;
    _maker.button = [[UIButton alloc]init];
    return _maker.button;
}
@end
