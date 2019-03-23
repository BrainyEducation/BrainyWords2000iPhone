# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

target 'BrainyWords2k' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # ignore all warnings from all pods
  inhibit_all_warnings!
  
  # Pods for BrainyWords2k
    pod 'SwiftyExtension'
    pod 'ViewDeck'
    pod 'SwiftyJSON'
    pod 'IQKeyboardManagerSwift'
    pod 'SwiftyUserDefaults'
    pod 'SwiftKeychainWrapper'
    pod 'NVActivityIndicatorView'
    pod 'SWXMLHash'
    pod 'ObjectMapper'
    pod 'SnapKit'
    
    # Pods for network
    pod 'Alamofire'
    pod 'AlamofireObjectMapper'
    
    # Pods for Fabrics
    pod 'Fabric'
    pod 'Crashlytics'
    
    pod 'SwiftValidator', :git => 'https://github.com/jpotts18/SwiftValidator.git', :branch => 'swift-3'
end


post_install do |installer|
    # This line is a rather ugly and unpleasant workaround for this issue: https://github.com/Mantle/Mantle/issues/704, see https://github.com/CocoaPods/CocoaPods/issues/4420.
    # TODO: Remove this when the issue is fixed!
    `find Pods -regex 'Pods/Mantle.*\\.h' -print0 | xargs -0 sed -i '' 's/\\(<\\)Mantle\\/\\(.*\\)\\(>\\)/\\"\\2\\"/'`
    
    # ENABLE_BITCODE value needs to be the same for all targets and dependent projects
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['ENABLE_BITCODE'] = 'NO'
            config.build_settings['SWIFT_VERSION'] = '4.0'
            config.build_settings['MACOSX_DEPLOYMENT_TARGET'] = '10.10'
        end
    end
end
