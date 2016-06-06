#
# Be sure to run `pod lib lint CDSCoreDataSolutions.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "CDSCoreDataSolutions"
  s.version          = "0.3.0"
s.summary          = "CDSCoreDataSolutions: Core Data Stack & more."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
CDSCoreDataSolutions: Core Data Stack & more. Core Data Stack & more.
                       DESC

  s.homepage         = "https://kfxtech@bitbucket.org/kfxtech/cdscoredatasolutions_pod_private.git"
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"
  s.license          = 'MIT'
  s.author           = { "Christian Fox" => "christianfox890@icloud.com" }
  s.source           = { :git => "https://kfxtech@bitbucket.org/kfxtech/cdscoredatasolutions_pod_private.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'CDSCoreDataSolutions/Classes/**/*'
  
  # s.resource_bundles = {
  #   'CDSCoreDataSolutions' => ['CDSCoreDataSolutions/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end