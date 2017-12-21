//
//  RotaMapView.swift
//  OpenGLStudy
//
//  Created by KKING on 2017/12/19.
//  Copyright © 2017年 KKING. All rights reserved.
//

import UIKit

class RotaMapView: UIView {
    
    var dataArr = Array<JSON>()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .cyan
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
                if dataArr[i*width + j].intValue > 0 {
                    CGContext.addRect(context!)(CGRect(x: j, y: i, width: 1, height: 1))
                }
            }
        }
        CGContext.strokePath(context!)()
    }
}



class RotaTraceView: UIView {
    
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
        
        
        let startx = self.bounds.width + positionX
        let starty = self.bounds.height + positionY
        
        bezier.move(to: CGPoint(x: startx, y: starty))
        
        print(CGPoint(x: startx, y: starty))
        
        for i in 0..<dataArr.count-1 {
            if i != 0 {
                bezier.addLine(to: CGPoint(x: startx + 20*CGFloat(dataArr[i]["X"].floatValue), y: starty - 20*CGFloat(dataArr[i]["Y"].floatValue)))
                
                print(CGPoint(x: startx + 20*CGFloat(dataArr[i]["X"].floatValue), y: starty - 20*CGFloat(dataArr[i]["Y"].floatValue)))
            }
        }

        // 绘制曲线
//        print("\(firstPoint)\(secondPoint)")
//
//        bezier.move(to: firstPoint)
//        bezier.addCurve(to: secondPoint, controlPoint1: CGPoint(x: (secondPoint.x-firstPoint.x)/2+firstPoint.x, y: firstPoint.y), controlPoint2: CGPoint(x: (secondPoint.x-firstPoint.x)/2+firstPoint.x, y: secondPoint.y))
        
        
        UIColor.red.setStroke()
        CGContext.setLineWidth(context!)(5)
        CGContext.addPath(context!)(bezier.cgPath)
        CGContext.drawPath(context!)(using: .stroke)

    }
    
}
