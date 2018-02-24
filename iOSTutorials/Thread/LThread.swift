//
//  LThread.swift
//  iOSTutorials
//
//  Created by CaryZheng on 2018/2/24.
//  Copyright © 2018年 CaryZheng. All rights reserved.
//

import Foundation

// 线程锁
let lock = NSLock()

class LThread: Thread {
    
    var id: Int = 0
    
    convenience init(id: Int) {
        self.init()
        
        self.id = id
    }
    
    override func main() {
        lock.lock()
        print("\(id) acquired lock")
        lock.unlock()
        if lock.try() {
            print("\(id) acquired lock again")
            lock.unlock()
        } else {
            print("\(id) couldn't acquire lock")
        }
        print("\(id) exit")
    }
    
}
