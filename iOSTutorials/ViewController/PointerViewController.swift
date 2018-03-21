//
//  PointerViewController.swift
//  iOSTutorials
//
//  Created by CaryZheng on 2018/3/21.
//  Copyright © 2018年 CaryZheng. All rights reserved.
//

import Foundation

class TestUser {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        print("TestUser init")
        self.name = name
        self.age = age
    }
    
    deinit {
        print("TestUser deinit")
    }
}

class PointerViewController: ZViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 带Mutable表示内存中的数据可变，反之表示内存中的数据不可变
        // 带Raw表示指针指向的内存未分配具体的数据类型，反之指针指向的内存已分配具体的数据类型
        // 带Buffer表述用来处理Swift数组和指针
        // UnsafeMutablePointer
        // UnsafePointer
        // UnsafeRawPointer
        // UnsafeRawBufferPointer
        // UnsafeBufferPointer
        // UnsafeMutableBufferPointer
        
        // 指向Int整数类型的指针
        var a = 98
        print("1: a = \(a)")
        printValueInt(ptr: &a)
        increaseValue(ptr: &a)
        convertRawPointer(ptr: &a)
        print("2: a = \(a)")
        
        // 指向数组(Int)的指针
        print("")
        var testArrayInt = [10, 20, 30]
        handleArrayInt(ptr: &testArrayInt)
        print("testArrayInt = \(testArrayInt)")

        // 指向数组(String)的指针
        print("")
        var testArrayStr = ["a", "y", "f"]
        handleArrayStr(ptr: &testArrayStr)
        print("testArrayStr = \(testArrayStr)")

        // 自定义class类型指针
        print("")
        var userPtr: UnsafeMutablePointer<TestUser>!
        userPtr = UnsafeMutablePointer<TestUser>.allocate(capacity: 1)
        print("allocate userPtr = \(userPtr)")
        userPtr.initialize(to: TestUser(name: "Cary1", age: 18))
        print("initialize userPtr = \(userPtr), value name = \(userPtr.pointee.name), age = \(userPtr.pointee.age)")
        userPtr.deinitialize()
        print("deinitialize userPtr = \(userPtr)")
        userPtr.deallocate(capacity: 1)
        userPtr = nil
        print("deallocate userPtr = \(userPtr)")
    }
    
    func handleArrayStr(ptr: UnsafeMutablePointer<String>) {
        print("1: increaseValue2 ptr[1] = \(ptr[1])")
        ptr.advanced(by: 1).pointee = "CaryP"
        print("2: increaseValue2 ptr[1] = \(ptr[1])")
    }
    
    func handleArrayInt(ptr: UnsafeMutablePointer<Int>) {
        print("1: handleArrayInt ptr[1] = \(ptr[1])")
        ptr.advanced(by: 1).pointee = 99
        print("2: handleArrayInt ptr[1] = \(ptr[1])")
        
        let buffer = UnsafeBufferPointer(start: ptr, count: 3)
        // 转化为Buffer类型，进而遍历数组
        buffer.forEach {
            print("handleArrayInt print array element = \($0)")
        }
    }
    
    func increaseValue(ptr: UnsafeMutablePointer<Int>) {
        ptr.pointee += 1    // mutable类型: 可修改对应的value
    }
    
    func printValueInt(ptr: UnsafePointer<Int>) {
        print("ptr value = \(ptr.pointee)")   // 非mutable类型: 只读，不可修改
    }
    
    func convertRawPointer(ptr: UnsafePointer<Int>) {
        let rawPtr = UnsafeRawPointer(ptr)  // UnsafePointer 转 UnsafeRawPointer
        print("convertRawPointer rawPtr = \(rawPtr)")
        let ptrInt = rawPtr.assumingMemoryBound(to: Int.self) // UnsafeRawPointer 转 UnsafePointer
        print("convertRawPointer ptrInt = \(ptrInt), value = \(ptrInt.pointee)")
    }
    
}
