Pod::Spec.new do |s|
s.name              = 'WZTabbarController'
s.version           = '1.0.1'
s.summary           = '我主良缘自定义TabbarController'
s.homepage          = 'https://github.com/WZLYiOS/WZTabbarController'
s.license           = { :type => 'MIT', :file => 'LICENSE' }
s.authors           = { 'LiuSky' => '327847390@qq.com'}
s.source            = {:git => 'https://github.com/WZLYiOS/WZTabbarController.git', :tag => s.version}


s.requires_arc = true
s.static_framework = true
s.swift_version         = '5.0'
s.ios.deployment_target = '9.0'
s.default_subspec = 'Source'
  
 s.subspec 'Source' do |ss|
  ss.source_files = 'WZTabbarController/Classes/*.swift'
  ss.resources = ['WZTabbarController/Resources/*.{lproj}']
  end


 #s.subspec 'Binary' do |ss|
# ss.vendored_frameworks = "Carthage/Build/iOS/Static/WZTabbarController.framework"
# ss.user_target_xcconfig = { 'LIBRARY_SEARCH_PATHS' => '$(TOOLCHAIN_DIR)/usr/lib/swift/$(PLATFORM_NAME)' }
#  end
end
