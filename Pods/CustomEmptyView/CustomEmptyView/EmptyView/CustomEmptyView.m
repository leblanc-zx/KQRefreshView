//
//  CustomEmptyView.m
//  KangYunGuanJia
//
//  Created by zhouxiang on 2020/9/7.
//  Copyright © 2020 zhouxiang. All rights reserved.
//

#import "CustomEmptyView.h"
#import "UIScrollView+MJRefresh.h"

@interface CustomEmptyView ()

@end

@implementation CustomEmptyView

/**
 构造方法 - 创建emptyView
 
 @param titleStr    标题
 @return 返回一个emptyView
 */
+ (CustomEmptyView *)customEmptyActionViewWithTitleStr:(NSString *)titleStr {
    CustomEmptyView *emptyView = [CustomEmptyView emptyViewWithImage:nil titleStr:titleStr detailStr:@""];
    [emptyView setStyle:-40];
    return emptyView;
}

/**
 构造方法 - 创建emptyView
 
 @param titleStr    标题
 @param customOffsetY    偏移
 @return 返回一个emptyView
 */
+ (CustomEmptyView *)customEmptyActionViewWithTitleStr:(NSString *)titleStr customOffsetY:(CGFloat)customOffsetY {
    CustomEmptyView *emptyView = [CustomEmptyView emptyViewWithImage:nil titleStr:titleStr detailStr:@""];
    [emptyView setStyle:customOffsetY];
    return emptyView;
}

- (void)setStyle:(CGFloat)customOffsetY {
    [super prepare];
    self.autoShowEmptyView = NO; //如果想要DemoEmptyView的效果都不是自动显隐的，这里统一设置为NO，初始化时就不必再一一去写了
    self.titleLabTextColor = [UIColor colorWithRed:148/255.0 green:148/255.0 blue:148/255.0 alpha:1];
    self.titleLabFont = [UIFont fontWithName:@"Helvetica" size:16.0];
    self.contentViewOffset = customOffsetY;
}

- (void)didMoveToSuperview {
    if ([self.superview isKindOfClass:[UITableView class]]) {
        UITableView *tableView = (UITableView *)self.superview;
        if (tableView.mj_header != nil) {
            [tableView ly_hideEmptyView];
        } else {
            self.autoShowEmptyView = YES;
        }
    }
}

@end
