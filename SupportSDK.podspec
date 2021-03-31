Pod::Spec.new do |s|
  s.name         = "SupportSDK"
  s.version      = "1.3.1"
  s.summary      = "Boomtown Support SDK"
  s.description  = "The Boomtown Product Support Platform SDK lets you embed a complete product support platform in your iOS applications."
  s.homepage     = "https://developers.goboomtown.com"
  s.platform     = :ios, "11.0"
  s.license      = {
    :type => "Commercial",
    :text => "Copyright 2020 Boomtown. All rights reserved."
  }
  s.author                = { "Larry Borsato" => "lborsato@goboomtown.com" }
  s.source                = { :git => "https://github.com/goboomtown/support-sdk-ios.git", :tag => "#{s.version}" }
  s.libraries             = "c++"
  s.vendored_frameworks   = "SupportSDK.framework"
  s.requires_arc          = true
  s.xcconfig              = {
    'OTHER_LDFLAGS' => '-ObjC',
    'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'
  }

  s.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }

  s.dependency 'AFNetworking', '~> 4.0'
  s.dependency 'XMPPFramework', '~> 4.0'
  s.dependency 'SVProgressHUD'
  s.dependency 'TwilioVideo', '3.7.1'
  s.dependency 'iOS-Color-Picker'
  s.dependency 'MTBBarcodeScanner'
end
