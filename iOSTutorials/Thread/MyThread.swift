//
//  MyThread.swift
//  iOSTutorials
//
//  Created by CaryZheng on 2018/2/24.
//  Copyright © 2018年 CaryZheng. All rights reserved.
//

import Foundation

class MyThread: Thread {
    
    override func main() {
        print("MyThread main 1")
        Thread.sleep(forTimeInterval: 2)
        print("MyThread main 2")
    }
    
}
