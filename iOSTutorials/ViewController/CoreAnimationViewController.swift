//
//  CoreAnimationViewController.swift
//  iOSTutorials
//
//  Created by CaryZheng on 2018/4/13.
//  Copyright © 2018年 CaryZheng. All rights reserved.
//

import UIKit

class MyView: UIView {
    
    override func draw(_ rect: CGRect) {
        let path = UIBezierPath()
        path.addArc(withCenter: CGPoint(x: 150.0, y: 150.0), radius: 50.0, startAngle: 0, endAngle: CGFloat(Double.pi * 2.0), clockwise: true)
        path.lineWidth = 5
        UIColor.blue.setStroke()
        UIColor.red.setFill()
        path.stroke()
        path.fill()
    }
    
}

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
        testMove()
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
    
    // 自定义View
    private func testCustomView() {
        let view = MyView(frame: CGRect(x: 20, y: 100, width: 300, height: 300))
        self.view.addSubview(view)
    }
    
    private func testKeyFrameAnimation() {
        let view = UIView(frame: CGRect(x: 20, y: 100, width: 100, height: 100))
        view.backgroundColor = UIColor.red
        self.view.addSubview(view)
        
        let keyFrameAnimate = CAKeyframeAnimation(keyPath: "position")
        
        let path = UIBezierPath()
        
        // center: 中心点
        // radius: 半径
        // startAngle: 起始角度
        // endAngle: 终止角度
        // clockwise: 是否顺时针方向
        path.addArc(withCenter: CGPoint(x: 200, y: 200), radius: 100, startAngle: 0, endAngle: CGFloat(Double.pi*2.0), clockwise: true)
        
        keyFrameAnimate.path = path.cgPath
        keyFrameAnimate.duration = 3
        
        keyFrameAnimate.beginTime = CACurrentMediaTime() + 3    // 动画延迟3秒执行
        
        // fillMode: 决定非active时间段的行为
        // kCAFillModeForwards: 动画开始后Layer才进入动画开始位置，动画结束后保持动画最后的状态
        // kCAFillModeBackwards: 动画开始前Layer已经进入动画开始位置，动画结束后恢复到之前的状态
        // kCAFillModeRemoved: 动画开始后Layer才进入动画开始位置，动画结束后Layer恢复到之前的状态
        // kCAFillModeBoth: 动画开始前Layer已经进入动画开始位置，动画结束后保持动画最后的状态
        keyFrameAnimate.fillMode = kCAFillModeForwards
        keyFrameAnimate.delegate = self
        keyFrameAnimate.isRemovedOnCompletion = false
        keyFrameAnimate.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        
        view.layer.add(keyFrameAnimate, forKey: "zzb")
    }
    
    // 3D旋转
    private func testTransform3DRotate() {
        let view = UIView(frame: CGRect(x: 20, y: 100, width: 100, height: 100))
        view.backgroundColor = UIColor.red
        self.view.addSubview(view)
        
        let animate = CABasicAnimation(keyPath: "transform")
        animate.toValue = NSValue(caTransform3D: CATransform3DMakeRotation(CGFloat(Double.pi), 0, 1, 0))
        animate.duration = 3
        animate.isRemovedOnCompletion = false
        animate.fillMode = kCAFillModeForwards
        
        view.layer.add(animate, forKey: "zzb")
    }
    
    // 放大
    private func testScale() {
        let view = UIView(frame: CGRect(x: 200, y: 200, width: 100, height: 100))
        view.backgroundColor = UIColor.red
        self.view.addSubview(view)
        
        let animate = CABasicAnimation(keyPath: "bounds")
        animate.toValue = NSValue(cgRect: CGRect(x: 0, y: 0, width: 120, height: 120))
        animate.duration = 3
        animate.isRemovedOnCompletion = false
        animate.fillMode = kCAFillModeForwards
        
        view.layer.add(animate, forKey: "zzb")
    }
    
    // 平移
    private func testMove() {
        let view = UIView(frame: CGRect(x: 200, y: 200, width: 100, height: 100))
        view.backgroundColor = UIColor.red
        self.view.addSubview(view)
        
        let animate = CABasicAnimation(keyPath: "position")
        animate.fromValue = NSValue(cgPoint: CGPoint(x: 100, y: 300))
        animate.toValue = NSValue(cgPoint: CGPoint(x: 200, y: 200))
        animate.duration = 3
        animate.isRemovedOnCompletion = false
        animate.fillMode = kCAFillModeForwards
        
        view.layer.add(animate, forKey: "zzb")
    }
    
}

extension CoreAnimationViewController: CAAnimationDelegate {
    
    func animationDidStart(_ anim: CAAnimation) {
        print("CoreAnimationViewController animationDidStart")
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        print("CoreAnimationViewController animationDidStop")
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
