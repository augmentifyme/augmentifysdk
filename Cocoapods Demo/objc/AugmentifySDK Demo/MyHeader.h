//
//  MyHeader.h
//  AugmentifySDK Demo
//
//  Created by Adrian König Mintellity on 19.08.19.
//  Copyright © 2019 Mintellity. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MyHeader : UIView

/// helper method to check for iPhone X notch
@property (nonatomic,readonly,class) CGFloat topSafeAreaInset API_AVAILABLE(ios(11));

@end

NS_ASSUME_NONNULL_END
