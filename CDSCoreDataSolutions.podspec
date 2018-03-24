
Pod::Spec.new do |s|
  s.name             = "CDSCoreDataSolutions"
  s.version          = "1.1.0"
s.summary          = "CDSCoreDataSolutions: Core Data Stack & more."

  s.description      = <<-DESC
CDSCoreDataSolutions: Core Data Stack & more. Core Data Stack & more.
                       DESC

  s.homepage         = "https://github.com/ChristianFox/CDSCoreDataSolutions.git"
  s.license          = 'MIT'
  s.author           = { "Christian Fox" => "christianfox@kfxtech.com" }
  s.source           = { :git => "https://github.com/ChristianFox/CDSCoreDataSolutions.git", :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'CDSCoreDataSolutions/Classes/**/*'
  
end
