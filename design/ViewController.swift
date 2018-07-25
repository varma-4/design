//
//  ViewController.swift
//  design
//
//  Created by Mani on 03/11/17.
//  Copyright © 2017 mani. All rights reserved.
//

import UIKit
import CoreMotion

class ViewController: UIViewController {

    @IBOutlet weak var switchFlag: UISwitch!
    @IBOutlet weak var mobiledataView: myView!
    
    @IBAction func method(_ sender: Any) {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        mobiledataView.layer.cornerRadius = 125
        mobiledataView.clipsToBounds = true
        switchFlag.isOn = false
    }

    @IBAction func switchChanged(_ sender: Any) {
        let manager = CMMotionManager()
        
        if switchFlag.isOn {
            
            if manager.isGyroAvailable {
                manager.gyroUpdateInterval = 0.5
                manager.startGyroUpdates()
            }
            let customQuue = OperationQueue()
            
            manager.startGyroUpdates(to: customQuue) { (data, error) in
                // ...
                if manager.isDeviceMotionAvailable {
                    manager.deviceMotionUpdateInterval = 0.10
                    manager.startDeviceMotionUpdates(to: customQuue) {
                        [weak self] (data: CMDeviceMotion?, error: Error?) in
                        if let gravity = data?.gravity {
                            let rotation = atan2(gravity.x, gravity.y) - Double.pi
                            print(rotation)
                            DispatchQueue.main.async {
                                self?.mobiledataView.transform = CGAffineTransform(rotationAngle: CGFloat(rotation))
                            }
                        }
                    }
                }
            }
        } else {
            manager.stopGyroUpdates()
        }
        
        
    }
    
    @IBAction func swipeUp(_ sender: Any) {
        self.mobiledataView.swipeUp(rect: mobiledataView.bounds)
    }
    
    @IBOutlet weak var reset: UIButton!
    @IBAction func resetAnim(_ sender: Any) {
        self.mobiledataView.reset(rect: mobiledataView.bounds)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

}



class myView: UIView {
    
    var shapeLayer = CAShapeLayer()
    var flag = false
    
    func swipeUp(rect: CGRect) {
        print("Swipe Up")
        flag = true
        self.draw(rect)
    }
    
    func reset(rect: CGRect) {
        print("Reset")
        print(flag)
        self.draw(rect)
    }
    
