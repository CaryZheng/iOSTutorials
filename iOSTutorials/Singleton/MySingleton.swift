//
//  MySingleton.swift
//  iOSTutorials
//
//  Created by CaryZheng on 2018/2/26.
//  Copyright © 2018年 CaryZheng. All rights reserved.
//

import Foundation

final class MySingleton {
    
    public static let sharedInstance: MySingleton = MySingleton()
    
    private init() {
        print("MySingleton init")
    }
    
    public func printLog() {
        print("MySingleton printLog called")
    }
    
}
