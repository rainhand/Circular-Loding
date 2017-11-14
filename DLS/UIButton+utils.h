//
//  UIButton+utils.h
//  DLS
//
//  Created by 郭超 on 2017/4/25.
//  Copyright © 2017年 郭超. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ButtonUtil : NSObject

/**
 通过Block传递需要的参数，然后返回值是ButtonUtil，可以继续调用下一个属性
 */
@property(nonatomic, weak,readonly)ButtonUtil * (^contentEdgInset)(UIEdgeInsets *contentEdgeInset);
@property(nonatomic, weak,readonly)ButtonUtil * (^showsTouchWhenHighlighte)(BOOL showsTouchWhenHighlighte);
@property(nonatomic, weak,readonly)ButtonUtil * (^tintColo)(UIColor * tintColo);
@property(nonatomic, weak,readonly)ButtonUtil * (^titl)(NSString * title, UIControlState  state);
@property(nonatomic, weak,readonly)ButtonUtil * (^titleColo)(UIColor * color, UIControlState  state);
@property(nonatomic, weak,readonly)ButtonUtil * (^shadowColo)(UIColor * color, UIControlState  state);
@property(nonatomic, weak,readonly)ButtonUtil * (^imag)(UIImage * image, UIControlState  state);
@property(nonatomic, weak,readonly)ButtonUtil * (^backgroundImag)(UIImage * image, UIControlState  state);
@property(nonatomic, weak,readonly)ButtonUtil * (^attributeTitle)(NSAttributedString * title, UIControlState  state);
@property(nonatomic, weak,readonly)ButtonUtil * (^frame)(CGRect rect);

/**
 结尾属性，返回值是UIButton，完成一个button的创建
 */
@property(nonatomic, weak,readonly)UIButton * (^buttonTyp)(UIButtonType typ);
@end

@interface UIButton (utils)
@property(nonatomic,strong ,readonly) ButtonUtil * buttonUtil;

@property(class, nonatomic ,strong,readonly) UIButton * creatButton;


@end
