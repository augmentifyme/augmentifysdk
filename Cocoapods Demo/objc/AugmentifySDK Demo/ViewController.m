//
//  ViewController.m
//  AugmentifySDK Demo
//
//  Created by Adrian König Mintellity on 14.02.19.
//  Copyright © 2019 Mintellity. All rights reserved.
//

#import "ViewController.h"
#import "MBProgressHUD.h"

#import <AugmentifySDK/AugmentifySDK.h>
#ifdef AugmentifyImport
#import <AugmentifySDK/AugmentifySDK-Swift.h>
#import "MyHeader.h"
#endif

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UIButton *showBTN;

@end

#ifdef AugmentifyImport

@interface ViewController(AugmentifyExtensions)<AugmentifyStatusDelegate>

@end

#endif

@implementation ViewController

-(void)showLoadingAnimation{
     [MBProgressHUD showHUDAddedTo:self.view animated:true];
}

-(void)removeLoadingAnimation{
    [MBProgressHUD hideHUDForView:self.view animated:true];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.showBTN.hidden = YES;
#ifdef AugmentifyImport
    if (@available(iOS 12.0, *)) {
        // reiceive status updates of the SDK. The SDK must have the state AugmentifySyncStateAllLoaded to open any Experience
        [AugmentifySDKManager.shared addStatusDelegate:self];
    }
    else {
        // Only Devices with an A9 or later processor support ARKit
        NSLog(@"Device doesnt support AR");
    }
#endif
}

-(void)openExperience{
    
#ifdef AugmentifyImport
    if (@available(iOS 12.0, *)) {
        if(AugmentifySDKManager.shared.isReady) {
            UIViewController<AugmentifyViewControllerProtocol> *vc = [AugmentifySDKManager.shared createAugmentifyViewControllerWithExperience:nil];
            // set a view as your header
            vc.headerView = [MyHeader new];
            // make the header a little bigger when theres a notch
            vc.headerHeight = MyHeader.topSafeAreaInset + 40;
            [self.navigationController pushViewController:vc animated:YES];
        }
    }
    else {
        // Fallback on earlier versions
    }
#endif
}

@end

#ifdef AugmentifyImport

@implementation ViewController(AugmentifyExtensions)

- (void)syncChangedFromStateWithOldState:(enum AugmentifySyncState)oldState newState:(enum AugmentifySyncState)newState {
    
    if(newState == AugmentifySyncStateAllLoaded) {
        self.showBTN.hidden = NO;
        [self.showBTN addTarget:self action:@selector(openExperience) forControlEvents:UIControlEventTouchUpInside];
    }
}

@end

#endif
