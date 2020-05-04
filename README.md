# Prerequisite

In order to compile and run Augmentify Xcode 11 is required.

# Installation

## Framework

1. 	Make sure your Swift Version is 5.1 (or higher). To enable Swift in a pure Objective-C project create any Swift file.
2. 	Go to your Xcode project’s “General” settings. Drag AugmentifySDK.framework to the “Embedded Binaries” section. Make sure "Copy items if needed" is selected and click "Finish".

## Cocoapods

1. Add a pod entry for Augmentify to your Podfile `pod 'AugmentifySDK'`
2. Install the pod by running `pod install`.


# Examples

There are two folders, one for the framework integration, one for the cocoapods integration. Each contains a swift and an objective-c demo.

## Swift
An example written in Swift, showing how to start Augmentify.
Uses `if #available(iOS 12.0, *)` to enable compiling the app for earlier iOS versions.
Implements the `AugmentifyStatusDelegate` to start Augmentify as soon as the SDK is ready.

## Objc
An example written in Objective-C, showing how to start Augmentify.
Uses several `define` and `if(@available(iOS 12.0, *))` statements to enable compiling the app for earlier iOS versions.
Implements the `AugmentifyStatusDelegate` to start Augmentify as soon as the SDK is ready.


# Usage

## Check if device supports Augmentify 

Augmentify supports devices with iOS 10 or later.
To open AR experiences iOS 12 or later and a minimum A9 processor are required to support ARKit 2.0.


Swift: 

```swift
    if AugmentifySDKManager.shared.isSupported {
        // run augmentify
        if #available(iOS 12.0, *) {
            // open AR experience
        }
        else {
            // fallback for older versions
        }
    }
```

Objective-C:

```objective-c
    if(AugmentifySDKManager.shared.isSupported) {
        // run augmentify
        if(@available(iOS 12.0, *)) {
            // open AR experience
        }
        else {
            // fallback for older versions
        }
    }
	
```

## Configure the SDK

Swift: 

```swift
AugmentifySDKManager.shared.configureWith(appToken: "your-app-token",
												  secret: "your-app-secret")
AugmentifySDKManager.shared.start()
```

Objective-C:

```objective-c
[AugmentifySDKManager.shared configureWithAppToken:@"your-app-token"
                                      	    secret:@"your-app-secret"];
[[AugmentifySDKManager shared] start];	
```

## Start Augmentify

To start Augmentify the SDK has to be ready to showcase an Experience

Swift: 

```swift
if #available(iOS 12.0, *) {
    if AugmentifySDKManager.shared.isReady {
        if let vc = AugmentifySDKManager.shared.createAugmentifyViewController(){
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
```

Objective-C:

```objective-c
if (@available(iOS 12.0, *)) {
    if(AugmentifySDKManager.shared.status == AugmentifySyncStateAllLoaded){
        UIViewController *vc = [AugmentifySDKManager.shared createAugmentifyViewController];
        [self.navigationController pushViewController:vc animated:YES];
    }
}
```
## Permissions

### Required permissions

In order to launch Augmentify the camera usage permissions is required.
Open up the _Info.plist_, add _Privacy — Camera Usage Description_ and enter a suitable description.

