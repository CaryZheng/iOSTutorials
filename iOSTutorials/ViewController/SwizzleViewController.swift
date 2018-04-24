//
//  SwizzleViewController.swift
//  iOSTutorials
//
//  Created by CaryZheng on 2018/4/24.
//  Copyright © 2018年 CaryZheng. All rights reserved.
//

import UIKit

extension UIColor {
    
    @objc func colorDescription() -> String {
        return "zzb test color"
    }
    
    private static let swizzleDesriptionImplementation: Void = {
        let instance: UIColor = UIColor.red
        
        let aClass: AnyClass! = object_getClass(instance)
        let originalMethod = class_getInstanceMethod(aClass, #selector(description))
        let swizzledMethod = class_getInstanceMethod(aClass, #selector(colorDescription))
        
        if let originalMethod = originalMethod, let swizzledMethod = swizzledMethod {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }()
    
    static func swizzleDescription() {
        self.swizzleDesriptionImplementation
    }
    
}

class MyTest: NSObject {
    @objc dynamic func getCount() -> Int {
        return 98
    }
}

extension MyTest {
    
    @objc dynamic func getCountNew() -> Int {
        return 100
    }
    
    private static let swizzleDesriptionImplementation: Void = {
        let instance: MyTest = MyTest()
        
        let aClass: AnyClass! = object_getClass(instance)
        let originalMethod = class_getInstanceMethod(aClass, #selector(getCount))
        let swizzledMethod = class_getInstanceMethod(aClass, #selector(getCountNew))
        
        if let originalMethod = originalMethod, let swizzledMethod = swizzledMethod {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }()
    
    static func swizzleDescription() {
        self.swizzleDesriptionImplementation
    }
}

class SwizzleViewController: ZViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testSwizzleFunc()
        
        testSwizzleFunc2()
    }
    
    private func testSwizzleFunc() {
        print(UIColor.red)
        print(UIColor.blue)
        
        UIColor.swizzleDescription()
        
        print(UIColor.red)
        print(UIColor.blue)
    }
    
    private func testSwizzleFunc2() {
        let myTest = MyTest()
        let count = myTest.getCount()
        print("count = \(count)")
        
        MyTest.swizzleDescription()
        
        let countNew = myTest.getCount()
        print("countNew = \(countNew)")
    }
    
}

