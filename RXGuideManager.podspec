


Pod::Spec.new do |s|
  s.name     = "RXGuideManager"
  s.version  = "0.4"
  s.license  = "MIT"
  s.summary  = "RXGuideManager is a simple guide manager"
  s.homepage = "https://github.com/xzjxylophone/RXGuideManager"
  s.author   = { 'Rush.D.Xzj' => 'xzjxylophoe@gmail.com' }
  s.social_media_url = "http://weibo.com/xzjxylophone"
  s.source   = { :git => 'https://github.com/xzjxylophone/RXGuideManager.git', :tag => "v#{s.version}" }
  s.description = %{
        RXGuideManager is a simple guide manager.
  }
  s.source_files = 'RXGuideManager/*.{h,m}'
  s.frameworks = 'Foundation', 'UIKit'
  s.requires_arc = true
  s.platform = :ios, '7.0'

end


