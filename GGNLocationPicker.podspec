Pod::Spec.new do |s|
  s.name             = 'GGNLocationPicker'
  s.version          = '0.1.0'
  s.summary          = 'Easily present a view controller for picking a location.'
  s.homepage         = 'https://github.com/garricn/GGNLocationPicker'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Garric Nahapetian' => 'garricn@icloud.com' }
  s.source           = { :git => 'https://github.com/garricn/GGNLocationPicker.git', :commit => 7ce146dn }
  s.ios.deployment_target = '9.3'
  s.source_files = 'GGNLocationPicker/Classes/**/*'
end
