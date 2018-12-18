#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'flutter_mmkv'
  s.version          = '1.1.1'
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
  s.dependency 'Flutter'
  s.dependency 'MMKV'
  
  s.ios.deployment_target = '8.0'
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.0' }
  s.swift_version = '4.0'

  s.preserve_paths = 'flutter_mmkv.framework'
  s.xcconfig = { 'OTHER_LDFLAGS' => '-framework flutter_mmkv' }
  s.vendored_frameworks = 'flutter_mmkv.framework'

  s.static_framework = true
end

