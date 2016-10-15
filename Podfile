# Uncomment this line to define a global platform for your project
# platform :ios, '9.0'

target 'Flicks' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Flicks
  # This pulls in the latest version of AFNetworking >= 2.6 but less than 3.0.
  pod 'AFNetworking', '~> 2.6'
  pod 'SwiftyJSON'
  pod 'Alamofire',
  :git => 'https://github.com/Alamofire/Alamofire.git',
  :branch => '4.0.1'
  pod 'AlamofireImage', '~> 3.1'
  
  post_install do |installer|
      installer.pods_project.targets.each do |target|
          target.build_configurations.each do |config|
              config.build_settings['SWIFT_VERSION'] = '3.0'
          end
      end
  end

end
