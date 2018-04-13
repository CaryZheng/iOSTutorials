//
//  CoreAnimationViewController.swift
//  iOSTutorials
//
//  Created by CaryZheng on 2018/4/13.
//  Copyright © 2018年 CaryZheng. All rights reserved.
//

import UIKit

class CoreAnimationViewController: ZViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // test button
        let button = UIButton(type: .system)
        button.setTitle("测试", for: .normal)
        button.frame = CGRect(x: 10, y: UIScreen.main.bounds.height - 100, width: 100, height: 40)
        button.backgroundColor = UIColor.gray
        button.setTitleColor(.white, for: .normal)
        
        button.addTarget(self, action: #selector(onButtonClicked), for: .touchUpInside)
        
        self.view.addSubview(button)
    }
    
    @objc private func onButtonClicked() {
        testCustomLayer()
    }
    
    // layer简单用法
    private func testLayerSimple() {
        let view = UIView(frame: CGRect(x: 20, y: 100, width: 100, height: 100))
        
        self.view.addSubview(view)
        
        view.backgroundColor = UIColor.red
        
        // 圆角
        view.layer.cornerRadius = view.frame.width / 2.0
        
        // 边框
        view.layer.borderWidth = 5  // 边框宽度
        view.layer.borderColor = UIColor.blue.cgColor   // 边框颜色
        
        // 阴影
        view.layer.shadowOpacity = 0.5  // 阴影透明度
        view.layer.shadowOffset = CGSize(width: 0, height: 2.0) // 阴影偏移量
        view.layer.shadowRadius = 5.0   // 阴影模糊半径
        
        // 阴影path
        let path = CGMutablePath()
        path.addRect(view.bounds)
        
        view.layer.shadowPath = path
    }
    
    // Draw image
    private func testDrawImageWithLayer() {
        let image = UIImage(named: "pic_flashlight")
        
        let view = UIView(frame: CGRect(x: 20, y: 100, width: 100, height: 100))
        self.view.addSubview(view)
        
        view.layer.contents = image?.cgImage
        view.layer.contentsGravity = kCAGravityResizeAspect
        view.layer.masksToBounds = true
    }
    
    // 自定义layer
    private func testCustomLayer() {
        let view = UIView(frame: CGRect(x: 20, y: 100, width: 100, height: 100))
        self.view.addSubview(view)
        
        let layer = CALayer()
        layer.frame = CGRect(x: 50.0, y: 50.0, width: 100.0, height: 100.0)
        layer.backgroundColor = UIColor.red.cgColor
        layer.delegate = self
        
        layer.display()
        
        view.layer.addSublayer(layer)
    }
    
}

extension CoreAnimationViewController: CALayerDelegate {
    
    func draw(_ layer: CALayer, in ctx: CGContext) {
        ctx.setLineWidth(1)
        ctx.setStrokeColor(UIColor.blue.cgColor)
        ctx.addEllipse(in: layer.bounds.insetBy(dx: 1, dy: 1))
        ctx.strokePath()
    }
}
