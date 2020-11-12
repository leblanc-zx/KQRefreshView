//
//  CustomRefreshHeader.m
//  SharedMJRefresh
//
//  Created by 房房信 on 17/1/5.
//  Copyright © 2017年 Team. All rights reserved.
//

#import "CustomRefreshHeader.h"

@interface CustomRefreshHeader ()

@end

@implementation CustomRefreshHeader

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)prepare
{
    [super prepare];
    self.lastUpdatedTimeLabel.hidden = YES;
    self.mj_h = MJRefreshHeaderHeight;
}

- (void)placeSubviews
{
    [super placeSubviews];
}

- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change {
    
    if (self.state == MJRefreshStatePulling) {// 松开就可以进行刷新的状态
        self.isDragToRefresh = YES;
    } else if (self.state == MJRefreshStateRefreshing) {// 刷新中
        
    } else {// 其它状态
        self.isDragToRefresh = NO;
    }
    
    [super scrollViewContentOffsetDidChange:change];
}

- (void)beginRefreshing {
    NSLog(@"isDragToRefresh==%@", self.isDragToRefresh == YES ? @"YES" : @"NO");
    if ([self.superview isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)self.superview;
        [tableView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:NO];
    }
    [super beginRefreshing];
}

- (void)endRefreshing {
    self.isDragToRefresh = NO;
    [super endRefreshing];
}

@end
