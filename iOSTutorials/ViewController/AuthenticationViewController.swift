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
        // 判断是否支持指纹/密码验证识别
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            print("Support authentication")
            
            // 请求验证
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: localizedReason, reply: {
                (success, error) in
                
                if success {
                    if nil != context.evaluatedPolicyDomainState {
                        // 指纹验证成功
                        print("TouchID success")
                    } else {
                        // 密码验证成功
                        print("Input password success")
                    }
                } else {
                    // 验证失败
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
            // 不支持指纹/密码验证识别
            print("Do not support authentication")
        }
    }
    
}
