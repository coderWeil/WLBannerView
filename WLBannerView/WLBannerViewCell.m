//
//  WLBannerViewCell.m
//  WLBannerViewDemo
//
//  Created by weil on 2019/12/31.
//  Copyright © 2019 AllYoga. All rights reserved.
//

#import "WLBannerViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface WLBannerViewCell ()
@property (nonatomic, strong, readwrite) UIImageView *imageView;
@end

@implementation WLBannerViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _imageView = [UIImageView new];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
        [self addSubview:_imageView];
    }
    return self;
}
- (void)setupData:(id)data {
    if ([data isKindOfClass:[UIImage class]]) {
        self.imageView.image = data;
    }else if([data isKindOfClass:[NSString class]]) {
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:data]];
    }
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.imageView.frame = self.bounds;
}
@end
