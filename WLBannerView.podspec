Pod::Spec.new do |spec|
  spec.name         = "WLBannerView"
  spec.version      = "0.0.1"
  spec.summary      = "三张图片实现无限轮播"
  spec.description  = "可传入UIImage数组，NSString 图片地址数组，或者自定义数据模型数组，可使用默认的只显示图片的item，也可自定义item，提供了默认的可部分自定义的分页指示器"
  spec.homepage     = "https://github.com/weilLove/WLBannerView"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author             = { "liwei" => "liwei@all-yoga.cn" }
  spec.platform     = :ios, "8.0"
  spec.source       = { :git => "https://github.com/weilLove/WLBannerView.git", :tag => "#{spec.version}" }
  spec.source_files  = "WLBannerView", "WLBannerView/*.{h,m}"
  spec.frameworks = "Foundation", "UIKit"
  spec.dependency "SDWebImage"

end
