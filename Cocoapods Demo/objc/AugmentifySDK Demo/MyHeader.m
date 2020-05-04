//
//  MyHeader.m
//  AugmentifySDK Demo
//
//  Created by Adrian König Mintellity on 19.08.19.
//  Copyright © 2019 Mintellity. All rights reserved.
//

#import "MyHeader.h"

@interface MyHeader()

@property (nonatomic,retain) UILabel *myLabel;
@property (nonatomic,retain) UIView *line;

@end

@implementation MyHeader

+(CGFloat) topSafeAreaInset{
    
    UIWindow *keyWindow =  UIApplication.sharedApplication.keyWindow;
    if(keyWindow){
        return keyWindow.safeAreaInsets.top;
    }
    return 0;
}

-(id)init{
    self = [super init];
    if(self){
        [self commonInit];
    }
    return self;
}


-(void)commonInit{
    self.backgroundColor = UIColor.whiteColor;
    
    self.myLabel = [UILabel new];
    self.myLabel.text = @"my header";
    self.myLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.myLabel];
    
    self.line = [UIView new];
    self.line.backgroundColor = UIColor.blackColor;
    [self addSubview:self.line];
}

-(void)layoutSubviews{
    self.myLabel.frame = CGRectMake(0,
                                    0,
                                    self.frame.size.width,
                                    self.frame.size.height - 1);
    
    self.line.frame = CGRectMake(0,
                                 CGRectGetMaxY(self.myLabel.frame),
                                 self.frame.size.width,
                                 self.frame.size.height - CGRectGetMaxY(self.myLabel.frame));
}

@end
