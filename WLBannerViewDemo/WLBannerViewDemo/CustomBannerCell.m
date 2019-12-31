//
//  CustomBannerCell.m
//  WLBannerViewDemo
//
//  Created by weil on 2019/12/31.
//  Copyright © 2019 AllYoga. All rights reserved.
//

#import "CustomBannerCell.h"

@implementation CustomBannerCell
- (void)setupData:(ImageModel *)data {
    self.imageView.image = data.image;
}
@end
