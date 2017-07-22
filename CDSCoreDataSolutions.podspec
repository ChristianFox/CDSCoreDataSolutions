
Pod::Spec.new do |s|
  s.name             = "CDSCoreDataSolutions"
  s.version          = "0.9.1.0"
s.summary          = "CDSCoreDataSolutions: Core Data Stack & more."

  s.description      = <<-DESC
CDSCoreDataSolutions: Core Data Stack & more. Core Data Stack & more.
                       DESC

  s.homepage         = "https://kfxtech@bitbucket.org/kfx_pods/cdscoredatasolutions.git"
  s.license          = 'MIT'
  s.author           = { "Christian Fox" => "christianfox890@icloud.com" }
  s.source           = { :git => "https://kfxtech@bitbucket.org/kfxteam/cdscoredatasolutions_pod_private.git", :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'CDSCoreDataSolutions/Classes/**/*'
  
end
