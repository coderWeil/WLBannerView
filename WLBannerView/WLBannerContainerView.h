//
//  WLBannerContainerView.h
//  WLBannerViewDemo
//
//  Created by weil on 2019/12/31.
//  Copyright © 2019 AllYoga. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLBannerView.h"
#import "WLPageControl.h"

NS_ASSUME_NONNULL_BEGIN
typedef NS_ENUM(NSUInteger, WLPageControlLocation) {
    WLPageControlLocationCenter = 0,//中间
    WLPageControlLocationLeft,//左边
    WLPageControlLocationRight//右边
};

@interface WLBannerContainerView<T> : UIView
@property (nonatomic, strong, readonly) WLBannerView *bannerView;
@property (nonatomic, strong, readonly) WLPageControl *pageControl;
/**分页指示器的位置，默认在中心
 */
@property (nonatomic, assign) WLPageControlLocation pageControlLocation;
/**分页指示器距离左边或者右边的间距，此属性只在指示器位置靠左或者靠右显示的时候有效，默认为20
 */
@property (nonatomic, assign) CGFloat pageControlMargin;
/**设置分页指示器顶部距离父视图底部的间距，默认为20
 */
@property (nonatomic, assign) CGFloat pageControlBottomMargin;
/**初始化，指定bannerCell的类名称
 */
- (instancetype) initWithBannerCellCls:(Class)cls NS_DESIGNATED_INITIALIZER;
/**设置数据源，数组中数据是泛型
 */
- (void) setupData:(NSArray<T> *)data;
- (void) reload;
@end

NS_ASSUME_NONNULL_END
