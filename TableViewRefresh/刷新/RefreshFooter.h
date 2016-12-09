//
//  RefreshFooter.h
//  TableViewRefresh
//
//  Created by 郭超 on 16/12/9.
//  Copyright © 2016年 郭超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RefreshFooter : NSObject
@property (nonatomic ,weak)id target;
@property (nonatomic ,assign)SEL refreshSelector;
-(id)initWithTarget:(id)target refreshSelector:(SEL)refreshSelector;
@end
