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
        let context = UIGraphicsGetCurrentContext()

        
        let bezier = UIBezierPath()
        
        for i in 0..<dataArr.count {
            let x = dataArr[i]["X"].floatValue
            let y = dataArr[i]["Y"].floatValue
            print(CGPoint(x: CGFloat(x), y: CGFloat(y)))
            UIBezierPath.move(bezier)(to: CGPoint(x: CGFloat(x), y: CGFloat(y)))
        }

        
        UIColor.red.setStroke()
        CGContext.setLineWidth(context!)(5)
        CGContext.addPath(context!)(bezier.cgPath)
        CGContext.drawPath(context!)(using: .stroke)

    }
    
}
