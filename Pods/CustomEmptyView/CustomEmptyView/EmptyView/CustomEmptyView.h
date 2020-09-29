//
//  CustomEmptyView.h
//  KangYunGuanJia
//
//  Created by zhouxiang on 2020/9/7.
//  Copyright © 2020 zhouxiang. All rights reserved.
//

#import "LYEmptyView.h"
#import "LYEmptyViewHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface CustomEmptyView : LYEmptyView

/**
 构造方法 - 创建emptyView
 
 @param titleStr    标题
 @return 返回一个emptyView
 */
+ (CustomEmptyView *)customEmptyActionViewWithTitleStr:(NSString *)titleStr;

/**
 构造方法 - 创建emptyView
 
 @param titleStr    标题
 @param customOffsetY    偏移
 @return 返回一个emptyView
 */
+ (CustomEmptyView *)customEmptyActionViewWithTitleStr:(NSString *)titleStr customOffsetY:(CGFloat)customOffsetY;

@end

NS_ASSUME_NONNULL_END
