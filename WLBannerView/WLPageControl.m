//
//  WLPageControl.m
//  WLBannerViewDemo
//
//  Created by weil on 2019/12/31.
//  Copyright © 2019 AllYoga. All rights reserved.
//

#import "WLPageControl.h"

@implementation WLPageControl
- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat marginX = self.dot_w + self.dot_margin;
    for (int i = 0; i < self.subviews.count; ++i) {
        UIImageView *dot = self.subviews[i];
        [dot setFrame:CGRectMake(i * marginX, 0, self.dot_w, self.dot_h)];
    }
}
@end
