//
//  RThread.swift
//  iOSTutorials
//
//  Created by CaryZheng on 2018/2/24.
//  Copyright © 2018年 CaryZheng. All rights reserved.
//

import Foundation

// 递归锁
let rLock = NSRecursiveLock()

class RThread: Thread {
    
    override func main() {
        rLock.lock()
        print("Thread main acquired lock")
        callMe()
        rLock.unlock()
        print("RThread main exit")
    }
    
    private func callMe() {
        rLock.lock()
        print("Thread callMe acquired lock")
        rLock.unlock()
        print("RThread callMe exit")
    }
    
}
