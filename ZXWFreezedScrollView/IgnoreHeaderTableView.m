//
//  IgnoreHeaderTableView.m
//  ZXWFreezedScrollView
//
//  Created by 庄晓伟 on 16/11/10.
//  Copyright © 2016年 Zhuang Xiaowei. All rights reserved.
//

#import "IgnoreHeaderTableView.h"

@implementation IgnoreHeaderTableView

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if (self.tableHeaderView && CGRectContainsPoint(self.tableHeaderView.frame, point)) {
        return NO;
    }
    return [super pointInside:point withEvent:event];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
