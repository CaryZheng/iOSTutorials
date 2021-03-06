//
//  HomeViewController.swift
//  iOSTutorials
//
//  Created by CaryZheng on 2018/2/24.
//  Copyright © 2018年 CaryZheng. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    private var mTableView: UITableView!
    
    private var mDatas = [
        "Thread",
        "Queue",
        "Singleton",
        "数据存储",
        "Codable",
        "Pointer",
        "WebSocket",
        "Socket",
        "UIView Animation",
        "Core Animation",
        "Swizzle",
        "Authentication",
        "CoreML",
        "Video"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        tableView.delegate = self
        tableView.dataSource = self
        
        self.view.addSubview(tableView)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mDatas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        cell?.textLabel?.text = mDatas[indexPath.row]
        
        return cell!
    }
    
}

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var vc: UIViewController? = nil
        
        switch indexPath.row {
        case 0:
            vc = ThreadViewController()
        case 1:
            vc = QueueViewController()
        case 2:
            vc = SingletonViewController()
        case 3:
            vc = DataSaveViewController()
        case 4:
            vc = CodableViewController()
        case 5:
            vc = PointerViewController()
        case 6:
            vc = WebSocketViewController()
        case 7:
            vc = SocketViewController()
        case 8:
            vc = UIViewAnimationViewController()
        case 9:
            vc = CoreAnimationViewController()
        case 10:
            vc = SwizzleViewController()
        case 11:
            vc = AuthenticationViewController()
        case 12:
            vc = CoreMLViewController()
        case 13:
            vc = VideoViewController()
        default:
            break
        }
        
        if nil != vc {
            self.navigationController?.pushViewController(vc!, animated: true)
        }
    }
    
}
