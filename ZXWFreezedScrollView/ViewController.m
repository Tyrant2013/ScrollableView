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
    
    CGFloat screenWidth = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGFloat screenHeight = CGRectGetHeight([UIScreen mainScreen].bounds);
    CGFloat posY = 20.0f;
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"点啊" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    button.frame = (CGRect){0.0f, posY, screenWidth, 300.0f};
    button.layer.borderColor = [UIColor blueColor].CGColor;
    button.layer.borderWidth = 1.0f;
    button.layer.cornerRadius = 20.0f;
    [button addTarget:self action:@selector(buttonClick:)
     forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = (CGRect){0.0f, 300.0f, screenWidth, screenHeight - 50.0f};
    imageView.backgroundColor = [UIColor yellowColor];
    [self.view addSubview:imageView];
    self.imageView = imageView;
    
    IgnoreHeaderTableView *tableView = [[IgnoreHeaderTableView alloc] initWithFrame:(CGRect){0.0f, posY, screenWidth, screenHeight - 20.0f}];
    tableView.tableHeaderView = [[UIView alloc] initWithFrame:(CGRect){0.0f, 0.0f, screenWidth, 300.0f}];
    tableView.dataSource = self;
    tableView.delegate = self;
    tableView.tableHeaderView.backgroundColor = [UIColor clearColor];
    tableView.backgroundColor = [UIColor clearColor];
    tableView.bounces = NO;
    tableView.showsVerticalScrollIndicator = NO;
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"aaa"];
    [self.view addSubview:tableView];
    
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    
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
    CGFloat posY = 300.0f - scrollView.contentOffset.y;
    posY = posY <= 20.0f ? 20.0f : posY;
    CGRect frame = self.imageView.frame;
    frame.origin.y = posY;
    self.imageView.frame = frame;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
