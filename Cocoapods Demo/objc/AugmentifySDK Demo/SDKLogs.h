//
//  SDKLogs.h
//  AugmentifySDK Demo
//
//  Created by Adrian König Mintellity on 18.07.19.
//  Copyright © 2019 Mintellity. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <AugmentifySDK/AugmentifySDK.h>
#ifdef AugmentifyImport
#import <AugmentifySDK/AugmentifySDK-Swift.h>
#endif

@interface SDKLogs : NSObject

@end


#ifdef AugmentifyImport
@interface SDKLogs(AugmentifyExtension)<AugmentifyErrorDelegate,AugmentifyStatusDelegate>

@end

#endif

