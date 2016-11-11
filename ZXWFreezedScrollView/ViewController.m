//
//  ViewController.m
//  ZXWFreezedScrollView
//
//  Created by 庄晓伟 on 16/11/10.
//  Copyright © 2016年 Zhuang Xiaowei. All rights reserved.
//

#import "ViewController.h"
#import "ZXWFreezedScrollView.h"
#import "IgnoreHeaderTableView.h"
#import <GPUImage.h>

@interface ViewController () <
  UITableViewDataSource,
  UITableViewDelegate
>

@property (nonatomic, weak) UIImageView                     *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self __initUI];
    
//    ZXWFreezedScrollView *scrollView = [[ZXWFreezedScrollView alloc] initWithFrame:[UIScreen mainScreen].bounds];
//    [self.view addSubview:scrollView];
//    scrollView.freezedView.backgroundColor = [UIColor redColor];
//    scrollView.contentView.backgroundColor = [UIColor clearColor];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"aaa" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%@", @(indexPath.row)];
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

#pragma mark - UITableViewDelegate

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UIView *view = [[UIView alloc] init];
//    view.bounds = (CGRect){CGPointZero, CGRectGetWidth([UIScreen mainScreen].bounds), 50.0f};
//    view.backgroundColor = [UIColor orangeColor];
//    return view;
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return 50.0f;
//}

#pragma mark - UIButton Response

- (void)buttonClick:(UIButton *)button {
    NSLog(@"点击了按钮");
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.y < 0.0f) {
        [scrollView setContentOffset:CGPointZero];
    }
    CGFloat viewHeight = CGRectGetHeight([UIScreen mainScreen].bounds) - 20.0f;
    CGFloat originHeight = viewHeight - 300.0f;
    CGFloat posY = 300.0f - scrollView.contentOffset.y;
    posY = posY <= 20.0f ? 20.0f : posY;
    CGRect frame = self.imageView.frame;
    frame.origin.y = posY;
    frame.size.height = originHeight + scrollView.contentOffset.y;
    self.imageView.frame = frame;
    CGFloat unitY = posY / viewHeight;
    CGFloat unitH = CGRectGetHeight(frame) / viewHeight;
    self.imageView.layer.contentsRect = (CGRect){0.0f, unitY, 1.0f, unitH};
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIImage *)compoundImage:(UIImage *)backImage topImage:(UIImage *)topImage backRect:(CGRect)backRect rect:(CGRect)rect {
    UIImage *returnImage = nil;
    UIGraphicsBeginImageContextWithOptions(backRect.size, NO, [UIScreen mainScreen].scale);
    [backImage drawInRect:(CGRect){CGPointZero, backRect.size}];
    [topImage drawInRect:rect];
    returnImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return returnImage;
}

- (void)__initUI {
    CGFloat screenWidth = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGFloat screenHeight = CGRectGetHeight([UIScreen mainScreen].bounds);
    CGFloat viewHeight = screenHeight - 20.0f;
    CGFloat posY = 20.0f;
    CGFloat offsetHeight = 300.0f;
    
    UIImage *image = [UIImage imageNamed:@"back.jpg"];
    GPUImageGaussianBlurFilter *gaussianFilter = [[GPUImageGaussianBlurFilter alloc] init];
    gaussianFilter.blurRadiusInPixels = 5.0f;
    UIImage *blurImage = [gaussianFilter imageByFilteringImage:image];
    
    UIImageView *backImageView = [[UIImageView alloc] init];
    backImageView.frame = (CGRect){0, posY, screenWidth, viewHeight};
    backImageView.image = blurImage;
    [self.view addSubview:backImageView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"点啊" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.frame = (CGRect){0.0f, posY, screenWidth, offsetHeight};
    [button addTarget:self action:@selector(buttonClick:)
     forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *cubeImageView = [[UIImageView alloc] init];
    cubeImageView.frame = (CGRect){0, 0, 150.0f, 150.0f};
    cubeImageView.center = button.center;
    UIImage *topImage = [UIImage imageNamed:@"cube.jpg"];
    cubeImageView.image = topImage;
    [self.view addSubview:cubeImageView];
    [self.view addSubview:button];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = (CGRect){0.0f, offsetHeight, screenWidth, viewHeight - offsetHeight};
    [self.view addSubview:imageView];
    self.imageView = imageView;
    UIImage *moveImage = [self compoundImage:blurImage
                                    topImage:topImage
                                    backRect:backImageView.bounds
                                        rect:cubeImageView.frame];
    gaussianFilter.blurRadiusInPixels = 7.0f;
    UIImage *moveBlurImage = [gaussianFilter imageByFilteringImage:moveImage];
    imageView.image = moveBlurImage;
    CGFloat unitY = offsetHeight / viewHeight;
    CGFloat unitH = (viewHeight - offsetHeight) / viewHeight;
    imageView.layer.contentsRect = (CGRect){0.0f, unitY, 1.0f, unitH};
    imageView.layer.contentsScale = [UIScreen mainScreen].scale;
    
    IgnoreHeaderTableView *tableView = [[IgnoreHeaderTableView alloc] initWithFrame:(CGRect){0.0f, posY, screenWidth, viewHeight}];
    tableView.tableHeaderView = [[UIView alloc] initWithFrame:(CGRect){0.0f, 0.0f, screenWidth, offsetHeight}];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.tableHeaderView.backgroundColor = [UIColor clearColor];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.scrollsToTop = NO;
    tableView.showsVerticalScrollIndicator = NO;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"aaa"];
    [self.view addSubview:tableView];
    
    
    self.view.backgroundColor = [UIColor lightGrayColor];
}


@end
