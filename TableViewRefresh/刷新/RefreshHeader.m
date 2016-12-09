//
//  RefreshHeader.m
//  TableViewRefresh
//
//  Created by 郭超 on 16/12/8.
//  Copyright © 2016年 郭超. All rights reserved.
//

#import "RefreshHeader.h"

@implementation RefreshHeader
-(id)initWithTarget:(id)target refreshSelector:(SEL)refreshSelector{
    
    if (self =[super init]) {
        
        self.refreshSelector =refreshSelector;
        
        self.target =target;
    }
    
    return self;
}
@end
