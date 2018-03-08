//
//  QueueViewController.swift
//  iOSTutorials
//
//  Created by CaryZheng on 2018/2/25.
//  Copyright © 2018年 CaryZheng. All rights reserved.
//

import UIKit

class QueueViewController: ZViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 串行队列
//        let serialQueue = DispatchQueue(label: "com.zzb.serial")
//        // 并行队列
//        let consurrentQueue = DispatchQueue(label: "com.zzb.concurrent", attributes: .concurrent)
//
//        // 主队列
//        let mainQueue = DispatchQueue.main
//        // 全局队列
        let globalQueue = DispatchQueue.global()
//
//        // 队列优先级从高到低(QoSClass)
//        // userInteractive
//        // userInitiated
//        // default
//        // utility
//        // background
//        // unspecified
//        let backgroundQueue = DispatchQueue.global(qos: .background)
//
//        // 自定义队列 - 高优先级
//        let serialQueueHighPriority = DispatchQueue(label: "com.zzb.highSerial", qos: .userInteractive)
//
//        // 异步执行
//        globalQueue.async {
//            print("globalQueue async execute")
//        }
//        // 同步执行
//        globalQueue.sync {
//            print("globalQueue sync execute")
//        }
//
//        // 后台执行任务，然后主线程更新UI
//        DispatchQueue.global(qos: .background).async {
//            // TODO: 后台运行的代码
//
//            DispatchQueue.main.async {
//                print("UI thread execute")
//            }
//        }
//
//        // 延时执行
//        globalQueue.asyncAfter(deadline: .now() + .seconds(2)) {
//            print("Execute after 2s")
//        }
//
//        // 同时执行一个相同的闭包
//        globalQueue.sync {
//            DispatchQueue.concurrentPerform(iterations: 5) {
//                print("\($0) times")
//            }
//        }
//
//        // 手动激活队列任务
//        // 注意：setTarget(queue:) 方法可以用来配置非活跃队列的优先级（使用它来设置活跃队列将导致崩溃），调用此方法，把队列的优先级设置为作为参数传入队列的优先级。
//        let inactiveQueue = DispatchQueue(label: "com.zzb.inactiveQueue", attributes: [.concurrent, .initiallyInactive])
//        inactiveQueue.async {
//            print("inactiveQueue execute")
//        }
//        print("inactiveQueue not start")
//        inactiveQueue.activate()
//
//        // 挂起
//        inactiveQueue.suspend()
//        // 恢复
//        inactiveQueue.resume()
        
        // 通过 屏障(barrier) 实现所有异步任务完成后再执行一个任务
        // 分发屏障不能作用与串行队列或者任何一种类型的全局并行队列，如果你想使用它，就必须自定义一个全新的并行队列。
//        let concurrentQueue2 = DispatchQueue(label: "com.zzb.concurrent", attributes: .concurrent)
//        concurrentQueue2.async {
//            DispatchQueue.concurrentPerform(iterations: 5) { (id: Int) in
//                sleep(1)
//                print("concurrentQueue2 execute 5 times, current id = \(id)")
//            }
//        }
//
//        concurrentQueue2.async(flags: .barrier) {
//            print("All 5 concurrent tasks completed")
//        }
        
        // DispatchGroup
        // 一旦所有任务完成以后，将会在队列中执行一个闭包，wait()方法用于执行阻塞等待
//        let dispatchGroup = DispatchGroup()

//        for i in 0..<5 {
//            globalQueue.async(group: dispatchGroup) {
//                sleep(UInt32(i))
//                print("Group async on globalQueue: \(i)")
//            }
//        }
//
//        print("Waiting for completion")
//        dispatchGroup.notify(queue: globalQueue) {
//            print("dispatchGroup notify")
//        }
//
//        print("dispatchGroup begin wait")
//        dispatchGroup.wait()
//        print("dispatchGroup wait done")

        // 手动在运行队列代码调用中进入和离开一个组
//        for i in 0..<5 {
//            dispatchGroup.enter()
//
//            sleep(UInt32(i))
//            print("Group sync i = \(i)")
//
//            dispatchGroup.leave()
//        }
        
        // DispatchWorkItem
//        let workItem = DispatchWorkItem {
//            print("workItem done")
//        }
////        workItem.perform()
//
//        workItem.notify(queue: DispatchQueue.main) {
//            print("workItem notify")
//        }
//
//        DispatchQueue.main.async(execute: workItem)
        
//        print("workItem waiting")
//        workItem.wait()
//        print("workItem cancel")
//        workItem.cancel()
        
        // DispatchSemaphore
//        testDispatchSemaphore()
        
        // DispatchPrecondition
//        testDispatchPrecondition()
        
        // DispatchSource
//        testDispatchSource()
        
        // OperationQueue
        testOperationQueue()
    }
    
    private func testDispatchSemaphore() {
        let dispatchSemaphore = DispatchSemaphore(value: 2)
        
        let globalQueue = DispatchQueue.global()
        
        globalQueue.sync {
            DispatchQueue.concurrentPerform(iterations: 10) { (id: Int) in
                _ = dispatchSemaphore.wait(timeout: DispatchTime.distantFuture)
                sleep(3)
                print("\(id) acquired semaphore")
                dispatchSemaphore.signal()
            }
        }
    }
    
    private func testDispatchPrecondition() {
        dispatchPrecondition(condition: .notOnQueue(DispatchQueue.main))
    }
    
    let dispatchSourceTimer = DispatchSource.makeTimerSource()
    private func testDispatchSource() {
        dispatchSourceTimer.setEventHandler {
            print("dispatchSourceTimer event handle")
        }
        dispatchSourceTimer.schedule(deadline: .now() + .seconds(2))
        
        dispatchSourceTimer.activate()
    }
    
    private func testOperationQueue() {
        let queue = OperationQueue()
        queue.name = "zzb"
        queue.maxConcurrentOperationCount = 2
        
//        let mainQueue = OperationQueue.main   // 引用主线程中的队列
        
        queue.addOperation {
            print("op1")
        }
        
        queue.addOperation {
            print("op2")
        }
        
        // BlockOperation
        let op3 = BlockOperation {
            print("op3")
        }
        op3.queuePriority = .veryHigh
        op3.completionBlock = {
            print("op3 completionBlock")
        }
        
        let op4 = BlockOperation {
            print("op4")
            OperationQueue.main.addOperation {
                print("op4 main queue")
            }
        }
        
        op4.addDependency(op3)  // op4依赖于op3，意味着op3将会先于op4执行
        queue.addOperation(op4)
        queue.addOperation(op3)
        
//        queue.cancelAllOperations()
//        queue.isSuspended = true    // 在操作队列中停止新操作的执行（当前执行中的操作不会被影响）
    }
    
}
