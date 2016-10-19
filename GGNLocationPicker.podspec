Pod::Spec.new do |s|
  s.name             = 'GGNLocationPicker'
  s.version          = '0.1.2'
  s.summary          = 'Easily present a view controller for picking a location.'
  s.homepage         = 'https://github.com/garricn/GGNLocationPicker'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Garric Nahapetian' => 'garricn@icloud.com' }
  s.source           = { :git => 'https://github.com/garricn/GGNLocationPicker.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = 'GGNLocationPicker/Classes/**/*'
  s.dependency 'GGNObservable'
end
