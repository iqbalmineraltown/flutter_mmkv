#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'flutter_mmkv'
  s.version          = '1.1.3'
  s.summary          = 'A  Flutter plugin to use MMKV'
  s.description      = <<-DESC
A  Flutter plugin to use MMKV
                       DESC
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'email@example.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter','~>1.0.0'
  s.dependency 'MMKV','~>1.0.15'
  
  s.ios.deployment_target = '9.3'
  s.swift_version = '4.0'
end
