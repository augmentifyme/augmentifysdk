//
//  SDKLogs.swift
//  AugmentifySDK Swift Demo
//
//  Created by Adrian König Mintellity on 18.07.19.
//  Copyright © 2019 Mintellity. All rights reserved.
//

import Foundation
import AugmentifySDK

class DemoSDKErrorLog : AugmentifyErrorDelegate {
    func didReceiveError(_ error: Error) {
        print("-----ErrorLog-----")
        print(error)
        print("-----ErrorLog-----")
    }
}

class DemoSDKLog : AugmentifyStatusDelegate{
    func syncChangedFromState(oldState: AugmentifySyncState, newState: AugmentifySyncState) {
        print("-----SyncState-----")
        print("\(oldState.toString) -> \(newState.toString)")
        print("-----SyncState-----")
    }
}
