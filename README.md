# WLBannerView
三张图片实现图片的无限轮播

> 传入的数据源数组中的数据类型为泛型，默认是```UIImage```或者```NSString```类型，也可以自定义数据类型
> 可使用库中默认的```WLBannerViewCell```，只实现图片轮播，若自定义了数据类型，则需要继承```WLBannerViewCell```,实现数据赋值的方法即可,类似如下：
```
@interface CustomBannerCell<ImageModel> : WLBannerViewCell
@end
- (void)setupData:(ImageModel *)data {
    self.imageView.image = data.image;
}
```
> 可使用提供的分页指示器，分页指示器可以自定义宽高以及间距, 可以设置分页指示器的位置，默认显示在底部，支持底部靠左，中间，靠右三种位置
```
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
```
> 是否开启自动滚动，可自定义自动滚动的时间间隔


#### 使用方式参加```Demo```提供的方式





