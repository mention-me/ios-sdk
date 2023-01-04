#
# Be sure to run `pod lib lint MentionmeSwift.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'MentionmeSwift'
  s.version          = '1.3'
  s.summary          = 'Supercharge your customer growth with referral marketing through Mention Me'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'Mention Me provides its clients with world class Refer a Friend programmes. Our unique, state-of-the-art SaaS platform enables companies to supercharge word of mouth for fast and effective new customer acquisition'

  s.homepage         = 'https://github.com/mention-me/ios-sdk'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'mention-me' => 'appledeveloper@mention-me.com' }
  s.source           = { :git => 'https://github.com/mention-me/ios-sdk.git', :tag => s.version.to_s }
  
  s.ios.deployment_target = '11.0'
  s.swift_version = '5.0'
  s.source_files = 'MentionmeSwift/Classes/**/*'
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '5.0' }
  
  # s.resource_bundles = {
  #   'MentionmeSwift' => ['MentionmeSwift/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
