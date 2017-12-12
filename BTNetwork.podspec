

Pod::Spec.new do |s|

  s.name         = "BTNetwork"
  s.version      = "1.0.5"
  s.summary      = "一款基于AFNetworking的以block调用形式的网络请求框架"

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description  = "一款基于AFNetworking的以block调用形式的网络请求框架,支持队列组请求"

  s.homepage     = "https://github.com/SoftBoys/BTNetwok"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"


  s.license      = "MIT"
  s.author       = { "gjw" => "gjw_1991@163.com" }
  s.platform     = :ios, "8.0"

  #  When using multiple platforms
  # s.ios.deployment_target = "5.0"
  # s.osx.deployment_target = "10.7"
  # s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target = "9.0"


  s.source       = { :git => "https://github.com/SoftBoys/BTNetwok.git", :tag => "v#{s.version}" }


  # ――― Source Code ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  CocoaPods is smart about how it includes source code. For source files
  #  giving a folder will include any swift, h, m, mm, c & cpp files.
  #  For header files it will include any header in the folder.
  #  Not including the public_header_files will make all headers public.
  #

  s.source_files  = "BTNetwork"
  # s.exclude_files = "Classes/Exclude"

  # s.public_header_files = "Classes/**/*.h"


  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  A list of resources included with the Pod. These are copied into the
  #  target bundle with a build phase script. Anything else will be cleaned.
  #  You can preserve files from being cleaned, please don't preserve
  #  non-essential files like tests, examples and documentation.
  #

  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"

   s.requires_arc = true
   s.dependency "AFNetworking", "~> 3.1.0"

end
