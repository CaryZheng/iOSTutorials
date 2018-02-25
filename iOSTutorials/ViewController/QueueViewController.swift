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
        
//        // 串行队列
//        let serialQueue = DispatchQueue(label: "com.zzb.serial")
//        // 并行队列
//        let consurrentQueue = DispatchQueue(label: "com.zzb.concurrent", attributes: .concurrent)
//
//        // 主队列
//        let mainQueue = DispatchQueue.main
        // 全局队列
//        let globalQueue = DispatchQueue.global()
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
        
        // 同时执行一个相同的闭包
//        globalQueue.sync {
//            DispatchQueue.concurrentPerform(iterations: 5) {
//                print("\($0) times")
//            }
//        }
        
        // 手动激活队列任务
        // 注意：setTarget(queue:) 方法可以用来配置非活跃队列的优先级（使用它来设置活跃队列将导致崩溃），调用此方法，把队列的优先级设置为作为参数传入队列的优先级。
//        let inactiveQueue = DispatchQueue(label: "com.zzb.inactiveQueue", attributes: [.concurrent, .initiallyInactive])
//        inactiveQueue.async {
//            print("inactiveQueue execute")
//        }
//        print("inactiveQueue not start")
//        inactiveQueue.activate()
        
        // 挂起
//        inactiveQueue.suspend()
        // 恢复
//        inactiveQueue.resume()
        
        // 通过 屏障(barrier) 实现所有异步任务完成后再执行一个任务
        // 分发屏障不能作用与串行队列或者任何一种类型的全局并行队列，如果你想使用它，就必须自定义一个全新的并行队列。
        let concurrentQueue2 = DispatchQueue(label: "com.zzb.concurrent", attributes: .concurrent)
        concurrentQueue2.async {
            DispatchQueue.concurrentPerform(iterations: 5) { (id: Int) in
                sleep(1)
                print("concurrentQueue2 execute 5 times, current id = \(id)")
            }
        }
        
        concurrentQueue2.async(flags: .barrier) {
            print("All 5 concurrent tasks completed")
        }
    }
    
}
