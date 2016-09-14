Pod::Spec.new do |s|

  s.name         = 'AXViewControllers'
  s.version      = '0.0.2'
  s.summary      = 'A basic view controler manager kits.'
  s.description  = <<-DESC
                    A basic view controler manager using on iOS platform.
                   DESC

  s.homepage     = 'https://github.com/devedbox/AXViewControllers'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }

  s.author             = { 'aiXing' => '862099730@qq.com' }
  s.platform     = :ios, '7.0'

  s.source       = { :git => 'https://github.com/devedbox/AXViewControllers.git', :tag => '0.0.2' }
  s.source_files  = 'AXViewControllers/ViewControllers/*.{h,m}'

  s.frameworks = 'UIKit', 'Foundation'

  s.requires_arc = true

  s.dependency 'FDFullscreenPopGesture'
  s.dependency 'IQKeyboardManager'
  s.dependency 'MJRefresh'
end
