//
//  WebSocketViewController.swift
//  iOSTutorials
//
//  Created by CaryZheng on 2018/4/10.
//  Copyright © 2018年 CaryZheng. All rights reserved.
//

import Foundation
import Starscream

class WebSocketViewController: ZViewController {
    
    private var mWebSocket: WebSocket!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mWebSocket = WebSocket(url: URL(string: "ws://localhost:8080/")!)
        mWebSocket.delegate = self
        mWebSocket.connect()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if mWebSocket.isConnected {
            mWebSocket.disconnect()
        }
    }
    
}

extension WebSocketViewController: WebSocketDelegate {
    
    func websocketDidConnect(socket: WebSocketClient) {
        print("websocketDidConnect")
    }
    
    func websocketDidDisconnect(socket: WebSocketClient, error: Error?) {
        print("websocketDidDisconnect, error = \(String(describing: error))")
    }
    
    func websocketDidReceiveMessage(socket: WebSocketClient, text: String) {
        print("websocketDidReceiveMessage, text = \(text)")
        
        if text.contains("Hello Client") {
            mWebSocket.write(string: "Send msg from iOS Client by Cary")
        }
    }
    
    func websocketDidReceiveData(socket: WebSocketClient, data: Data) {
        print("websocketDidReceiveData")
    }
}
