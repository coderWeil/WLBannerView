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

@interface ViewController ()<WLBannerViewDelegate>
@property (nonatomic, strong) WLBannerView *bannerView1;
@property (nonatomic, strong) NSMutableArray<UIImage *> *images1;
@property (nonatomic, strong) WLBannerView *bannerView2;
@property (nonatomic, strong) NSMutableArray<ImageModel *> *images2;
@property (nonatomic, strong) WLBannerView *bannerView3;
@property (nonatomic, strong) NSMutableArray<NSString *> *images3;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self _defaultCell];
    [self _customCell];
    [self _net];
}
//使用默认的cell展示
- (void) _defaultCell {
    self.bannerView1 = [[WLBannerView alloc] init];
    self.bannerView1.frame = CGRectMake(0, 50, self.view.bounds.size.width, 200);
    self.bannerView1.bannerDelegate = self;
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
    self.bannerView2.bannerDelegate = self;
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
- (void) _net {
    self.bannerView3 = [[WLBannerView alloc] init];
    self.bannerView3.frame = CGRectMake(0, 550, self.view.bounds.size.width, 200);
    self.bannerView3.bannerDelegate = self;
    [self.view addSubview:self.bannerView3];
    self.images3 = @[].mutableCopy;
    NSArray *urls = @[@"http://image.yoga1314.com/be74dedeca789734632baeeafca85c68.jpeg", @"http://image.yoga1314.com/bb43dd3810760e9d2b3c770d4a1af3fa.jpg", @"http://image.yoga1314.com/77f526b9661b5a33f4bab0993c30e63c.jpg", @"http://image.yoga1314.com/be74dedeca789734632baeeafca85c68.jpeg", @"http://image.yoga1314.com/1f630dd43cfdb63ab47b501c424f699a.jpg", @"http://image.yoga1314.com/77f526b9661b5a33f4bab0993c30e63c.jpg"];
    for (int i = 0; i < urls.count; ++i) {
        [self.images3 addObject:urls[i]];
    }
    [self.bannerView3 setupData:self.images3];
    [self.bannerView3 reload];
    [self.bannerView3 scrollToIndex:2];
}
- (void)bannerView:(WLBannerView *)bannerView didClickItemAtIndex:(NSUInteger)index {
    if ([bannerView isEqual:self.bannerView1]) {
        NSLog(@"点击了bannerView1的第%lu张图片", (unsigned long)index);
    }else if ([bannerView isEqual:self.bannerView2]) {
        NSLog(@"点击了bannerView2的第%lu张图片", (unsigned long)index);
    }else if ([bannerView isEqual:self.bannerView3]) {
        NSLog(@"点击了bannerView3的第%lu张图片", (unsigned long)index);
    }
}
@end
