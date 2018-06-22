#
# Be sure to run `pod lib lint YPDrawSignatureView.podspec' to ensure this is a
# valid spec before submitting.

Pod::Spec.new do |s|
  s.name             = 'YPDrawSignatureView'
  s.version          = '1.1.3'
  s.summary          = 'Simple class for capturing signatures.'
  s.description      = <<-DESC
Capture signature view in Swift and export it as a vector graphics or bitmap
                       DESC
  s.homepage         = 'https://github.com/GJNilsen/YPDrawSignatureView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'GJNilsen' => 'gj.nilsen@appfact.no' }
  s.source           = { :git => 'https://github.com/GJNilsen/YPDrawSignatureView.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.requires_arc     = true 
  s.source_files     = 'Sources/*.swift'
  s.frameworks       = 'UIKit'
end
