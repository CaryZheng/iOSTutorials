//
//  DataSaveViewController.swift
//  iOSTutorials
//
//  Created by CaryZheng on 2018/2/27.
//  Copyright © 2018年 CaryZheng. All rights reserved.
//

import UIKit
import CoreData

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
        
        // CoreData
        testCoreData()
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
    
    private func testCoreData() {
        // save
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        guard let entity = NSEntityDescription.entity(forEntityName: "Users", in: context) else {
            return
        }
        
        let newUser = NSManagedObject(entity: entity, insertInto: context)
        
        newUser.setValue("zzb", forKey: "username")
        newUser.setValue(18, forKey: "age")
        
        do {
            try context.save()
        } catch {
            print("Save data fail")
        }
        
        // get
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        
        do {
            let result = try context.fetch(request)
            for data in result {
                if let data = data as? NSManagedObject {
                    let userName = data.value(forKey: "username") as? String
                    let age = data.value(forKey: "age") as? Int
                    
                    print("userName = \(String(describing: userName)), age = \(String(describing: age))")
                }
            }
        } catch {
            print("Fetch fail")
        }
        
        // remove
        do {
            let result = try context.fetch(request)
            for data in result {
                if let data = data as? NSManagedObject {
                    context.delete(data)
                }
            }
        } catch {
            print("Fetch fail")
        }
        
        // get
        let request2 = NSFetchRequest<NSFetchRequestResult>(entityName: "Users")
        
        do {
            let result = try context.fetch(request2)
            for data in result {
                if let data = data as? NSManagedObject {
                    let userName = data.value(forKey: "username") as? String
                    let age = data.value(forKey: "age") as? Int
                    
                    print("userName = \(String(describing: userName)), age = \(String(describing: age))")
                }
            }
        } catch {
            print("Fetch fail")
        }
    }
    
}
