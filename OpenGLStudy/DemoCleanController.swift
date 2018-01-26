//
//  ViewController.swift
//  OpenGLStudy
//
//  Created by KKING on 2017/12/18.
//  Copyright © 2017年 KKING. All rights reserved.
//

import UIKit

class DemoCleanController: UIViewController {
    
    var mapView = DemoRotaMapView(frame: CGRect.zero)
    
    var traceView = DemoRotaTraceView()
    
    
    var drawnum = 0
    
    var json = JSON()
    var timer = Timer()
    
    //捏合手势
    @objc func pinchDid(pinch:UIPinchGestureRecognizer) {
//        DLog(pinch.scale)//打印捏合比例
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .black
        view.addSubview(mapView)
        view.addSubview(traceView)
        
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(pinchDid(pinch:)))
        mapView.isUserInteractionEnabled = true
        mapView.addGestureRecognizer(pinch)
        
        
//        HexaLoading.show(in: view, title: "数据处理中...")
        DispatchQueue.global().async {
            let fileName = Bundle.main.path(forResource: "mapTwo", ofType: "plist")
            let dataArr = NSArray(contentsOfFile: fileName!) as! [[String: Any]]
            
            do {
                let data = try JSONSerialization.data(withJSONObject: dataArr, options: .prettyPrinted)
                self.json = try JSON(data: data)
            }catch let error {
//                DLog(error)
//                HexaHUD.show(with: "数据处理失败")
            }
        }
        
        if #available(iOS 10.0, *) {
            self.timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { (timer) in
                if self.drawnum < self.json.count {
                    self.drawMap(drawnum: self.drawnum)
                    self.drawTrace(drawnum: self.drawnum)
                    self.drawnum += 1
                }else {
                    self.drawnum = 0
                }
            })
        } else {
            // Fallback on earlier versions
        }
        self.timer.fire()
    }
    
    private func drawMap(drawnum: Int) {
        
        let width = CGFloat(json[drawnum]["Map"]["Info"]["Width"].floatValue)
        let height = CGFloat(json[drawnum]["Map"]["Info"]["Height"].floatValue)
        
        var rect = CGRect.zero
        
        if drawnum == 0 {
//            HexaLoading.hide(in: view)
//            HexaHUD.show(with: "数据处理完成，开始绘图...")
            rect = CGRect(x: (UIScreen.main.bounds.width - width)/2, y: view.center.y - height/2 - 20, width: width, height: height)
        }else {
            rect = CGRect(x: mapView.frame.origin.x + 20*(CGFloat(json[drawnum]["Map"]["Info"]["Origin"]["Position"]["X"].floatValue) - CGFloat(json[drawnum-1]["Map"]["Info"]["Origin"]["Position"]["X"].floatValue)), y: mapView.frame.origin.y + 20*(CGFloat(json[drawnum]["Map"]["Info"]["Origin"]["Position"]["Y"].floatValue) - CGFloat(json[drawnum-1]["Map"]["Info"]["Origin"]["Position"]["Y"].floatValue)), width: width, height: height)
        }
        
        //        DLog("😎😎😎😎😎")
        //        DLog(drawnum)
        //        DLog(json[drawnum]["Map"]["Data"].arrayValue.count)
        //        DLog(mapView.frame)
        
        mapView.changeShape(dataArr: json[drawnum]["Map"]["Data"].arrayValue, rect: rect)
    }
    
    private func drawTrace(drawnum: Int) {
        
        let width = json[drawnum]["Map"]["Info"]["Width"]
        let height = json[drawnum]["Map"]["Info"]["Height"]
        
        
        if drawnum == 0 {
            traceView.center = CGPoint(x: view.center.x, y: view.center.y-20)
            traceView.bounds = CGRect(x: 0, y: 0, width: CGFloat(width.floatValue), height: CGFloat(height.floatValue))
        }else {
            traceView.frame = CGRect(x: traceView.frame.origin.x + 20*(CGFloat(json[drawnum]["Map"]["Info"]["Origin"]["Position"]["X"].floatValue) - CGFloat(json[drawnum-1]["Map"]["Info"]["Origin"]["Position"]["X"].floatValue)), y: traceView.frame.origin.y + 20*(CGFloat(json[drawnum]["Map"]["Info"]["Origin"]["Position"]["Y"].floatValue) - CGFloat(json[drawnum-1]["Map"]["Info"]["Origin"]["Position"]["Y"].floatValue)), width: CGFloat(width.floatValue), height: CGFloat(height.floatValue))
        }
        
        traceView.dataArr = json[drawnum]["Trace"].arrayValue
        traceView.positionX = 20*CGFloat(json[drawnum]["Map"]["Info"]["Origin"]["Position"]["X"].floatValue)
        traceView.positionY = CGFloat(json[drawnum]["Map"]["Info"]["Height"].floatValue) + 20*CGFloat(json[drawnum]["Map"]["Info"]["Origin"]["Position"]["Y"].floatValue)
        
        traceView.setNeedsDisplay()
    }
}

