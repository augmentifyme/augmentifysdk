//
//  ViewController.swift
//  AugmentifySDK Swift Demo
//
//  Created by Adrian König Mintellity on 25.02.19.
//  Copyright © 2019 Mintellity. All rights reserved.
//

import UIKit
import AugmentifySDK

class ViewController: UIViewController {

    @IBOutlet weak var showBTN: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.showBTN.isHidden = true
        if #available(iOS 12.0, *) {
            self.showBTN.addTarget(self, action: #selector(self.openExperiences), for: .touchUpInside)
            AugmentifySDKManager.shared.addStatusDelegate(self)
        } else {
            print("Device doesnt support AR.")
        }
    }
    
    @objc func openExperiences() {
        if #available(iOS 12.0, *) {
            if AugmentifySDKManager.shared.isReady, let vc = AugmentifySDKManager.shared.createAugmentifyViewController() {
                self.navigationController?.pushViewController(vc, animated: true)
            } else{
                print("AugmentifyViewController couldnt be created, check the error delegate.")
            }
        } else {
            // Fallback on earlier versions.
        }
    }
}

extension ViewController : AugmentifyStatusDelegate {
    func syncChangedFromState(oldState: AugmentifySyncState, newState: AugmentifySyncState) {
        if newState.finished {
            self.showBTN.isHidden = false
        }
    }
}
