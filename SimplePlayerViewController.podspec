#
# Be sure to run `pod lib lint SimplePlayerViewController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SimplePlayerViewController'
  s.version          = '0.0.1'
  s.summary          = 'A short description of SimplePlayerViewController.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/AsTao/SimplePlayerViewController'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'tobias' => '236048180@qq.com' }
  s.source           = { :git => 'https://github.com/AsTao/SimplePlayerViewController.git', :tag => s.version.to_s }


  s.ios.deployment_target = '9.0'
  s.requires_arc = true
  s.resources = 'SimplePlayerViewController/Resource.bundle'
  s.source_files = 'SimplePlayerViewController/*'
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '4.1' }
  s.swift_version = '4.1'

end
