//
//  WLBannerViewCell.h
//  WLBannerViewDemo
//
//  Created by weil on 2019/12/31.
//  Copyright © 2019 AllYoga. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/**默认的循环显示的cell，默认只有图片，这里的T分为image和url两种方式
 * 可继承自 WLBannerViewCell 实现自定义的cell
 */
@interface WLBannerViewCell<T> : UIView
- (void) setupData:(T)data;
@end

NS_ASSUME_NONNULL_END
