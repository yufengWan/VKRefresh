//
//  ViewController.m
//  VKRefreshExample
//
//  Created by ci123 on 15/12/21.
//  Copyright © 2015年 vokie. All rights reserved.
//

#import "ViewController.h"
#import "VKRefresh.h"

@interface ViewController()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *refreshTableView;
@property (nonatomic, retain) NSMutableArray *dataArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.refreshTableView.delegate = self;
    self.refreshTableView.dataSource = self;
    
    self.dataArray = [NSMutableArray array];
    
    for (NSInteger i = 1; i <= 20; i++) {
        [self.dataArray addObject:[NSString stringWithFormat:@"%ld", i]];
    }
    
    //添加刷新头部
    [self.refreshTableView vk_addRefreshHeader];
//    self.refreshTableView.vkHeader.textIdleState = @"拉我一把呀";
//    self.refreshTableView.vkHeader.textPullingState = @"别拉我啦";
//    self.refreshTableView.vkHeader.textRefreshingState = @"奔跑加载中";
    
    [self.refreshTableView.vkHeader beginRefreshing];
    
    self.refreshTableView.vkHeader.headerRefreshing = ^{
        //假装在请求数据
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.dataArray insertObject:@"header_1001" atIndex:0];
            [self.dataArray insertObject:@"header_1002" atIndex:0];
            [self.dataArray insertObject:@"header_1003" atIndex:0];
            [self.refreshTableView reloadData];
            
            //数据请求结束，停止头部刷新
            [self.refreshTableView.vkHeader endRefreshing];
        });
    };
    
    //添加刷新脚部
    [self.refreshTableView vk_addRefreshFooter];
//    self.refreshTableView.vkFooter.textIdleState = @"继续上拉我";
//    self.refreshTableView.vkFooter.textPullingState = @"松开我吧";
//    self.refreshTableView.vkFooter.textRefreshingState = @"火速加载中";
    
    self.refreshTableView.vkFooter.footerRefreshing = ^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.dataArray addObject:@"footer_9991"];
            [self.dataArray addObject:@"footer_9992"];
            [self.dataArray addObject:@"footer_9993"];
            [self.refreshTableView reloadData];
            
            //数据请求结束，停止脚部刷新
            [self.refreshTableView.vkFooter endRefreshing];
        });
    };
    
    
    self.refreshTableView.rowHeight = 40;
    [self.refreshTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CellIdentifier"];
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView {

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellIdentifier" forIndexPath:indexPath];
    
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CellIdentifier"];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"数据：%@", self.dataArray[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
