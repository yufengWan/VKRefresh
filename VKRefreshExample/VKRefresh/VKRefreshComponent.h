//
//  VKRefreshComponent.h
//  VKRefreshExample
//
//  Created by ci123 on 15/12/21.
//  Copyright © 2015年 vokie. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, VKRefreshState) {
    VKRefreshStateIdle = 1,   //普通状态
    VKRefreshStatePulling,   //拉伸状态
    VKRefreshStateRefreshing  //正在刷新
};

@interface VKRefreshComponent : UIView

@property (nonatomic, weak) UIScrollView *scrollView;
//头部刷新时的回调block
@property (nonatomic, copy) void (^headerRefreshing)();

//脚部刷新时的回调block
@property (nonatomic, copy) void (^footerRefreshing)();

- (void)endRefreshing;

- (void)beginRefreshing;

@end