//
//  MyHeader.swift
//  AugmentifySDK Swift Demo
//
//  Created by Adrian König Mintellity on 19.08.19.
//  Copyright © 2019 Mintellity. All rights reserved.
//

import Foundation
import UIKit

class MyHeader : UIView {
    
    /// Helper method to check for iPhone X notch.
    @available(iOS 12.0, *)
    static var topSafeAreaInset : CGFloat {
        UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0.0
    }
    
    lazy var myLabel : UILabel = {
        let ret = UILabel()
        self.addSubview(ret)
        ret.text = "my header"
        ret.textAlignment = .center
        return ret
    }()
    
    lazy var line : UIView = {
        let ret = UIView()
        self.addSubview(ret)
        ret.backgroundColor = UIColor.black
        return ret
    }()
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("NSCoding not supported")
    }
    
    init() {
        super.init(frame: CGRect.init())
        self.backgroundColor = UIColor.white
    }
    
    override func layoutSubviews() {
        self.myLabel.frame = CGRect(x: 0,
                                    y: 0,
                                    width: self.frame.width,
                                    height: self.frame.height - 1)
        self.line.frame = CGRect(x: 0,
                                 y: self.myLabel.frame.maxY,
                                 width: self.frame.width,
                                 height: self.frame.height - self.myLabel.frame.maxY)
    }
}
