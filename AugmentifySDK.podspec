Pod::Spec.new do |s|  
    s.name              = "AugmentifySDK"
    s.version           = "1.3.6"
    s.summary           = "Augmentify - Augmented Reality SDK"
    s.homepage          = "https://augmentify.me/"
    s.swift_version     = '5.1'
    s.ios.deployment_target  = '12.0'
    s.author            = { 'Name' => "info@augmentify.me" }
    s.license           = { :file => 'LICENSE' }
    s.platform          = :ios, "12.0"
    s.source            = { :http => 'https://github.com/augmentifyme/augmentifysdk/releases/download/1.3.6/AugmentifySDK.zip'}
    s.ios.vendored_frameworks = 'AugmentifySDK.framework'

end