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

enum Gender: Int, Codable {
    case male = 1
    case female
}

class Location: Codable {
    var lat: Double = 0.0
    var lon: Double = 0.0
}

struct AdvancedUser: Codable {
    var name: String
    var age: Int
    var gender: Gender
    var location: Location
}

class CodableViewController: ZViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testJsonStrToJsonObj()
        testJsonObjToJsonStr()
        
        test2JsonStrToJsonObj()
        test2JsonObjToJsonStr()
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
    
    private func test2JsonStrToJsonObj() {
        let jsonStr = """
        {
            "name": "zzb",
            "age": 18,
            "gender": 2,
            "location": {
                "lat": 99.9,
                "lon": 87.5
            }
        }
        """
        
        let jsonData = jsonStr.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        
        do {
            let userObj = try decoder.decode(AdvancedUser.self, from: jsonData)
            print("userObj = \(userObj)")
        } catch {
            print("Decode error")
        }
    }
    
    private func test2JsonObjToJsonStr() {
        let location = Location()
        location.lat = 99.9
        location.lon = 87.5
        let user = AdvancedUser(name: "Cary", age: 19, gender: .male, location: location)
        
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
