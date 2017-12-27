//
//  RotaMapView.swift
//  OpenGLStudy
//
//  Created by KKING on 2017/12/19.
//  Copyright © 2017年 KKING. All rights reserved.
//

import UIKit

class DemoRotaMapView: UIView {
    
    var dataArr = Array<JSON>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(hexString: "#ebecf1")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        let width = Int(bounds.width)
        let height = Int(bounds.height)
        
        for i in 0..<height {
            for j in 0..<width {
                if dataArr[i*width + j].intValue > 0 {//&& dataArr[i*width + j].intValue <= 70 
                    CGContext.addRect(context!)(CGRect(x: j, y: height - i, width: 1, height: 1))
                }
            }
        }
        context!.setStrokeColor(UIColor(hexString: "#10d5a1").withAlphaComponent(0.4).cgColor)
        CGContext.strokePath(context!)()
    }
}


class DemoRotaHinderView: UIView {
    
    var dataArr = Array<JSON>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        
        let width = Int(bounds.width)
        let height = Int(bounds.height)
        
        for i in 0..<height {
            for j in 0..<width {
                if dataArr[i*width + j].intValue > 70 {
                    CGContext.addRect(context!)(CGRect(x: j, y: height - i, width: 1, height: 1))
                }
            }
        }
        context!.setStrokeColor(UIColor(hexString: "#60dbb5").cgColor)
        CGContext.strokePath(context!)()
    }
}



class DemoRotaTraceView: UIView {
    
    var dataArr = Array<JSON>()
    
    var positionX: CGFloat = 0
    var positionY: CGFloat = 0
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        if dataArr.count == 0 {
            return
        }
        let context = UIGraphicsGetCurrentContext()
        let bezier = UIBezierPath()
        
        
        let startx = -positionX
        let starty = positionY
        
        print("startx = \(startx) \n starty = \(starty)")
        
        bezier.move(to: CGPoint(x: startx, y: starty))
        
        print(CGPoint(x: startx, y: starty))
        
        for i in 0..<dataArr.count-1 {
            if i != 0 {
                bezier.addLine(to: CGPoint(x: CGFloat(Int64(startx + 20*CGFloat(dataArr[i]["X"].floatValue))), y: CGFloat(Int64(starty - 20*CGFloat(dataArr[i]["Y"].floatValue)))))
                
                print(CGPoint(x: startx + 20*CGFloat(dataArr[i]["X"].floatValue), y: starty - 20*CGFloat(dataArr[i]["Y"].floatValue)))
            }
        }

        // 绘制曲线
//        print("\(firstPoint)\(secondPoint)")
//
//        bezier.move(to: firstPoint)
//        bezier.addCurve(to: secondPoint, controlPoint1: CGPoint(x: (secondPoint.x-firstPoint.x)/2+firstPoint.x, y: firstPoint.y), controlPoint2: CGPoint(x: (secondPoint.x-firstPoint.x)/2+firstPoint.x, y: secondPoint.y))
        
        
        UIColor(hexString: "#66c5fo").setStroke()
        CGContext.setLineWidth(context!)(1)
        CGContext.addPath(context!)(bezier.cgPath)
        CGContext.drawPath(context!)(using: .stroke)

    }
    
}

public  func randomColor () ->UIColor {
    //  产生随机的色值
    let red = arc4random() % 256
    let green = arc4random() % 256
    let blue = arc4random() % 256
    return UIColor(red: CGFloat(red) / 255, green: CGFloat(green) / 255, blue: CGFloat(blue) / 255, alpha: 1)
}

