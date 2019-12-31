//
//  ViewController.m
//  WLBannerViewDemo
//
//  Created by weil on 2019/12/31.
//  Copyright © 2019 AllYoga. All rights reserved.
//

#import "ViewController.h"
#import "WLBannerView.h"
#import "ImageModel.h"
#import "CustomBannerCell.h"

@interface ViewController ()
@property (nonatomic, strong) WLBannerView *bannerView1;
@property (nonatomic, strong) NSMutableArray<UIImage *> *images1;
@property (nonatomic, strong) WLBannerView *bannerView2;
@property (nonatomic, strong) NSMutableArray<ImageModel *> *images2;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _defaultCell];
    [self _customCell];
}
//使用默认的cell展示
- (void) _defaultCell {
    self.bannerView1 = [[WLBannerView alloc] init];
    self.bannerView1.frame = CGRectMake(0, 50, self.view.bounds.size.width, 200);
    [self.view addSubview:self.bannerView1];
    self.images1 = @[].mutableCopy;
    NSArray *names = @[@"01", @"02", @"03"];
    for (int i = 0; i < names.count; ++i) {
        [self.images1 addObject:[UIImage imageNamed:names[i]]];
    }
    [self.bannerView1 setupData:self.images1];
    [self.bannerView1 reload];
}
//自定义cell展示
- (void) _customCell {
    self.bannerView2 = [[WLBannerView alloc] initWithCellCls:[CustomBannerCell class]];
    self.bannerView2.frame = CGRectMake(0, 300, self.view.bounds.size.width, 200);
    [self.view addSubview:self.bannerView2];
    self.images2 = @[].mutableCopy;
    NSArray *names = @[@"01", @"02", @"03"];
    for (int i = 0; i < names.count; ++i) {
        ImageModel *model = [[ImageModel alloc] init];
        model.image = [UIImage imageNamed:names[i]];
        [self.images2 addObject:model];
    }
    [self.bannerView2 setupData:self.images2];
    [self.bannerView2 reload];
}

@end
