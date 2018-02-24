//
//  ConditionThread.swift
//  iOSTutorials
//
//  Created by CaryZheng on 2018/2/24.
//  Copyright © 2018年 CaryZheng. All rights reserved.
//

import Foundation

let condition = NSCondition()
var available = false
var sharedString = ""

class WriterThread: Thread {
    
    override func main() {
        for i in 0..<5 {
            condition.lock()
            
            sharedString = "zzb_\(i)"
            available = true
            
            condition.signal()  // 通知并且唤醒等待的线程
            
            condition.unlock()
        }
    }
    
}

class PrinterThread: Thread {
    
    override func main() {
        for _ in 0..<5 {
            condition.lock()
            
            while(!available) {
                condition.wait()
            }
            print("PrinterThread main sharedString = \(sharedString)")
            sharedString = ""
            available = false
            
            condition.unlock()
        }
    }
    
}
