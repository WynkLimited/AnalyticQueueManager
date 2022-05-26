#
# Be sure to run `pod lib lint AnalyticQueueManager.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'AnalyticQueueManager'
  s.version          = '0.1.0'
  s.summary          = 'AnalyticQueueManager provides the functionality of QueueManagement'

  s.description      = 'AnalyticQueueManager provides the functionality of QueueManagement and we can new custom validators'

  s.homepage         = 'https://github.com/WynkLimited/AnalyticQueueManager'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'NO LICENSE' , :text => 'NO LICENCE IS GRANTED TO REUSE/MODIFY/EDIT THIS SOFTWARE WITHOUT PERMISSION'}
  s.author           = { 'nitinchadhawynk' => 'nitin.chadha@wynk.in' }
  s.source           = { :git => 'https://github.com/nitinchadhawynk/AnalyticQueueManager.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.4'
  s.swift_version = '5.0'

  s.source_files = 'AnalyticQueueManager/Classes/**/*'
  
  # s.resource_bundles = {
  #   'AnalyticQueueManager' => ['AnalyticQueueManager/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
