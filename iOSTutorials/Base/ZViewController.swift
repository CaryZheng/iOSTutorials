//
//  ZViewController.swift
//  iOSTutorials
//
//  Created by CaryZheng on 2018/2/24.
//  Copyright © 2018年 CaryZheng. All rights reserved.
//

import UIKit

class ZViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = String(describing: type(of: self))
        self.view.backgroundColor = UIColor.white
    }
    
}
