//
//  RefreshFooter.m
//  TableViewRefresh
//
//  Created by 郭超 on 16/12/9.
//  Copyright © 2016年 郭超. All rights reserved.
//

#import "RefreshFooter.h"

@implementation RefreshFooter
-(id)initWithTarget:(id)target refreshSelector:(SEL)refreshSelector{
    
    if (self =[super init]) {
        
        self.refreshSelector =refreshSelector;
        
        self.target =target;
    }
    
    return self;
}
@end
