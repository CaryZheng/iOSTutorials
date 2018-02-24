//
//  ThreadViewController.swift
//  iOSTutorials
//
//  Created by CaryZheng on 2018/2/24.
//  Copyright © 2018年 CaryZheng. All rights reserved.
//

import UIKit

class ThreadViewController: ZViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        // 开启一个新线程（方式1）
//        Thread.detachNewThread {
//            print("New 1 thread: \(Thread.current)")
//        }
//
//        // 开启一个新线程（方式2）
//        Thread.detachNewThreadSelector(#selector(handlePrint), toTarget: self, with: nil)
//
//        // 开启一个新线程（方式3）- 直接实例化Thread对象
//        let myThread = Thread {
//            print("New 3 thread: \(Thread.current)")
//        }
//
//        myThread.stackSize = 1024 * 16
//        myThread.start()
//
//        // NSLock
//        testLock()
        
        // NSRecursiveLock
        testNSRecursiveLock()
    }
    
    @objc private func handlePrint() {
        print("New 2 thread: \(Thread.current)")
    }
    
    private func testLock() {
        let t1 = LThread(id: 1)
        let t2 = LThread(id: 2)
        t1.start()
        t2.start()
    }
    
    private func testNSRecursiveLock() {
        let thread = RThread()
        thread.start()
    }
}
