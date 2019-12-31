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
@property (nonatomic, strong) WLBannerView *bannerView;
@property (nonatomic, strong) NSMutableArray<ImageModel *> *images;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bannerView = [[WLBannerView alloc] initWithCellCls:[CustomBannerCell class]];
    self.bannerView.bounds = CGRectMake(0, 0, self.view.bounds.size.width, 200);
    self.bannerView.center = self.view.center;
    [self.view addSubview:self.bannerView];
    self.images = @[].mutableCopy;
    NSArray *names = @[@"01", @"02", @"03"];
    for (int i = 0; i < names.count; ++i) {
        ImageModel *model = [[ImageModel alloc] init];
        model.image = [UIImage imageNamed:names[i]];
        [self.images addObject:model];
    }
    [self.bannerView setupData:self.images];
    [self.bannerView reload];
}


@end
