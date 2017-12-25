//
//  UIColor+hexa.swift
//  hexa
//
//  Created by 郭源 on 16/8/9.
//  Copyright © 2016年 vincross. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1) {
        var newHexaString = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if newHexaString.hasPrefix("#") {
            newHexaString = newHexaString.substring(from: newHexaString.index(newHexaString.startIndex, offsetBy: 1))
        }else if newHexaString.hasPrefix("0X") {
            newHexaString = newHexaString.substring(from: newHexaString.index(newHexaString.startIndex, offsetBy: 2))
        }
        
        let divisor = CGFloat(255.0)
        typealias ColorTuple = (r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat)
        func hex3(_ value: UInt16) -> ColorTuple {
            var tuple: ColorTuple
            tuple.r = CGFloat((value & 0xF00) >> 8) / divisor
            tuple.g = CGFloat((value & 0x0F0) >> 4) / divisor
            tuple.b = CGFloat( value & 0x00F      ) / divisor
            tuple.a = alpha
            return tuple
        }
        
        func hex4(_ value: UInt16) -> ColorTuple {
            var tuple: ColorTuple
            tuple.r = CGFloat((value & 0xF000) >> 12) / divisor
            tuple.g = CGFloat((value & 0x0F00) >>  8) / divisor
            tuple.b = CGFloat((value & 0x00F0) >>  4) / divisor
            tuple.a = CGFloat( value & 0x000F       ) / divisor
            return tuple
        }
        
        func hex6(_ value: UInt32) -> ColorTuple {
            var tuple: ColorTuple
            tuple.r = CGFloat((value & 0xFF0000) >> 16) / divisor
            tuple.g = CGFloat((value & 0x00FF00) >>  8) / divisor
            tuple.b = CGFloat( value & 0x0000FF      ) / divisor
            tuple.a = alpha
            return tuple
        }
        
        func hex8(_ value: UInt32) -> ColorTuple {
            var tuple: ColorTuple
            tuple.r = CGFloat((value & 0xFF000000) >> 24) / divisor
            tuple.g = CGFloat((value & 0x00FF0000) >> 16) / divisor
            tuple.b = CGFloat((value & 0x0000FF00) >>  8) / divisor
            tuple.a = CGFloat( value & 0x000000FF       ) / divisor
            return tuple
        }
        
        var hexValue: UInt32 = 0
        guard Scanner(string: newHexaString).scanHexInt32(&hexValue) else {
            self.init(white: 1, alpha: 1)
            return
        }
        
        var color: ColorTuple
        switch newHexaString.characters.count {
        case 3: color = hex3(UInt16(hexValue))
        case 4: color = hex4(UInt16(hexValue))
        case 6: color = hex6(hexValue)
        case 8: color = hex8(hexValue)
        default: color = (1, 1, 1, 1)
        }
        self.init(red: color.r, green: color.g, blue: color.b, alpha: color.a)
    }
}

extension UIColor {
    
    /// 2e2e2e
    class var hexaCustomMainText: UIColor {
        return UIColor(hexString: "#2e2e2e")
    }
    
    /// 000000
    class var hexaAlertSureText: UIColor {
        return UIColor(hexString: "#000000")
    }
    
    
    /// 8c8c8c
    class var hexaCustomDetailText: UIColor {
        return UIColor(hexString: "#8c8c8c")
    }
    /// ec6666
    class var hexaErrorText: UIColor {
        return UIColor(hexString: "#ec6666")
    }
    /// e5e5e5
    class var hexaNormalSeparatorLine: UIColor {
        return UIColor(hexString: "#e5e5e5")
    }
    /// bebebe
    class var hexaAlertSeparatorLine: UIColor {
        return UIColor(hexString: "#bebebe")
    }
    /// cccccc
    class var hexaActionSheetSpearatorLine: UIColor {
        return UIColor(hexString: "#cccccc")
    }
    /// a6a6a6
    class var hexaCustomAlertText: UIColor {
        return UIColor(hexString: "#a6a6a6")
    }
    
    /// 3a7bdb
    class var hexaLblButtonText: UIColor {
        return UIColor(hexString: "#3a7bdb")
    }
    
    
    /// f0f0f0
    static let hexaCellHighlighted = UIColor(hexString: "#f0f0f0")
    /// d8d8d8
    static let hexaCustomBg = UIColor(hexString: "#e6e6e6")
    /// 492669
    static let hexaExploreFuncBg = UIColor(hexString: "#492669")
    /// 737373
    static let hexaSearchHistoryText = UIColor(hexString: "#737373")
    
    static let hexaExploreVideo = UIColor(hexString: "#cf2921")
}
