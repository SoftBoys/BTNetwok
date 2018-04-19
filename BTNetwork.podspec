

Pod::Spec.new do |s|

  s.name         = "BTNetwork"
  s.version      = "1.1.0"
  s.summary      = "一款基于AFNetworking的以block调用形式的网络请求框架"
# s.description  = "一款基于AFNetworking的以block调用形式的网络请求框架,支持队列组请求"

  s.homepage     = "https://github.com/SoftBoys/BTNetwok"
  s.source       = { :git => "https://github.com/SoftBoys/BTNetwok.git", :tag =>s.version.to_s }

  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.author       = { "gjw" => "gjw_1991@163.com" }
  s.platform     = :ios, '8.0'


  s.source_files  = "BTNetwork/*.{h,m}"

  s.requires_arc = true
  s.dependency "AFNetworking", "~> 3.1.0"

end
