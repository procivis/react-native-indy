
Pod::Spec.new do |s|
  s.name         = "RNIndy"
  s.version      = "0.0.1"
  s.summary      = "RNIndy"
  s.description  = <<-DESC
                  RNIndy
                   DESC
  s.homepage     = ""
  s.license      = "MIT"
  s.author             = { "Eduard Cuba" => "cuba@procivis.ch" }
  s.platform     = :ios, "10.2"
  s.source       = { :git => "https://github.com/procivis/react-native-indy", :tag => "master" }
  s.source_files  = "RNIndy/**/*.{h,m}"
  s.requires_arc = true

  s.dependency "React"
end

