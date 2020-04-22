# Uncomment the next line to define a global platform for your project
platform :ios, '11.4'
use_frameworks!

target 'Infra' do
  # Pods for sparkle
  pod 'Firebase/Core'
  pod 'Firebase/Firestore'
  pod 'Firebase/Database'

  target 'sparkle' do
    pod 'Firebase/Core'
    pod 'Firebase/Firestore'
    pod 'Firebase/Database'

    # Social
    pod 'TwitterKit'

    # Networking
    pod 'Moya/RxSwift'

    # Data
    pod 'Kingfisher'
    pod 'ObjectMapper'

    # Crypto
    pod 'CryptoSwift'

    # Utility
    pod 'R.swift'

    # UI Helper
    pod 'SnapKit'
    pod 'IQKeyboardManagerSwift'
    pod 'PullToRefreshKit'

    # Redux
    pod 'ReSwift'
    pod 'ReSwiftRouter'
    pod 'ReRxSwift'

    # Reactive
    pod 'RxSwift'
    pod 'RxCocoa'

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
  end

  target 'sparkleUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
