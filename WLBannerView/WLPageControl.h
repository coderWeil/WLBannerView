//
//  WLPageControl.h
//  WLBannerViewDemo
//
//  Created by weil on 2019/12/31.
//  Copyright © 2019 AllYoga. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface WLPageControl : UIPageControl
/**每个圆点的宽度，默认8
 */
@property (nonatomic, assign) CGFloat dot_w;
/**每个圆点的高度，默认8
 */
@property (nonatomic, assign) CGFloat dot_h;
/**每两个圆点之间的间距默认6
 */
@property (nonatomic, assign) CGFloat dot_margin;
@end

NS_ASSUME_NONNULL_END
