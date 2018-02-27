//
//  DataSaveViewController.swift
//  iOSTutorials
//
//  Created by CaryZheng on 2018/2/27.
//  Copyright © 2018年 CaryZheng. All rights reserved.
//

import UIKit

class MyData: NSObject, NSCoding {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.name = (aDecoder.decodeObject(forKey: "name") as? String) ?? ""
        self.age = aDecoder.decodeInteger(forKey: "age")
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: "name")
        aCoder.encode(age, forKey: "age")
    }
}

class DataSaveViewController: ZViewController {
    
    var filePath: String {
        let manager = FileManager.default
        let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first! as URL
        return url.appendingPathComponent("objects").path
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // UserDefaults
        testUserDefaults()
        
        // archive
        testArchive()
    }
    
    private func testUserDefaults() {
        // save data
        UserDefaults.standard.set("mytest", forKey: "keyString")
        UserDefaults.standard.set(98, forKey: "keyInt")
        UserDefaults.standard.set(10.5, forKey: "keyDouble")
        UserDefaults.standard.set(true, forKey: "keyBool")
        
        // get data
        let valueString = UserDefaults.standard.string(forKey: "keyString")
        let valueInt = UserDefaults.standard.integer(forKey: "keyInt")
        let valueDouble = UserDefaults.standard.double(forKey: "keyDouble")
        let valueBool = UserDefaults.standard.bool(forKey: "keyBool")
        
        print("After save: valueString = \(String(describing: valueString)), valueInt = \(valueInt), valueDouble = \(valueDouble), valueBool = \(valueBool)")
        
        // remove data
        UserDefaults.standard.removeObject(forKey: "keyString")
        UserDefaults.standard.removeObject(forKey: "keyInt")
        UserDefaults.standard.removeObject(forKey: "keyDouble")
        UserDefaults.standard.removeObject(forKey: "keyBool")
        
        // get data
        let valueString2 = UserDefaults.standard.string(forKey: "keyString")
        let valueInt2 = UserDefaults.standard.integer(forKey: "keyInt")
        let valueDouble2 = UserDefaults.standard.double(forKey: "keyDouble")
        let valueBool2 = UserDefaults.standard.bool(forKey: "keyBool")
        
        print("After remove: valueString = \(String(describing: valueString2)), valueInt = \(valueInt2), valueDouble = \(valueDouble2), valueBool = \(valueBool2)")
    }
    
    private func testArchive() {
        // save
        let myData = MyData(name: "Sheldon", age: 18)
        
        let testFilePath = filePath
        NSKeyedArchiver.archiveRootObject(myData, toFile: testFilePath)
        
        // get
        let value2 = NSKeyedUnarchiver.unarchiveObject(withFile: testFilePath) as? MyData
        print("value2 = \(value2!.name, value2!.age)")
        
        // remove
        if FileManager.default.fileExists(atPath: testFilePath) {
            do {
                try FileManager.default.removeItem(atPath: testFilePath)
            } catch {
                print("error")
            }
            
            let value22 = NSKeyedUnarchiver.unarchiveObject(withFile: testFilePath)
            print("value22 = \(String(describing: value22))")
        }
    }
    
}
