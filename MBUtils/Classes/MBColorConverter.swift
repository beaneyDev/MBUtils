//
//  MBColorConverter.swift
//  Pods
//
//  Created by Matt Beaney on 15/01/2017.
//
//

import Foundation
import UIKit

open class MBColorConverter {
    open static func convertColorFromRGBString(_ rgb: String?) -> UIColor? {
        guard let rgb = rgb, rgb != "" else {
            return nil
        }
        
        if rgb.hasPrefix("#") {
            return hexStringToUIColor(rgb)
        }
        
        let strVal = NSMutableString(string: rgb)
        strVal.replaceOccurrences(of: "rgba(", with: "", options: [], range: NSRange(location: 0, length: strVal.length))
        strVal.replaceOccurrences(of: "rgb(", with: "", options: [], range: NSRange(location: 0, length: strVal.length))
        strVal.replaceOccurrences(of: ")", with: "", options: [], range: NSRange(location: 0, length: strVal.length))
        strVal.replaceOccurrences(of: " ", with: "", options: [], range: NSRange(location: 0, length: strVal.length))
        
        let charSet = strVal.components(separatedBy: ",")
        
        guard let red = Double(charSet[0]),
            let green = Double(charSet[1].trimmingCharacters(in: CharacterSet.whitespaces)),
            let blue = Double(charSet[2].trimmingCharacters(in: CharacterSet.whitespaces)) else {
                return nil
        }
        
        return UIColor(
            red: CGFloat(red / 255.0),
            green: CGFloat(green / 255.0),
            blue: CGFloat(blue / 255.0),
            
            alpha: 1.0)
    }
    
    open static func hexStringToUIColor(_ hex: String?, defaultingTo other: UIColor = .clear) -> UIColor {
        guard let colour = hexStringToOptionColour(hex) else {
            return other
        }
        
        return colour
    }
    
    open static func hexStringToOptionColour(_ hex: String?) -> UIColor? {
        guard let hex = hex, hex != "" else {
            return nil
        }
        
        let colour = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        
        let scanner = Scanner(string: colour)
        scanner.scanString("#", into: nil)
        scanner.scanString("0x", into: nil)
        
        var rgbValue = UInt32(0)
        scanner.scanHexInt32(&rgbValue)
        
        return UIColor(
            red:    CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green:  CGFloat((rgbValue & 0x00FF00) >> 8)  / 255.0,
            blue:   CGFloat((rgbValue & 0x0000FF) >> 0)  / 255.0,
            alpha:  CGFloat(1.0)
        )
    }
    
    open static func rgbFromColor(_ color: UIColor) -> String {
        let components = rgbArrayFromColor(color)
        
        
        var rgbString = "rgb(\(components[0]),\(components[1]),\(components[2]))"
        
        rgbString = rgbString.replacingOccurrences(of: ".0", with: "")
        return rgbString
    }
    
    open static func rgbArrayFromColor(_ color: UIColor) -> [CGFloat] {
        var (r, g, b) : (CGFloat, CGFloat, CGFloat) = (0, 0, 0)
        
        guard let components = color.cgColor.components else {
            return [r, g, b]
        }
        
        switch (color.cgColor.numberOfComponents) {
        case 1, 2: r = components[0]; g = components[0]; b = components[0]
        case 3, 4: r = components[0]; g = components[1]; b = components[2]
            
        default: break // nothing
        }
        
        return [r * 255, g * 255, b * 255]
    }
    
    open static func shouldUseDarkText(_ color: UIColor) -> Bool {
        let rgb: [CGFloat] = rgbArrayFromColor(color)
        let r: CGFloat = rgb[0]
        let g: CGFloat = rgb[1]
        let b: CGFloat = rgb[2]
        let finalValue: CGFloat = ((r * 299.0) + (g * 587.0) + (b * 114.0)) / 1000
        
        if finalValue < 125.0 {
            return false
        } else {
            return true
        }
    }
}
