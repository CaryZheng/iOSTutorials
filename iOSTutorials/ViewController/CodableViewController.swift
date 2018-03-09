//
//  CodableViewController.swift
//  iOSTutorials
//
//  Created by CaryZheng on 2018/3/8.
//  Copyright © 2018年 CaryZheng. All rights reserved.
//

import UIKit

struct User: Codable {
    var name: String
    var age: Int
}

class CodableViewController: ZViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testJsonStrToJsonObj()
        
        testJsonObjToJsonStr()
    }
    
    private func testJsonStrToJsonObj() {
        let jsonStr = """
        {
            "name": "zzb",
            "age": 18
        }
        """
        
        let jsonData = jsonStr.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        
        do {
            let userObj = try decoder.decode(User.self, from: jsonData)
            print("userObj = \(userObj)")
        } catch {
            print("Decode error")
        }
    }
    
    private func testJsonObjToJsonStr() {
        let user = User(name: "Cary", age: 20)
        
        let encoder = JSONEncoder()
        do {
            let data = try encoder.encode(user)
            let dataStr = String(data: data, encoding: .utf8)
            print("dataStr = \(String(describing: dataStr))")
        } catch {
            print("Encode error")
        }
    }
    
}
