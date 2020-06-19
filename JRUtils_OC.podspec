#
#  Be sure to run `pod spec lint JRUIOC.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "JRUtils_OC"
  s.version      = "0.0.3"
  s.summary      = "__"
  s.description  = '工具集合 OC'

  s.homepage     = "https://github.com/jiaren0204/JRUtils_OC"
  s.license      = "MIT"
  s.author             = { "梁嘉仁" => "50839393@qq.com" }
  s.platform     = :ios, "10.0"

  s.source       = { :git => "https://github.com/jiaren0204/JRUtils_OC.git", :tag => "0.0.3" }

  s.source_files  = "JRUtils_OC/Classes/*.h"

  s.subspec 'Category' do |ss|
    ss.source_files = 'JRUtils_OC/Classes/Category/*.{h,m}'
  end

  s.subspec 'Method' do |ss|
    ss.source_files = 'JRUtils_OC/Classes/Method/*.{h,m}'
  end
  
  s.subspec 'Tool' do |ss|
    ss.source_files = 'JRUtils_OC/Classes/Tool/*.{h,m}'
  end

end
