//
//  UIViewAnimationViewController.swift
//  iOSTutorials
//
//  Created by CaryZheng on 2018/4/11.
//  Copyright © 2018年 CaryZheng. All rights reserved.
//

import UIKit

class UIViewAnimationViewController: ZViewController {
    
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
        testUIViewAnimation1()
    }
    
    // UIView animate简单用法
    private func testUIViewAnimation1() {
        let view = UIView(frame: CGRect(x: 20, y: 100, width: 100, height: 100))
        
        self.view.addSubview(view)
        
        // 初始颜色为红色
        view.backgroundColor = UIColor.red
        
        // 初始透明度为 0
        view.alpha = 0
        
        // withDuration: 动画持续时间
        UIView.animate(withDuration: 1.0) {
            // 最终颜色为黄色
            view.backgroundColor = UIColor.yellow
            
            // 最终透明度为 1.0
            view.alpha = 1.0
        }
    }
    
    // UIView animate简单用法2
    private func testUIViewAnimation2() {
        let view = UIView(frame: CGRect(x: 20, y: 100, width: 100, height: 100))
        view.backgroundColor = UIColor.red
        
        self.view.addSubview(view)
        
        // curveEaseIn: slow at beginning
        // curveEaseInOut: slow at beginning and end
        // curveEaseOut: slow at end
        // curveLinear: 线性
        let animateOptions = UIViewAnimationOptions.curveEaseIn
        UIView.animate(withDuration: 2.0, delay: 0, options: animateOptions, animations: {
//            UIView.setAnimationRepeatCount(5) // 设置动画重复次数
            view.backgroundColor = UIColor.yellow
            view.center.x += 100
        }, completion: nil)
    }
    
    // UIView animate 震荡动画用法
    private func testSpringAnimation() {
        let view = UIView(frame: CGRect(x: 20, y: 100, width: 100, height: 100))
        view.backgroundColor = UIColor.red
        
        self.view.addSubview(view)
        
        // usingSpringWithDamping: 震荡系数，越小代表越震荡
        // initialSpringVelocity: 初始速度，越大代表初始速度越快
        UIView.animate(withDuration: 2.0, delay: 0, usingSpringWithDamping: 0.6, initialSpringVelocity: 1.0, options: [], animations: {
            view.center.x += 200
        }, completion: { _ in
            print("Spring animation complete")
        })
    }
    
    // 关键帧动画用法
    private func testKeyframe() {
        let view = UIView(frame: CGRect(x: 20, y: 100, width: 100, height: 100))
        view.backgroundColor = UIColor.red
        
        self.view.addSubview(view)
        
        UIView.animateKeyframes(withDuration: 4.0, delay: 0, options: [], animations: {
            // withRelativeStartTime: 开始时间（相对于总动画时间）
            // relativeDuration: 动画执行时间（相对于总动画时间）
            UIView.addKeyframe(withRelativeStartTime: 0, relativeDuration: 1.0/4.0, animations: {
                view.center.x += 100
            })
            
            UIView.addKeyframe(withRelativeStartTime: 1.0/4.0, relativeDuration: 1.2/4.0, animations: {
                view.backgroundColor = UIColor.yellow
            })
            
            UIView.addKeyframe(withRelativeStartTime: 2.2/4.0, relativeDuration: 1.0, animations: {
                view.center.y += 150
            })
            
        }, completion: { _ in
            print("Key animation complete")
        })
    }
    
}
