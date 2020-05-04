//
//  AppDelegate.m
//  AugmentifySDK Demo
//
//  Created by Adrian König Mintellity on 14.02.19.
//  Copyright © 2019 Mintellity. All rights reserved.
//

#import "AppDelegate.h"
#import <UIKit/UIKit.h>
#import "SDKLogs.h"

#import <AugmentifySDK/AugmentifySDK.h>
#ifdef AugmentifyImport
#import <AugmentifySDK/AugmentifySDK-Swift.h>

#endif

/// place your appToken here
static NSString * const sdkAppToken = @"your-app-token";

/// place your sdkSecret here
static NSString * const sdkSecret = @"your-app-secret";


@interface AppDelegate ()

@property (nonatomic,retain) SDKLogs *sdkLogs;

@end

@implementation AppDelegate

-(SDKLogs *)sdkLogs{
    if(!_sdkLogs){
        _sdkLogs = [SDKLogs new];
    }
    return _sdkLogs;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
#ifdef AugmentifyImport
    if(AugmentifySDKManager.shared.isSupported){
        // optional, receive errors from the SDK
        [AugmentifySDKManager.shared addErrorDelegate:self.sdkLogs];
        // reiceive status updates of the SDK.
        // The SDK must have the state AugmentifySyncStateAllLoaded to open any Experience
        [AugmentifySDKManager.shared addStatusDelegate:self.sdkLogs];
        [AugmentifySDKManager.shared configureWithAppToken:sdkAppToken
                                                    secret:sdkSecret];
        [[AugmentifySDKManager shared] start];
    }
#endif
    
    return YES;
}

#ifdef AugmentifyImport
//Entry point for URLSchemes
- (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options{
    if(AugmentifySDKManager.shared.isSupported) {
        //the app didnt start by application:didFinishLaunchingWithOptions:, we need to start the SDK
        // optional, receive errors from the SDK
        [AugmentifySDKManager.shared addErrorDelegate:self.sdkLogs];
        // reiceive status updates of the SDK.
        // The SDK must have the state AugmentifySyncStateAllLoaded to open any Experience
        [AugmentifySDKManager.shared addStatusDelegate:self.sdkLogs];
        [AugmentifySDKManager.shared configureWithAppToken:sdkAppToken
                                                    secret:sdkSecret];
        [[AugmentifySDKManager shared] start];
        //your URLQuerry
        NSString *myAppRedirect = [@"augmentify" stringByAppendingString:sdkAppToken];
        //check if the userActivity is targeted for Augmentify
        if([url.absoluteString containsString:myAppRedirect]){
            UIViewController *currentViewController = self.window.rootViewController;
            [AugmentifySDKManager.shared createAugmentifyViewControllerForUrl:url success:^(UIViewController *vc) {
                //make sure the view controller isnt presenting any other viewController
                [currentViewController dismissViewControllerAnimated:YES completion:nil];
                //present the Augmentify Experience
                [currentViewController presentViewController:vc animated:NO completion:nil];
            } failure:^(NSError *error) {
                NSLog(@"%@",error);
            }];
        }
    }
    return YES;
}

//Entry point for Universal Links
- (BOOL)application:(UIApplication *)application continueUserActivity:(NSUserActivity *)userActivity restorationHandler:(void(^)(NSArray<id<UIUserActivityRestoring>> * __nullable restorableObjects))restorationHandler{
    
    if([userActivity.activityType isEqualToString:NSUserActivityTypeBrowsingWeb]){
        
        if(AugmentifySDKManager.shared.isSupported) {
            NSURL *url = userActivity.webpageURL;
            //Source of your Association File
            NSString *myAppRedirect = @"https://augmentify.yourdomain.com";
            //check if the scheme is targeted for Augmentify
            if([url.absoluteString containsString:myAppRedirect]){
                [AugmentifySDKManager.shared createAugmentifyViewControllerForUrl:url success:^(UIViewController *vc) {
                    UIViewController *currentViewController = self.window.rootViewController;
                    //make sure the view controller isnt presenting any other viewController
                    [currentViewController dismissViewControllerAnimated:YES completion:nil];
                    //present the Augmentify Experience
                    [currentViewController presentViewController:vc animated:NO completion:nil];
                } failure:^(NSError *error) {
                    NSLog(@"%@",error);
                }];
            }
        }
    }
    return YES;
}

#endif

@end


