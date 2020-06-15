# Uncomment the next line to define a global platform for your project
platform :ios, '11.4'
# ignore all warnings from all pods
inhibit_all_warnings!
# use_modular_headers!

target 'Infra' do
  #use_modular_headers!
  use_frameworks!
  # Pods for sparkle

  pod 'Firebase/Core'
  pod 'Firebase/Firestore'
  pod 'Firebase/Database'

  target 'sparkle' do
    inherit! :search_paths
    # Social
    pod 'TwitterKit'
    pod 'Firebase/Core'
    pod 'Firebase/Firestore'
    pod 'Firebase/Database'

    # Networking
    #pod 'Moya/RxSwift', '~> 14.0.0'

    # Data
    pod 'Kingfisher'
    pod 'ObjectMapper'
    pod 'KeychainAccess'
    pod 'IGListKit'


    # Crypto
    pod 'CryptoSwift'

    # Utility
    pod 'R.swift'

    # UI Helper
    pod 'SnapKit'
    pod 'IQKeyboardManagerSwift'
    pod 'PullToRefreshKit'
    pod 'SVProgressHUD'

    # Reactive
    pod 'RxSwift'
    pod 'RxCocoa'
    pod 'RxOptional'


    pod 'Alamofire'
    pod 'SwiftyBeaver'
    pod 'SparkleClient', :git => 'https://github.com/ohayoukenchan/sparkle-api-ios.git'

    pod 'ReSwift'
    pod 'ReSwiftRouter'
    pod 'ReRxSwift'
    pod 'ReSwiftThunk'

    target 'API' do
    end

    target 'Redux' do
    end


  end


  
#  target 'sparkle-development' do
#      inherit! :search_paths
#  end
#
#  target 'sparkle-staging' do
#      inherit! :search_paths
#  end
#
#  target 'sparkle-release' do
#      inherit! :search_paths
#  end
#
  target 'sparkleTests' do
    inherit! :search_paths
    # Pods for testing
    pod 'ReSwiftThunk/ExpectThunk'
  end

  target 'sparkleUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
