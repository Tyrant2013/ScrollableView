//
//  ZXWScrollView.m
//  ZXWFreezedScrollView
//
//  Created by 庄晓伟 on 16/11/10.
//  Copyright © 2016年 Zhuang Xiaowei. All rights reserved.
//

#import "ZXWScrollView.h"

@implementation ZXWScrollView

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

@end
