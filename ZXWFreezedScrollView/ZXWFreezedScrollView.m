//
//  ZXWFreezedScrollView.m
//  ZXWFreezedScrollView
//
//  Created by 庄晓伟 on 16/11/10.
//  Copyright © 2016年 Zhuang Xiaowei. All rights reserved.
//

#import "ZXWFreezedScrollView.h"
#import "ZXWScrollView.h"

@interface ZXWFreezedScrollView ()

@end

@implementation ZXWFreezedScrollView

- (id)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self __initView];
        self.freezedHeight = 350.0f;
    }
    return self;
}

- (void)__initView {
    CGFloat screenWidth = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGFloat screenHeight = CGRectGetHeight([UIScreen mainScreen].bounds) - 20.0f;
    CGFloat freezedHeight = 350.0f;
    
    _scrollView = [[ZXWScrollView alloc] initWithFrame:(CGRect){0.0f, 20.0f, screenWidth, screenHeight}];
    _scrollView.delegate = self;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.bounces = NO;
    [self addSubview:_scrollView];
    
    _freezedView = [[UIView alloc] initWithFrame:(CGRect){CGPointZero, screenWidth, freezedHeight}];
    [_scrollView addSubview:_freezedView];
    
    CGFloat posY = freezedHeight;
    _contentView = [[UIView alloc] initWithFrame:(CGRect){0.0f, posY, screenWidth, screenHeight}];
    [_scrollView addSubview:_contentView];
    
    _tableView = [[UITableView alloc] initWithFrame:(CGRect){CGPointZero, screenWidth, screenHeight}];
    [_contentView addSubview:_tableView];
    _tableView.showsVerticalScrollIndicator = NO;
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.backgroundColor = [UIColor clearColor];
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"aaa"];
    
    _scrollView.contentSize = (CGSize){screenWidth, screenHeight + freezedHeight};
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    static BOOL canNotMoveTableAtTop = NO;
    static BOOL canTableViewMove = NO;
    static BOOL canScrollViewMove = NO;
    if ([scrollView isKindOfClass:[UITableView class]]) {
        if (!canTableViewMove) {
            [scrollView setContentOffset:CGPointZero];
        }
        CGFloat offsetY = scrollView.contentOffset.y;
        if (offsetY < 0.0f) {
            canScrollViewMove = YES;
            [scrollView setContentOffset:CGPointZero];
            canTableViewMove = NO;
        }
    }
    if ([scrollView isEqual:self.scrollView]) {
        CGRect freeRect = self.freezedView.frame;
        freeRect.origin.y = scrollView.contentOffset.y;
        self.freezedView.frame = freeRect;
        
        CGFloat offsetY = scrollView.contentOffset.y;
        BOOL canNotMoveTableAtTopPreValue = canNotMoveTableAtTop;
        BOOL isMoveOver = offsetY >= self.freezedHeight;
        canNotMoveTableAtTop = isMoveOver;
        if (isMoveOver) {
            [scrollView setContentOffset:(CGPoint){0, self.freezedHeight}];
        }
        if (canNotMoveTableAtTop != canNotMoveTableAtTopPreValue) {
            if (!canNotMoveTableAtTopPreValue && canNotMoveTableAtTop) {
                canTableViewMove = YES;
                canScrollViewMove = NO;
            }
            if (canNotMoveTableAtTopPreValue && !canNotMoveTableAtTop && !canScrollViewMove) {
                scrollView.contentOffset = (CGPoint){0, self.freezedHeight};
            }
        }
    }
    self.scrollView.scrollEnabled = YES;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"aaa"
                                                            forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", @(indexPath.row)];
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

#pragma mark - UITableViewDelegate



@end
