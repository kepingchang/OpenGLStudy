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
        
        let testDataArray = [
            ["X":20,"Y":30],
            ["X":30,"Y":40],
            ["X":50,"Y":80],
            ["X":100,"Y":200]
        ]

        for i in 0..<testDataArray.count-1  {

            let firstPoint = CGPoint(x: CGFloat(testDataArray[i]["X"]!), y: CGFloat(testDataArray[i]["X"]!))
            let secondPoint = CGPoint(x: CGFloat(testDataArray[i+1]["X"]!), y: CGFloat(testDataArray[i+1]["X"]!))

            bezier.move(to: firstPoint)
            bezier.addCurve(to: secondPoint, controlPoint1: CGPoint(x: (secondPoint.x-firstPoint.x)/2+firstPoint.x, y: firstPoint.y), controlPoint2: CGPoint(x: (secondPoint.x-firstPoint.x)/2+firstPoint.x, y: secondPoint.y))
        }
        

//        for i in 0..<dataArr.count-1 {
//            let firstPoint = CGPoint(x: 20.0*CGFloat(dataArr[i]["X"].floatValue), y: 20.0*CGFloat(dataArr[i]["Y"].floatValue))
//            let secondPoint = CGPoint(x: 20.0*CGFloat(dataArr[i+1]["X"].floatValue), y: 20.0*CGFloat(dataArr[i+1]["Y"].floatValue))
//
//            print("\(firstPoint)\(secondPoint)")
//
//            bezier.move(to: firstPoint)
//            bezier.addCurve(to: secondPoint, controlPoint1: CGPoint(x: (secondPoint.x-firstPoint.x)/2+firstPoint.x, y: firstPoint.y), controlPoint2: CGPoint(x: (secondPoint.x-firstPoint.x)/2+firstPoint.x, y: secondPoint.y))
//        }

        
        UIColor.red.setStroke()
        CGContext.setLineWidth(context!)(5)
        CGContext.addPath(context!)(bezier.cgPath)
        CGContext.drawPath(context!)(using: .stroke)

    }
    
}
