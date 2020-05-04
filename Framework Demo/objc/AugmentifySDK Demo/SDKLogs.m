//
//  SDKLogs.m
//  AugmentifySDK Demo
//
//  Created by Adrian König Mintellity on 18.07.19.
//  Copyright © 2019 Mintellity. All rights reserved.
//

#import "SDKLogs.h"

@implementation SDKLogs


@end

#ifdef AugmentifyImport
@implementation SDKLogs(AugmentifyExtension)

- (void)didReceiveError:(NSError * _Nonnull)error {
    NSLog(@"%@",@"-----ErrorLog-----");
    NSLog(@"%@",error);
    NSLog(@"%@",@"-----ErrorLog-----");
}

- (void)syncChangedFromStateWithOldState:(enum AugmentifySyncState)oldState newState:(enum AugmentifySyncState)newState {
    
//    NSLog(@"%@",@"-----SyncState-----");
    switch (newState){
            
        case AugmentifySyncStateNotStarted:
            NSLog(@"AugmentifySyncStateNotStarted");
            break;
        case AugmentifySyncStateError:
            NSLog(@"AugmentifySyncStateError");
            break;
        case AugmentifySyncStateStarting:
            NSLog(@"AugmentifySyncStateStarting");
            break;
        case AugmentifySyncStateAllLoaded:
            NSLog(@"AugmentifySyncStateAllLoaded");
            break;
    }
//    NSLog(@"%@",@"-----SyncState-----");
}

@end
#endif

