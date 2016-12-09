//
//  ViewController.m
//  TableViewRefresh
//
//  Created by 郭超 on 16/12/7.
//  Copyright © 2016年 郭超. All rights reserved.
//

#import "ViewController.h"
#import "UITableView+Refresh.h"
#import "RefreshHeader.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSArray * _titles;
}
@property (nonatomic ,strong)UITableView * tableView;
@property (nonatomic ,strong)UILabel * footerLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _titles =@[@"在tableView上加上一个View",@"在tableView上加上一个View",@"在tableView上加上一个View",@"在tableView上加上一个View",@"在tableView上加上一个View",@"在tableView上加上一个View",@"在tableView上加上一个View",@"在tableView上加上一个View",@"在tableView上加上一个View",@"在tableView上加上一个View",@"在tableView上加上一个View",@"在tableView上加上一个View",@"在tableView上加上一个View",@"在tableView上加上一个View",@"在tableView上加上一个View",@"在tableView上加上一个View",@"在tableView上加上一个View",@"在tableView上加上一个View"];
    
    self.view.backgroundColor =[UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
    
    RefreshHeader * refreshHeader =[[RefreshHeader alloc]initWithTarget:self refreshSelector:@selector(gobackMessage)];
    
    self.tableView.refreshHeader =refreshHeader;
 
    self.tableView.type =FLRefreshTypeAll;

    NSTimer * timer =[NSTimer scheduledTimerWithTimeInterval:10 repeats:NO block:^(NSTimer * _Nonnull timer) {
        
        [self.tableView endHeaderRefreshing];
    }];
}
-(void)gobackMessage
{
    NSLog(@"刷新");
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return _titles.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell =[tableView dequeueReusableCellWithIdentifier:@"cee"];
    
    if (cell ==nil) {
        
        cell =[[UITableViewCell alloc]initWithStyle:0 reuseIdentifier:@"cee"];
    }
    
    cell.textLabel.text =_titles[indexPath.row];

    return cell;
}


-(UITableView *)tableView{
   
    if (_tableView ==nil) {
        
        _tableView =[[UITableView alloc]initWithFrame:self.view.frame];
        _tableView.delegate =self;
        _tableView.dataSource =self;

    }
    return _tableView;
}

@end
