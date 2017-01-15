Pod::Spec.new do |s|
  s.name             = 'MBUtils'
  s.version          = '0.1.2'
  s.summary          = 'Pod for colours and strings'
  s.description      = 'Pod for colours and strings and thread management'

  s.homepage         = 'https://github.com/beaneyDev/MBUtils'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Matt Beaney' => 'matt.beaney@pagesuite.co.uk' }
  s.source           = { :git => 'https://github.com/beaneyDev/MBUtils.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'MBUtils/Classes/**/*'
  
  # s.resource_bundles = {
  #   'MBUtils' => ['MBUtils/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
