//
//  KQRefreshBackFooter.m
//  SharedMJRefresh
//
//  Created by 房房信 on 17/1/9.
//  Copyright © 2017年 Team. All rights reserved.
//

#import "KQRefreshBackFooter.h"

@interface KQRefreshBackFooter ()
@property (assign, nonatomic) NSInteger lastRefreshCount;
@property (assign, nonatomic) CGFloat lastBottomDelta;
@end

@implementation KQRefreshBackFooter

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
    [self setTitle:@"加载更多..." forState:MJRefreshStateRefreshing];
    [self setTitle:@"加载更多..." forState:MJRefreshStateIdle];
    // 设置key
    //    self.lastUpdatedTimeKey = MJRefreshHeaderLastUpdatedTimeKey;
    // 设置高度
    self.mj_h = MJRefreshFooterHeight;
}
- (void)placeSubviews {
    [super placeSubviews];
}
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
    // 如果正在刷新，直接返回
    if (self.state == MJRefreshStateRefreshing) return;
    
    _scrollViewOriginalInset = self.scrollView.contentInset;
    
    // 当前的contentOffset
    CGFloat currentOffsetY = self.scrollView.mj_offsetY;
    // 尾部控件刚好出现的offsetY
    CGFloat happenOffsetY = [self happenOffsetY];
    // 如果是向下滚动到看不见尾部控件，直接返回
    if (currentOffsetY <= happenOffsetY) return;
    
    CGFloat pullingPercent = (currentOffsetY - happenOffsetY) / self.mj_h;
    
    // 如果已全部加载，仅设置pullingPercent，然后返回
    if (self.state == MJRefreshStateNoMoreData) {
        self.pullingPercent = pullingPercent;
        return;
    }
    
    if (self.scrollView.isDragging) {
        self.pullingPercent = pullingPercent;
        // 普通 和 即将刷新 的临界点
//        CGFloat normal2pullingOffsetY = happenOffsetY + self.mj_h;
//        
//        if (self.state == MJRefreshStateIdle && currentOffsetY > normal2pullingOffsetY) {
//            // 转为即将刷新状态
//            self.state = MJRefreshStatePulling;
//        } else if (self.state == MJRefreshStatePulling && currentOffsetY <= normal2pullingOffsetY) {
//            // 转为普通状态
//            self.state = MJRefreshStateIdle;
//        }
        [self beginRefreshing];
    } else if (self.state == MJRefreshStatePulling) {// 即将刷新 && 手松开
        // 开始刷新
        [self beginRefreshing];
    } else if (pullingPercent < 1) {
        self.pullingPercent = pullingPercent;
    }
}

#pragma mark 获得scrollView的内容 超出 view 的高度
- (CGFloat)heightForContentBreakView
{
    CGFloat h = self.scrollView.frame.size.height - self.scrollViewOriginalInset.bottom - self.scrollViewOriginalInset.top;
    return self.scrollView.contentSize.height - h;
}

#pragma mark 刚好看到上拉刷新控件时的contentOffset.y
- (CGFloat)happenOffsetY
{
    CGFloat deltaH = [self heightForContentBreakView];
    if (deltaH > 0) {
        return deltaH - self.scrollViewOriginalInset.top;
    } else {
        return - self.scrollViewOriginalInset.top;
    }
}

@end
