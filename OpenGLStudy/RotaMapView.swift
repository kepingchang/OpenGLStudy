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

        
        var newArr = Array(repeating:Array(repeating:Int(), count:width), count:height)

        
                for i in 0..<height {
                    for j in 0..<width {
                        newArr[i][j] = dataArr[i*width + j].intValue
                    }
                }
        
        
        print(newArr)

        
        for i in 0..<newArr.count {
            for j in 0..<newArr[i].count {
                if newArr[i][j] > 0 {
                    CGContext.addRect(context!)(CGRect(x: j, y: i, width: 1, height: 1))
                }
            }
        }
        CGContext.strokePath(context!)()
    }
}
