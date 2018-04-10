//
//  SocketViewController.swift
//  iOSTutorials
//
//  Created by CaryZheng on 2018/4/10.
//  Copyright © 2018年 CaryZheng. All rights reserved.
//

import Foundation
import SocketIO

class SocketViewController: ZViewController {
    
    private var mSocketManager: SocketManager!
    private var mSocket: SocketIOClient!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let manager = SocketManager(socketURL: URL(string: "http://localhost:8080")!)
        let socket = manager.defaultSocket
        
        mSocketManager = manager
        mSocket = socket
        
        /// 连接上的回调
        mSocket.on(clientEvent: .connect) { data, ack in
            print("socket connected, data = \(data)")
        }
        
        /// 连接断开的回调
        mSocket.on(clientEvent: .disconnect) { data, ack in
            print("socket disconnect, data = \(data)")
        }
        
        /// 错误回调
        mSocket.on(clientEvent: .error) { data, ack in
            print("socket error, data = \(data)")
        }
        
        /// 状态变化回调
        mSocket.on(clientEvent: .statusChange) { data, ack in
            print("socket statusChange, data = \(data)")
        }
        
        /// 接收message消息
        mSocket.on("message") { data, ack in
            print("socket message, data = \(data)")
        }
        
        // 连接
        mSocket.connect()
    }
    
    private func sendMessage() {
        // 发送message消息
        mSocket.emit("message", "test by Cary")
    }
}
