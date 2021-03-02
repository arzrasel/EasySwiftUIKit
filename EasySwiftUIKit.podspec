#
# Be sure to run `pod lib lint EasySwiftUIKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#
# CREATE
#   * pod lib create EasySwiftUIKit
#   * ios>swift>yes>None>No
#   * Push to git and release
#   * pod trunk register rashedgit@gmail.com 'Rz Rasel'
#   * pod lib lint EasySwiftUIKit.podspec --allow-warnings
#   * [pod lib lint SocketIOClient.podspec --allow-warnings --no-clean --verbose]
#   * pod trunk push --allow-warnings
# UPDATE
#   * pod lib lint --allow-warnings
#   * [pod lib lint --allow-warnings --no-clean --verbose]
#   * Push to git and release
#   * pod trunk push --allow-warnings >>>ORRR>>> pod trunk push EasySwiftUIKit.podspec --allow-warnings
# EasySwiftUIKit Version - 1.0.4

Pod::Spec.new do |s|
    s.name             = 'EasySwiftUIKit'
    s.version          = '1.0.4'
    s.summary          = 'A short description of EasySwiftUIKit.'

    # This description is used to generate tags and improve search results.
    #   * Think: What does it do? Why did you write it? What is the focus?
    #   * Try to keep it short, snappy and to the point.
    #   * Write the description between the DESC delimiters below.
    #   * Finally, don't worry about the indent, CocoaPods strips it!

    s.description      = <<-DESC
    'A short description of EasySwiftUIKit.'
    DESC

    s.homepage         = 'https://github.com/arzrasel/EasySwiftUIKit'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'Md. Rashed - Uz - Zaman (Rz Rasel)' => 'rashedgit@gmail.com' }
    s.source           = { :git => 'https://github.com/arzrasel/EasySwiftUIKit.git', :tag => s.version.to_s }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '11.0'

    s.source_files = 'Source/**/*.swift'
    s.swift_version = '5.0'
    s.platforms = {
        'ios': '11.0'
    }

    # s.resource_bundles = {
    #   'EasySwiftUIKit' => ['EasySwiftUIKit/Assets/*.png']
    # }

    # s.public_header_files = 'Pod/Classes/**/*.h'
    # s.frameworks = 'UIKit', 'MapKit'
    # s.dependency 'AFNetworking', '~> 2.3-'
    s.frameworks = 'UIKit', 'WebKit'
end
