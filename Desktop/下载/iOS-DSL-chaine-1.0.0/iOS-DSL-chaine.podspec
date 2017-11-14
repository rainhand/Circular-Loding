Pod::Spec.new do |s|

s.name         = "iOS-DSL-chaine"
s.version      = "2.0.0"
s.summary      = "使用OC实现链式编程DSL"
s.homepage     = "https://github.com/rainhand/iOS-DSL-chaine"
# s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

s.license      = "MIT"
s.author             = { "rainhand" => "email@address.com" }
s.platform     = :ios, "7.0"
s.source       = { :git => "https://github.com/rainhand/iOS-DSL-chaine.git", :tag => "0.0.1" }
s.source_files  = "DLS", "DLS/**/*.{h,m}"
s.frameworks = "SomeFramework", "AnotherFramework"

s.dependency "JSONKit", "~> 1.4"

end
