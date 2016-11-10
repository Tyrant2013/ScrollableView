//
//  ZXWFreezedScrollView.h
//  ZXWFreezedScrollView
//
//  Created by 庄晓伟 on 16/11/10.
//  Copyright © 2016年 Zhuang Xiaowei. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZXWScrollView;

@interface ZXWFreezedScrollView : UIView <
  UIScrollViewDelegate,
  UITableViewDelegate,
  UITableViewDataSource
>

@property (nonatomic, strong, readonly) ZXWScrollView       *scrollView;
@property (nonatomic, strong, readonly) UIView              *freezedView;
@property (nonatomic, strong, readonly) UIView              *contentView;
@property (nonatomic, strong, readonly) UITableView         *tableView;

@property (nonatomic, assign) CGFloat                       freezedHeight;

@end
