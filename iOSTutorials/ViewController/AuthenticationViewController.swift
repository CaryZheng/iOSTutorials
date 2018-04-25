//
//  AuthenticationViewController.swift
//  iOSTutorials
//
//  Created by CaryZheng on 2018/4/25.
//  Copyright © 2018年 CaryZheng. All rights reserved.
//

import UIKit
import LocalAuthentication

class AuthenticationViewController: ZViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testTouchID()
    }
    
    private func testTouchID() {
        let context = LAContext()
        context.localizedFallbackTitle = "Verify gesture password"
        
        let localizedReason = "Test auth"
        
        var error: NSError? = nil
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            print("Support authentication")
            
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: localizedReason, reply: {
                (success, error) in
                
                if success {
                    if nil != context.evaluatedPolicyDomainState {
                        print("TouchID success")
                    } else {
                        print("Input password success")
                    }
                } else {
                    print("Error = \(String(describing: error))")
                    
                    if let error = error as? LAError {
                        switch error.code {
                        case LAError.userCancel:
                            print("Error result: userCancel")
                        case LAError.appCancel:
                            print("Error result: appCancel")
                        case LAError.authenticationFailed:
                            print("Error result: authenticationFailed")
                        case LAError.biometryLockout:
                            print("Error result: biometryLockout")
                        case LAError.biometryNotAvailable:
                            print("Error result: biometryNotAvailable")
                        case LAError.biometryNotEnrolled:
                            print("Error result: biometryNotEnrolled")
                        case LAError.passcodeNotSet:
                            print("Error result: passcodeNotSet")
                        case LAError.systemCancel:
                            print("Error result: systemCancel")
                        case LAError.userFallback:
                            print("Error result: userFallback")
                        default:
                            break
                        }
                    }
                }
            })
            
        } else {
            print("Do not support authentication")
        }
    }
    
}
