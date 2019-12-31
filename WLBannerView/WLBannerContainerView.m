//
//  WLBannerContainerView.m
//  WLBannerViewDemo
//
//  Created by weil on 2019/12/31.
//  Copyright © 2019 AllYoga. All rights reserved.
//

#import "WLBannerContainerView.h"
#import "WLBannerViewCell.h"

@interface WLBannerContainerView ()
@property (nonatomic, strong, readwrite) WLBannerView *bannerView;
@property (nonatomic, assign) Class bannerCellClass;
@property (nonatomic, strong, readwrite) WLPageControl *pageControl;
@end

@implementation WLBannerContainerView
- (instancetype)initWithBannerCellCls:(Class)cls {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.bannerCellClass = cls;
        [self _initSubviews];
    }
    return self;
}
- (instancetype)init {
    return [self initWithBannerCellCls:[WLBannerViewCell class]];
}
- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithBannerCellCls:[WLBannerViewCell class]];
}
- (instancetype)initWithCoder:(NSCoder *)coder {
    return [self initWithBannerCellCls:[WLBannerViewCell class]];
}
- (void) _initSubviews {
    self.bannerView = [[WLBannerView alloc] initWithCellCls:self.bannerCellClass];
    [self addSubview:self.bannerView];
    self.pageControlBottomMargin = 20;
    self.pageControlMargin = 20;
    self.pageControlLocation = WLPageControlLocationCenter;
    self.pageControl = [[WLPageControl alloc] init];
    self.pageControl.currentPageIndicatorTintColor = [UIColor whiteColor];
    self.pageControl.pageIndicatorTintColor = [[UIColor whiteColor] colorWithAlphaComponent:0.4];
    self.pageControl.dot_w = 8;
    self.pageControl.dot_h = 8;
    self.pageControl.dot_margin = 6;
    [self addSubview:self.pageControl];
}
- (void)setupData:(NSArray *)data {
    [self.bannerView setupData:data];
    self.pageControl.numberOfPages = data.count;
}
- (void)reload {
    self.bannerView.frame = self.bounds;
    [self.bannerView reload];
    CGFloat x = 0, y = self.bounds.size.height - self.pageControlBottomMargin, w = 0, h = 0;
    CGFloat marginX = self.pageControl.dot_w + self.pageControl.dot_margin;
    w = (self.pageControl.subviews.count - 1) * marginX;
   if (self.pageControlLocation == WLPageControlLocationLeft) {
       x = self.pageControlMargin;
   }else if (self.pageControlLocation == WLPageControlLocationRight) {
       x = self.bounds.size.width - self.pageControlMargin - w;
   } else if (self.pageControlLocation == WLPageControlLocationCenter) {
       x = (self.bounds.size.width - w)/2.0;
   }
    self.pageControl.frame = CGRectMake(x, y, w, h);
}
@end
