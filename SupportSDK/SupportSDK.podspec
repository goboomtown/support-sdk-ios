Pod::Spec.new do |s|
  s.name         = "SupportSDK"
  s.version      = "1.0.0"
  s.summary      = "Boomtown Support SDK"
  s.description  = "The Boomtown Support SDK lets you embed a complete product support platform in your iOS apps."
  s.homepage     = "http://www.goboomtown.com"
  s.platform     = :ios, "9.0"
  s.license      = {
    :type => "Commercial",
    :text => "Copyright 2020 Boomtown. All rights reserved."
  }
  s.author       = { "Boomtown" => "help@goboomtown.com" }
  # s.source       = { :http    => "" }
  s.source           = { :path => "../BoomtownAPI", :tag => s.version.to_s }
  s.libraries             = "c++"
  s.vendored_frameworks   = "SupportSDK.framework"
  s.requires_arc          = true
  s.xcconfig              = { 'OTHER_LDFLAGS' => '-ObjC' }
  s.dependency 'AFNetworking', '~> 3.0'
  s.dependency 'XMPPFramework', '~> 4.0'
  s.dependency 'SVProgressHUD'
  s.dependency 'TwilioVideo', '2.8.1'
  s.dependency 'iOS-Color-Picker'
  s.dependency 'MTBBarcodeScanner'
end
