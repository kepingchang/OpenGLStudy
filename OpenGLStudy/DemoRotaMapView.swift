//
//  RotaMapView.swift
//  OpenGLStudy
//
//  Created by KKING on 2017/12/19.
//  Copyright © 2017年 KKING. All rights reserved.
//

import UIKit

class DemoRotaMapView: UIImageView {
    
    func changeShape(dataArr: Array<JSON>){
        let width = Int(bounds.width)
        let height = Int(bounds.height)
        
        // 位图的大小 ＝ 图片宽 ＊ 图片高 ＊ 图片中每点包含的信息量
        let imgByteCount = width * height * 4
        
        // 使用系统的颜色空间
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        // 计算总大小,申请内存空间
        let shapeByteCount = width * height * 4
        let shapeVoideData = malloc(shapeByteCount)
        defer {free(shapeVoideData)}
        let shapeData = unsafeBitCast(shapeVoideData, to: UnsafeMutablePointer<CUnsignedChar>.self)
        
        for i in 0..<height {
            for j in 0..<width {
                /// .///
                let offset = ((height - i - 1)*width + j)*4
                let pointee = dataArr[i*width + j].intValue
                if pointee > 0 && pointee <= 70 {
                    (shapeData+offset).pointee = 1
                    (shapeData+offset+1).pointee = CUnsignedChar(16)
                    (shapeData+offset+2).pointee = CUnsignedChar(213)
                    (shapeData+offset+3).pointee = CUnsignedChar(161)
                }else if pointee > 70 {
                    (shapeData+offset).pointee = 1
                    (shapeData+offset+1).pointee = CUnsignedChar(96)
                    (shapeData+offset+2).pointee = CUnsignedChar(219)
                    (shapeData+offset+3).pointee = CUnsignedChar(181)
                }
            }
        }
        
        // 创建位图
        let imgContext = CGContext(data: shapeData,
                                   width: width,
                                   height: height,
                                   bitsPerComponent: 8,
                                   bytesPerRow: width * 4,
                                   space: colorSpace,
                                   bitmapInfo: CGImageAlphaInfo.premultipliedFirst.rawValue)
        
        let outImage = imgContext?.makeImage()
        
        // 根据图形上下文绘图
        let img = UIImage(cgImage: outImage!)
        
        self.image = img
        
        
        
    }
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor(hexString: "#ebecf1")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
        
        bezier.move(to: CGPoint(x: startx, y: starty))
        
        for i in 0..<dataArr.count-1 {
            if i != 0 {
                bezier.addLine(to: CGPoint(x: CGFloat(Int64(startx + 20*CGFloat(dataArr[i]["X"].floatValue))), y: CGFloat(Int64(starty - 20*CGFloat(dataArr[i]["Y"].floatValue)))))
            }
        }
        
        // 绘制曲线
        //        DLog("\(firstPoint)\(secondPoint)")
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

