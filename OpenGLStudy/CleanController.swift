//
//  ViewController.swift
//  OpenGLStudy
//
//  Created by KKING on 2017/12/18.
//  Copyright © 2017年 KKING. All rights reserved.
//

import UIKit

class CleanController: UIViewController {
    
    var mapView = RotaMapView()
    var traceView = RotaTraceView()
    
    
    var drawnum = 0
    
    var json = JSON()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(mapView)
        view.addSubview(traceView)
        
                mapView.center = view.center
        //        traceView.center = view.center
        
        
        let fileName = Bundle.main.path(forResource: "data", ofType: "plist")
        let dataArr = NSArray(contentsOfFile: fileName!) as! [[String: Any]]
        
        do {
            
            let data = try JSONSerialization.data(withJSONObject: dataArr, options: .prettyPrinted)
            json = JSON(data: data)
            
        }catch let error {
            print(error)
        }
    }
    
    private func drawMap(drawnum: Int) {
        
        let width = json[drawnum]["Map"]["Info"]["Width"]
        let height = json[drawnum]["Map"]["Info"]["Height"]
        
        if drawnum == 0 {
            mapView.center = view.center
            mapView.bounds = CGRect(x: 0, y: 0, width: CGFloat(width.floatValue), height: CGFloat(height.floatValue))
        }else {
            mapView.frame = CGRect(x: mapView.frame.origin.x + 20*(CGFloat(json[drawnum]["Map"]["Info"]["Origin"]["Position"]["X"].floatValue) - CGFloat(json[drawnum-1]["Map"]["Info"]["Origin"]["Position"]["X"].floatValue)), y: mapView.frame.origin.y + 20*(CGFloat(json[drawnum]["Map"]["Info"]["Origin"]["Position"]["Y"].floatValue) - CGFloat(json[drawnum-1]["Map"]["Info"]["Origin"]["Position"]["Y"].floatValue)), width: CGFloat(width.floatValue), height: CGFloat(height.floatValue))
        }
        
        
        print(mapView.frame)
        
        //draw point
        print("\(json[drawnum]["Map"]["Data"].arrayValue.count)")
        
        
        mapView.dataArr = json[drawnum]["Map"]["Data"].arrayValue
        mapView.setNeedsDisplay()
    }
    
    
    private func drawTrace(drawnum: Int) {
        
        let width = json[drawnum]["Map"]["Info"]["Width"]
        let height = json[drawnum]["Map"]["Info"]["Height"]
        
        
        if drawnum == 0 {
            traceView.center = view.center
            traceView.bounds = CGRect(x: 0, y: 0, width: CGFloat(width.floatValue), height: CGFloat(height.floatValue))
        }else {
            traceView.frame = CGRect(x: traceView.frame.origin.x + 20*(CGFloat(json[drawnum]["Map"]["Info"]["Origin"]["Position"]["X"].floatValue) - CGFloat(json[drawnum-1]["Map"]["Info"]["Origin"]["Position"]["X"].floatValue)), y: traceView.frame.origin.y + 20*(CGFloat(json[drawnum]["Map"]["Info"]["Origin"]["Position"]["Y"].floatValue) - CGFloat(json[drawnum-1]["Map"]["Info"]["Origin"]["Position"]["Y"].floatValue)), width: CGFloat(width.floatValue), height: CGFloat(height.floatValue))
        }
        
        traceView.dataArr = json[drawnum]["Trace"].arrayValue
        traceView.positionX = 20*CGFloat(json[drawnum]["Map"]["Info"]["Origin"]["Position"]["X"].floatValue)
        traceView.positionY = 20*CGFloat(json[drawnum]["Map"]["Info"]["Origin"]["Position"]["Y"].floatValue)
        
        traceView.setNeedsDisplay()
    }
    
    
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if drawnum < json.count {
            drawMap(drawnum: drawnum)
            drawTrace(drawnum: drawnum)
            drawnum += 1
        }else {
            drawnum = 0
        }
    }
    
}