[Apple documentation for Camera Usage Description](https://developer.apple.com/library/archive/documentation/General/Reference/InfoPlistKeyReference/Articles/CocoaKeys.html#//apple_ref/doc/plist/info/NSCameraUsageDescription)

### Optional permissions

Augmentify allows the user to take photos with the experience in order to share them. When the user decides to save the taken picture the _Privacy - Photo Library Additions Usage Description_ permission is required. Open up the _Info.plist_, add _Privacy - Photo Library Additions Usage Description_ and enter a fitting text for the user.

[Apple documentation for Photo Library Additions Usage Description](https://developer.apple.com/library/archive/documentation/General/Reference/InfoPlistKeyReference/Articles/CocoaKeys.html#//apple_ref/doc/uid/TP40009251-SW73)



# Start Augmentify from external sources

## Using custom URL Schemes

[Apple documentation for Custom URL Schemes](https://developer.apple.com/documentation/uikit/inter-process_communication/allowing_apps_and_websites_to_link_to_your_content)

### Define the format for your URL

The format required for your URL scheme is `augmentify{appToken}`. Replace `{appToken}` with your appToken.

### Register your scheme

Register your scheme in Xcode from the Info tab of your project settings. In `URL Types` press plus. Fill `URL Schemes` with your scheme. The remaining fields may be left blank.

### Handle URLs

We need to add the Augmentify handling to `application(_:open:options:)` for incoming schemes.

Swift: 

```swift
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
            let myAppRedirect = "augmentify{appToken}"
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
```

Objective-C:

```objective-c
//Entry point for URLSchemes
- (BOOL)application:(UIApplication *)app
            openURL:(NSURL *)url
            options:(NSDictionary<UIApplicationOpenURLOptionsKey, id> *)options{
    if(@available(iOS 12.0, *)) {
        //the app didnt start by application:didFinishLaunchingWithOptions:, we need to start the SDK
        // optional, receive errors from the SDK
        [AugmentifySDKManager.shared addErrorDelegate:self.sdkLogs];
        // reiceive status updates of the SDK.
        // The SDK must have the state AugmentifySyncStateAllLoaded to open any Experience
        [AugmentifySDKManager.shared addStatusDelegate:self.sdkLogs];
        [AugmentifySDKManager.shared configureWithAppToken:sdkApptoken
                                                    secret:sdkSecret];
        [[AugmentifySDKManager shared] start];
        //your URLQuerry
        NSString *myAppRedirect = @"augmentify{appToken}";
        UIViewController *currentViewController = self.window.rootViewController;
        //check if the userActivity is targeted for Augmentify
        if([url.absoluteString containsString:myAppRedirect]){
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
```

## Using universal links

[Apple documentation for universal links](https://developer.apple.com/documentation/uikit/inter-process_communication/allowing_apps_and_websites_to_link_to_your_content)

This method requires to add an Apple App Site Association file to your website.


### Integrate the associated domain

To start augmentify from external sources you need to register an associated domain.
To do so, go into your Xcode Project, and open capabilities and check `Associated Domains`
Then enter <br/><br/>
`applinks: yourdomain.com`<br/>

Replace *yourdomain.com* with your custom domain. You can use any subdomain, you don't need to use your toplevel domain, so for *yourdomain.com* you could use *augmentify.yourdomain.com*.

In the root directory of *augmentify.yourdomain.com* you have to create a file called `apple-app-site-association` **(no file extension)**

The content of the file is the following:

```
{
  "applinks": {
    "apps": [],
    "details": [
      {
        "appID": "TEAMID.BUNDLEID",
        "paths":[ "*" ]
      }
    ]
  }
}
```

Replace **TEAMID** with your Team-Identifier and **BUNDLEID** with your apps bundle identifier (case sensitive).

### Implementation in code

Your app needs to implement the method<br/><br/>
`application:continueUserActivity:restorationHandler:`<br/>

inside the AppDelegate and check `userActivity.type == NSUserActivityTypeBrowsingWeb`
and get the webpageURL from `userActivity.webpageURL`.<br/> 

To target a specific Augmentify Experience, construct a url with a query parameter `experience_id` like<br/>

`https://augmentify.yourdomain.com/ar?experience_id=1FC4A`<br/>

where *1FC4A* can be replaced by the experience id you like.

After that just append the following code:

Swift: 

```swift
AugmentifySDKManager.shared.createAugmentifyViewController(forUrl: userActivity.webpageURL!, success: { (vc:   UIViewController) -> (Void) in
            //make sure the view controller isnt presenting any other viewController
            let currentViewController = self.window?.rootViewController
            currentViewController?.dismiss(animated: false, completion: nil)
            
            //present the Augmentify Experience
            currentViewController?.present(vc, animated: true, completion: nil)
        }) { (error: NSError) -> (Void) in
            print(error)
        }
```

Objective-C:

```objective-c
    [AugmentifySDKManager.shared createAugmentifyViewControllerForUrl:userActivity.webpageURL success:^(UIViewController *vc) {
        //make sure the view controller isnt presenting any other viewController
        UIViewController *currentViewController = self.window.rootViewController;
        [currentViewController dismissViewControllerAnimated:YES completion:nil];
        
        //present the Augmentify Experience
        [currentViewController presentViewController:vc animated:NO completion:nil];
    } failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
```

More info regarding *Universal Links* can be found in the Apple documentation here:<br/><br/> Objective-C: <br/> <a href="https://developer.apple.com/documentation/uikit/inter-process_communication/allowing_apps_and_websites_to_link_to_your_content?language=objc">https://developer.apple.com/documentation/uikit/inter-process_communication/allowing_apps_and_websites_to_link_to_your_content?language=objc</a>


Swift:<br/>
<a href="https://developer.apple.com/documentation/uikit/inter-process_communication/allowing_apps_and_websites_to_link_to_your_content">https://developer.apple.com/documentation/uikit/inter-process_communication/allowing_apps_and_websites_to_link_to_your_content</a>



# Customization

## Header

You can assign a custom header view for the _AugmentifyViewController_.

Swift: 

```swift
if let vc = AugmentifySDKManager.shared.createAugmentifyViewController(){
    // set a view as your header
    vc.headerView = MyHeader()
    //customize the header height
    vc.headerHeight = 50
}
```

Objective-C:

```objective-c
UIViewController<AugmentifyViewControllerProtocol> *vc = [AugmentifySDKManager.shared createAugmentifyViewController];
// set a view as your header
vc.headerView = [MyHeader new];
//customize the header height
vc.headerHeight = 50;
```
