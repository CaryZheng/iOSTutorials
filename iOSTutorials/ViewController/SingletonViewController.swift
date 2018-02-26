//
//  SingletonViewController.swift
//  iOSTutorials
//
//  Created by CaryZheng on 2018/2/26.
//  Copyright © 2018年 CaryZheng. All rights reserved.
//

import Foundation

class SingletonViewController: ZViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MySingleton.sharedInstance.printLog()
    }
    
}
