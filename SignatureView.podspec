Pod::Spec.new do |s|
  s.name     = 'SignatureView'
  s.version  = '1.0'
  s.ios.deployment_target     = '9.0'
  s.osx.deployment_target     = '10.9'
  s.watchos.deployment_target = '2.0'
  s.license  = { :type => 'MIT', :file => 'LICENSE' }
  s.summary  = 'Capture signature view in Swift and export it as a vector graphics or bitmap'
  s.homepage = 'https://github.com/kArTeL/YPDrawSignatureView'
  s.author   = { 'GJ Nilsen' => 'gj.nilsen@yuppielabel.com' }
  s.requires_arc = true
  s.source   = {
    :git => 'https://github.com/GJNilsen/YPDrawSignatureView',
    :branch => 'master',
    :tag => s.version.to_s
  }
  s.source_files = 'Sources/*.swift'
  s.public_header_files = 'Sources/*.swift'
end
