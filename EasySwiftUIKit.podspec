#
# Be sure to run `pod lib lint EasySwiftUIKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'EasySwiftUIKit'
    s.version          = '0.1.6'
    s.summary          = 'A swift library of EasySwiftUIKit.'
    
# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!
# CREATE
#   * pod lib create EasySwiftUIKit
#   * ios>swift>yes>None>No
#   * Push to git and release
#   * pod trunk register rashedgit@gmail.com 'Rz Rasel'
#   * pod lib lint EasySwiftUIKit.podspec --allow-warnings
#   * pod trunk push --allow-warnings
# UPDATE
#   * pod lib lint --allow-warnings
#   * Push to git and release
#   * pod trunk push --allow-warnings ORRR>> pod trunk push EasySwiftUIKit.podspec
    
    
    s.description      = <<-DESC
    'A swift library of EasySwiftUIKit. Just import and run project'
    DESC
    
    s.homepage         = 'https://github.com/arzrasel/EasySwiftUIKit'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Rashed' => 'rashedgit@gmail.com' }
    s.source           = { :git => 'https://github.com/arzrasel/EasySwiftUIKit.git', :tag => s.version.to_s }
    # s.social_media_url = 'https://twitter.com/rzrasel'
    
    s.ios.deployment_target = '11.0'
    #  s.source_files = 'Classes/**/*.swift'
    #  s.source_files = 'EasySwiftUIKit/Classes/**/*'
    #    s.source_files = 'EasySwiftUIKit/Classes/**/*.swift'
    #  s.platforms = {
    #      "ios": "11.0"
    #  }
    s.source_files = 'Classes/*.swift'
    s.framework    = 'UIKit', 'Foundation', 'QuartzCore'
    s.platforms = {
          "ios": "9.0"
      }
    
    #s.source_files = 'EasySwiftUIKit/Classes/**/*'
    
    # s.resource_bundles = {
    #   'EasySwiftUIKit' => ['EasySwiftUIKit/Assets/*.png']
    # }
    
    # s.public_header_files = 'Pod/Classes/**/*.h'
    # s.frameworks = 'UIKit', 'MapKit'
    # s.dependency 'AFNetworking', '~> 2.3'
    #https://cocoapods.org/pods/EasySwiftUIKit
end