    override func draw(_ rect: CGRect) {
        
        
        // Drawing Circle
        let color = UIColor.init(red: 255/255, green: 189/255, blue: 22/255, alpha: 1)
        
        let center = CGPoint(x: bounds.width / 2, y: bounds.height / 2)
        let radius: CGFloat = max(bounds.width, bounds.height)
        let path = UIBezierPath(arcCenter: center,
                                radius: radius/2,
                                startAngle: 0,
                                endAngle: 360,
                                clockwise: true)
        path.lineWidth = 2
//        color.setFill()
//        path.fill()
        
        let startAngle0: CGFloat = 3 * .pi * 0
        let endAngle0: CGFloat = 3 * .pi / 3
        let centersdf0 = CGPoint(x: rect.width/2, y: 0)
        let pathadsf0 = UIBezierPath(arcCenter: centersdf0, radius: rect.height, startAngle: startAngle0, endAngle: endAngle0, clockwise: true)
        
        // Animate shapeLayer fill
        let shapeLayer0 = CAShapeLayer()
        shapeLayer0.path = pathadsf0.cgPath
        shapeLayer0.lineJoin = kCALineJoinRound
        shapeLayer0.lineCap = kCALineCapRound
        shapeLayer0.lineWidth = 5.0
        shapeLayer0.fillColor = color.cgColor
        shapeLayer0.strokeColor = UIColor.clear.cgColor
        
        
        
        
        
        var animationsGroup = [CABasicAnimation]()
        print(rect.height)
        for i in 0...Int(rect.height/50) {
            let startAngle0: CGFloat = 3 * .pi * 0
            let endAngle0: CGFloat = 3 * .pi / 3
            let centersdf0 = CGPoint(x: rect.width/2, y: 0 + CGFloat(i * 50))
            let pathadsf0 = UIBezierPath(arcCenter: centersdf0, radius: rect.height, startAngle: startAngle0, endAngle: endAngle0, clockwise: true)
            
            let pathAnim = CABasicAnimation(keyPath: "path")
            pathAnim.toValue = pathadsf0.cgPath
            animationsGroup.append(pathAnim)
        }

        
        let group20 = CAAnimationGroup()
        group20.animations = animationsGroup
        group20.duration = 4.5
        group20.autoreverses = false
        group20.repeatCount = 0
        group20.fillMode = kCAFillModeForwards
        group20.isRemovedOnCompletion = false
        shapeLayer0.add(group20, forKey: nil)

        
        //

        // Create new Beizer path for water arc
        let aracPath = UIBezierPath()
        let startPoint = CGPoint(x: 0, y: rect.height/2)
        let endPoint = CGPoint(x: rect.width, y: rect.height/2)
        aracPath.move(to: startPoint)
        // left Curve
        let point1 = CGPoint(x: rect.width/2, y: rect.height/2)
        let point2 = CGPoint(x: rect.width/2, y: rect.height/2 + 30)
        // Right Curve
//        let point1 = CGPoint(x: rect.width/2, y: rect.height/2 + 40)
//        let point2 = CGPoint(x: rect.width/2, y: rect.height/2)

        // Color should be passed on init
        
        color.setStroke()
        aracPath.addCurve(to: endPoint, controlPoint1: point1, controlPoint2: point2)
//        aracPath.stroke()
        print(aracPath.description)
        // remove later
        
        
        // remove up

//        // Find the bottom arc-Area and fill it with color
        let startAngle: CGFloat = 3 * .pi * 0
        let endAngle: CGFloat = 3 * .pi / 3
        let centersdf = CGPoint(x: rect.width/2, y: rect.height/2)
        let pathadsf = UIBezierPath(arcCenter: centersdf, radius: rect.width/2, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        color.setFill()
//        pathadsf.fill()
        print(pathadsf.cgPath.getPathElementsPoints())
        print(aracPath.cgPath.getPathElementsPoints())

//       pathadsf.fill()
//        UIColor.white.setFill()
//        aracPath.fill()
        
        
        
        
        
//        let fillpath2 = aracPath.reversing()
//        UIColor.white.setFill()
//        fillpath2.fill()
//        print(pathadsf.reversing().cgPath.getPathElementsPoints())
//        print(aracPath.reversing().cgPath.getPathElementsPoints())
        

        
        // Animate the circle to different path
        // Create new Beizer path for water arc
//        UIColor.white.setFill()
//        path.fill()
        
        let aracPath1 = UIBezierPath()
        let startPoint1 = CGPoint(x: 0, y: rect.height/2)
        let endPoint1 = CGPoint(x: rect.width, y: rect.height/2)
        aracPath1.move(to: startPoint1)
        //        // left Curve
        //        let point1 = CGPoint(x: rect.width/2, y: rect.height/2)
        //        let point2 = CGPoint(x: rect.width/2, y: rect.height/2 + 40)
        // Right Curve
        let point11 = CGPoint(x: rect.width/2, y: rect.height/2 + 30)
        let point22 = CGPoint(x: rect.width/2, y: rect.height/2)

        // Color should be passed on init
        let color1 = UIColor.init(red: 255/255, green: 189/255, blue: 22/255, alpha: 1)
        color1.setStroke()
        aracPath1.addCurve(to: endPoint1, controlPoint1: point11, controlPoint2: point22)
        //        aracPath.stroke()

        // Find the bottom arc-Area and fill it with color
        let startAngle1: CGFloat = 3 * .pi * 0
        let endAngle1: CGFloat = 3 * .pi / 3
        let centersdf1 = CGPoint(x: rect.width/2, y: rect.height/2)
        let pathadsf1 = UIBezierPath(arcCenter: centersdf1, radius: rect.width/2, startAngle: startAngle1, endAngle: endAngle1, clockwise: true)
//        color1.setFill()
//        pathadsf1.fill()
//        UIColor.white.setFill()
//        aracPath1.fill()
//        aracPath1.stroke()
        print(aracPath1.description)
//
//        shapeLayer.strokeStart = 0
//        shapeLayer.strokeEnd = 1
//
//
//        // Fill arc-top area with circle's color
        
        pathadsf.append(aracPath)
        pathadsf1.append(aracPath1)
        shapeLayer = CAShapeLayer()
        shapeLayer.path = aracPath.cgPath
        shapeLayer.lineJoin = kCALineJoinRound
        shapeLayer.lineCap = kCALineCapRound
        shapeLayer.lineWidth = 5.0
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = color.cgColor
        
        let shapelayer2 = CAShapeLayer()
        shapelayer2.path = pathadsf.cgPath
        shapelayer2.lineJoin = kCALineJoinRound
        shapelayer2.lineCap = kCALineCapRound
        shapelayer2.lineWidth = 5.0
        shapelayer2.fillColor = color.cgColor
        shapelayer2.strokeColor = UIColor.clear.cgColor
        
        
        
        
        
        
        let startAnimation = CABasicAnimation(keyPath: "strokeStart")
//        startAnimation.fromValue = aracPath.cgPath
//        startAnimation.toValue = aracPath.reversing().cgPath
        startAnimation.toValue = 1.0
        
        let endAnimation = CABasicAnimation(keyPath: "strokeEnd")
//        startAnimation.fromValue = aracPath.cgPath
//        endAnimation.toValue = UIColor.orange.cgColor
            endAnimation.toValue = 1.0
        
        let pathAnimation2 = CABasicAnimation(keyPath: "path")
        pathAnimation2.toValue = aracPath1.cgPath
        
        
        let pathAnimation3 = CABasicAnimation(keyPath: "path")
        pathAnimation3.toValue = pathadsf1.cgPath
        
        
        
        let group = CAAnimationGroup()
        group.animations = [pathAnimation2]
        group.duration = 1.5
        group.autoreverses = true
        group.repeatCount = HUGE
        group.isRemovedOnCompletion = false
        shapeLayer.add(group, forKey: nil)
        
        let group1 = CAAnimationGroup()
        group1.animations = [pathAnimation3]
        group1.duration = 1.5
        group1.autoreverses = true
        group1.repeatCount = HUGE
        group1.isRemovedOnCompletion = false
        shapelayer2.add(group1, forKey: nil)
        
        
        
        
        
        
        
        //        // Double Layer
        let aracPath11 = UIBezierPath()
        let startPoint11 = CGPoint(x: 0, y: rect.height/2 - 7)
        let endPoint11 = CGPoint(x: rect.width, y: rect.height/2 - 7)
        
        let point111 = CGPoint(x: rect.width/2 , y: rect.height/2)
        let point222 = CGPoint(x: rect.width/2, y: rect.height/2)
        aracPath11.move(to: startPoint11)
        aracPath11.addCurve(to: endPoint11, controlPoint1: point111, controlPoint2: point222)
        UIColor.orange.setStroke()
        
        // sro
        let aracPath111 = UIBezierPath()
        let point1111 = CGPoint(x: rect.width/2 , y: rect.height/2)
        let point2222 = CGPoint(x: rect.width/2, y: rect.height/2 + 20)
        aracPath111.move(to: startPoint11)
        aracPath111.addCurve(to: endPoint11, controlPoint1: point1111, controlPoint2: point2222)
        UIColor.orange.setStroke()
        let color11 =  UIColor.init(red: 251/255, green: 226/255, blue: 164/255, alpha: 1)
        
        
        let shapelayer3 = CAShapeLayer()
        shapelayer3.path = aracPath111.cgPath
        shapelayer3.lineJoin = kCALineJoinRound
        shapelayer3.lineCap = kCALineCapRound
        shapelayer3.lineWidth = 5.0
        shapelayer3.fillColor = UIColor.clear.cgColor
        shapelayer3.strokeColor = color1.cgColor
        
        let pathAnimation4 = CABasicAnimation(keyPath: "path")
        pathAnimation4.toValue = aracPath11.cgPath
        
        
        let group2 = CAAnimationGroup()
        group2.animations = [pathAnimation4]
        group2.duration = 1.5
        group2.autoreverses = true
        group2.repeatCount = HUGE
        group2.isRemovedOnCompletion = false
        shapelayer3.add(group2, forKey: nil)
        
        let startAngle11: CGFloat = 3 * .pi * 0
        let endAngle11: CGFloat = 3 * .pi / 3
        let centersdf11 = CGPoint(x: rect.width/2, y: rect.height/2 - 7 )
        let pathadsf11 = UIBezierPath(arcCenter: centersdf11, radius: rect.height/2 + 7, startAngle: startAngle11, endAngle: endAngle11, clockwise: true)
        
//        let startAngle112: CGFloat = 3 * .pi * 0
//        let endAngle112: CGFloat = 3 * .pi / 3
        let pathadsf112 = UIBezierPath(arcCenter: centersdf11, radius: rect.height/2 + 7, startAngle: startAngle11, endAngle: endAngle11, clockwise: true)
        
        
        pathadsf11.append(aracPath11)
        pathadsf112.append(aracPath111)
        
        print("\n \n ++++++++++++")
        print(pathadsf11.cgPath.getPathElementsPoints())
        print(pathadsf112.cgPath.getPathElementsPoints())
        print("\n \n ++++++++++++")
        
        let shapelayer22 = CAShapeLayer()
        shapelayer22.path = pathadsf11.cgPath
        shapelayer22.lineJoin = kCALineJoinRound
        shapelayer22.lineCap = kCALineCapRound
        shapelayer22.lineWidth = 5.0
        shapelayer22.fillColor = color11.cgColor
        shapelayer22.strokeColor = UIColor.clear.cgColor
        
        let pathAnimation33 = CABasicAnimation(keyPath: "path")
        pathAnimation33.toValue = pathadsf112.cgPath
        
        let group21 = CAAnimationGroup()
        group21.animations = [pathAnimation33]
        group21.duration = 1.5
        group21.autoreverses = true
        group21.repeatCount = HUGE
        group21.isRemovedOnCompletion = false
        shapelayer22.add(group21, forKey: nil)
        
        self.layer.addSublayer(shapelayer22)
        self.layer.addSublayer(shapelayer2)
        //Animation drag from top
        self.layer.addSublayer(shapeLayer0)
       
        print("Value of flag is \(flag)")
        if flag {
            let aracPath = UIBezierPath()
            let startPoint = CGPoint(x: 0, y: rect.height/2 + 30)
            let endPoint = CGPoint(x: rect.width, y: rect.height/2 + 30)
            aracPath.move(to: startPoint)
            let point1 = CGPoint(x: rect.width/2, y: rect.height/2 + 30)
            let point2 = CGPoint(x: rect.width/2, y: rect.height/2 + 60)
            
            aracPath.addCurve(to: endPoint, controlPoint1: point1, controlPoint2: point2)
            
            let  dashes: [ CGFloat ] = [ 0.0, 10.0 ]
            
            let shapeLayer0 = CAShapeLayer()
            shapeLayer0.path = aracPath.cgPath
            shapeLayer0.lineDashPhase = 1.0
            shapeLayer0.lineDashPattern = dashes as [NSNumber]
//            shapeLayer0.lineJoin = kCALineJoinMiter
            shapeLayer0.lineCap = kCALineCapRound
            shapeLayer0.lineWidth = 2.5
            shapeLayer0.fillColor = UIColor.clear.cgColor
            shapeLayer0.strokeColor = UIColor.white.cgColor
            self.layer.addSublayer(shapeLayer0)
            flag = false
        }
        
//        self.layer.addSublayer(shapelayer3)
//        self.layer.addSublayer(shapeLayer)
        
        
        
    }
    
    
    
}

extension CGPath {
    
