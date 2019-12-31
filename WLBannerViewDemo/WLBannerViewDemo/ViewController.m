//
//  ViewController.m
//  WLBannerViewDemo
//
//  Created by weil on 2019/12/31.
//  Copyright © 2019 AllYoga. All rights reserved.
//

#import "ViewController.h"
#import "WLBannerView.h"

@interface ViewController ()
@property (nonatomic, strong) WLBannerView *bannerView;
@property (nonatomic, strong) NSMutableArray<UIImage *> *images;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bannerView = [[WLBannerView alloc] init];
    self.bannerView.bounds = CGRectMake(0, 0, self.view.bounds.size.width, 200);
    self.bannerView.center = self.view.center;
    [self.view addSubview:self.bannerView];
    self.images = @[].mutableCopy;
    [self.images addObject:[UIImage imageNamed:@"01"]];
    [self.images addObject:[UIImage imageNamed:@"02"]];
    [self.images addObject:[UIImage imageNamed:@"03"]];
    [self.images addObject:[UIImage imageNamed:@"01"]];
    [self.images addObject:[UIImage imageNamed:@"02"]];
    [self.images addObject:[UIImage imageNamed:@"03"]];
    [self.bannerView setupData:self.images];
    [self.bannerView reload];
}


@end
