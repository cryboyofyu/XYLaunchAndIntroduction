Pod::Spec.new do |s|

  s.name         = "XYLaunchAndIntroduction"
  s.version      = "0.0.1"
  s.summary      = "自定义启动页（包括：静态页，动态页，广告页，向导页，自动滚动页） 自定义引导页 (包括: 传统引导页，浮层动画引导，gif引导页，自定义引导页,视频引导页)"

  s.description  = <<-DESC
                   自定义启动页（包括：静态页，动态页，广告页，向导页，自动滚动页） 自定义引导页 (包括: 传统引导页，浮层动画引导，gif引导页，自定义引导页,视频引导页) 启动页和引导页可以互相配合效果更佳
                   DESC

  s.homepage     = "https://github.com/cryboyofyu/XYLaunchAndIntroduction.git"

  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }

  s.author             = { "LV" => "cryboyofyu@gmail.com" }
 
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/cryboyofyu/XYLaunchAndIntroduction.git", :tag => "0.0.1" }

  s.source_files  = "XYIntroductionAndLaunch/**/*.{h,m}"
  s.resources = "XYLaunchAndIntroductionExample/XYLaunchAndIntroductionExample/XYTestImgs/*.{gif,jpg,png,jpeg}"

  s.frameworks = "AVFoundation", "UIKit"


  s.requires_arc = true

  s.dependency 'SDWebImage'

end