    func forEach( body: @convention(block) (CGPathElement) -> Void) {
        typealias Body = @convention(block) (CGPathElement) -> Void
        let callback: @convention(c) (UnsafeMutableRawPointer, UnsafePointer<CGPathElement>) -> Void = { (info, element) in
            let body = unsafeBitCast(info, to: Body.self)
            body(element.pointee)
        }
        print(MemoryLayout.size(ofValue: body))
        let unsafeBody = unsafeBitCast(body, to: UnsafeMutableRawPointer.self)
        self.apply(info: unsafeBody, function: unsafeBitCast(callback, to: CGPathApplierFunction.self))
    }
    
    
    func getPathElementsPoints() -> [CGPoint] {
        var arrayPoints : [CGPoint]! = [CGPoint]()
        self.forEach { element in
            switch (element.type) {
            case CGPathElementType.moveToPoint:
                arrayPoints.append(element.points[0])
            case .addLineToPoint:
                arrayPoints.append(element.points[0])
            case .addQuadCurveToPoint:
                arrayPoints.append(element.points[0])
                arrayPoints.append(element.points[1])
            case .addCurveToPoint:
                arrayPoints.append(element.points[0])
                arrayPoints.append(element.points[1])
                arrayPoints.append(element.points[2])
            default: break
            }
        }
        return arrayPoints
    }
    
    func getPathElementsPointsAndTypes() -> ([CGPoint],[CGPathElementType]) {
        var arrayPoints : [CGPoint]! = [CGPoint]()
        var arrayTypes : [CGPathElementType]! = [CGPathElementType]()
        self.forEach { element in
            switch (element.type) {
            case CGPathElementType.moveToPoint:
                arrayPoints.append(element.points[0])
                arrayTypes.append(element.type)
            case .addLineToPoint:
                arrayPoints.append(element.points[0])
                arrayTypes.append(element.type)
            case .addQuadCurveToPoint:
                arrayPoints.append(element.points[0])
                arrayPoints.append(element.points[1])
                arrayTypes.append(element.type)
                arrayTypes.append(element.type)
            case .addCurveToPoint:
                arrayPoints.append(element.points[0])
                arrayPoints.append(element.points[1])
                arrayPoints.append(element.points[2])
                arrayTypes.append(element.type)
                arrayTypes.append(element.type)
                arrayTypes.append(element.type)
            default: break
            }
        }
        return (arrayPoints,arrayTypes)
    }
}
