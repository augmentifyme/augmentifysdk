//
//  AppDelegate.swift
//  AugmentifySDK Swift Demo
//
//  Created by Adrian König Mintellity on 25.02.19.
//  Copyright © 2019 Mintellity. All rights reserved.
//

import UIKit
import AugmentifySDK

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    /// place your appToken here
    static let appToken = "your-app-token"
    
    /// place your sdkSecret here
    static let secret = "your-app-secret"
    
    let errorLog = DemoSDKErrorLog()
    let statusLog = DemoSDKLog()
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        //start the SDK
        if #available(iOS 12, *) {
            //the app didnt start by application:didFinishLaunchingWithOptions:, we need to start the SDK
            AugmentifySDKManager.shared.configureWith(appToken: AppDelegate.appToken,
                                                      secret: AppDelegate.secret)
            // optional, receive errors from the SDK
            AugmentifySDKManager.shared.addErrorDelegate(self.errorLog)
            // reiceive status updates of the SDK.
            // The SDK must have the state AugmentifySyncStateAllLoaded to open any Experience
            AugmentifySDKManager.shared.addStatusDelegate(self.statusLog)
            AugmentifySDKManager.shared.start()
        }
        
        return true
    }
    
    //Entry point for URLSchemes
    func application(_ application: UIApplication, open url: URL,
                     sourceApplication: String?, annotation: Any)-> Bool {
        
        if #available(iOS 12.0, *) {
            //the app didnt start by application:didFinishLaunchingWithOptions:, we need to start the SDK
            AugmentifySDKManager.shared.configureWith(appToken: AppDelegate.appToken,
                                                      secret: AppDelegate.secret)
            // optional, receive errors from the SDK
            AugmentifySDKManager.shared.addErrorDelegate(self.errorLog)
            // reiceive status updates of the SDK.
            // The SDK must have the state AugmentifySyncStateAllLoaded to open any Experience
            AugmentifySDKManager.shared.addStatusDelegate(self.statusLog)
            AugmentifySDKManager.shared.start()
            //your URLQuerry
            let myAppRedirect = "augmentify\(AppDelegate.appToken)"
            let currentViewController = self.window?.rootViewController
            // check if the scheme is targeted for Augmentify
            if url.absoluteString.contains(myAppRedirect){
                AugmentifySDKManager.shared.createAugmentifyViewController(forUrl: url, success: { (vc:   UIViewController) -> (Void) in
                    //make sure the view controller isnt presenting any other viewController
                    currentViewController?.dismiss(animated: false, completion: nil)
                    //present the Augmentify Experience
                    currentViewController?.present(vc, animated: true, completion: nil)
                }) { (error: NSError) -> (Void) in
                    print(error)
                }
            }
        }
        return true
    }
    
    //Entry point for Universal Links
    func application(_ application: UIApplication,
                     continue userActivity: NSUserActivity,
                     restorationHandler: @escaping ([UIUserActivityRestoring]?) -> Void) -> Bool {
        if userActivity.activityType == NSUserActivityTypeBrowsingWeb {
            if #available(iOS 12.0, *) {
                let url = userActivity.webpageURL!
                //Source of your Association File
                let myAppRedirect = "https://augmentify.yourdomain.com"
                let currentViewController = self.window?.rootViewController
                // check if the userActivity is targeted for Augmentify
                if url.absoluteString.contains(myAppRedirect){
                    AugmentifySDKManager.shared.createAugmentifyViewController(forUrl: url, success: { (vc:   UIViewController) -> (Void) in
                        //make sure the view controller isnt presenting any other viewController
                        currentViewController?.dismiss(animated: false, completion: nil)
                        
                        //present the Augmentify Experience
                        currentViewController?.present(vc, animated: true, completion: nil)
                    }) { (error: NSError) -> (Void) in
                        print(error)
                    }
                }
            }
        }
        return true
    }
}



