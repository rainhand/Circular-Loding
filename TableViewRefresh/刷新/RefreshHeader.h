//
//  RefreshHeader.h
//  TableViewRefresh
//
//  Created by 郭超 on 16/12/8.
//  Copyright © 2016年 郭超. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RefreshHeader : NSObject
@property (nonatomic ,weak)id target;
@property (nonatomic ,assign)SEL refreshSelector;
-(id)initWithTarget:(id)target refreshSelector:(SEL)refreshSelector;
@end
