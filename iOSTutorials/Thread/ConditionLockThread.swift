//
//  ConditionLockThread.swift
//  iOSTutorials
//
//  Created by CaryZheng on 2018/2/24.
//  Copyright © 2018年 CaryZheng. All rights reserved.
//

import Foundation

let NO_DATA = 1
let GOT_DATA = 2
let conditionLock = NSConditionLock(condition: NO_DATA)
var sharedInt = 0

class ProducerThread: Thread {
    
    override func main() {
        for i in 0..<5 {
            // 当条件为 NO_DATA 时，获取锁
            // 如果不想等待消费者，可以通过 conditionLock.lock() 直接获取锁
            conditionLock.lock(whenCondition: NO_DATA)
            
            print("ProducerThread main acquired lock")
            
            sharedInt = i
            
            print("ProducerThread main sharedInt = \(sharedInt)")
            
            // 解锁并设置条件为 GOT_DATA
            conditionLock.unlock(withCondition: GOT_DATA)
        }
    }
    
}

class ConsumerThread: Thread {
    
    override func main() {
        for i in 0..<5 {
            // 当条件为 GOT_DATA 时，获取锁
            conditionLock.lock(whenCondition: GOT_DATA)
            
            print("ConsumerThread main acquired lock")
            
            sharedInt = i
            
            print("ConsumerThread main sharedInt = \(sharedInt)")
            
            // 解锁并设置条件为 NO_DATA
            conditionLock.unlock(withCondition: NO_DATA)
        }
    }
    
}
