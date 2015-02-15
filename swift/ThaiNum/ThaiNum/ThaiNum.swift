//
//  ThaiNum.swift
//  ThaiNum
//
//  Created by Wittawas Nakkasem on 2/14/2558 BE.
//  Copyright (c) 2558 vittee. All rights reserved.
//

import Foundation

private let digitNames = ["ศูนย์", "หนึ่ง", "สอง", "สาม", "สี่", "ห้า", "หก", "เจ็ด", "แปด", "เก้า"]
private let unitNames = ["", "สิบ", "ร้อย", "พัน", "หมื่น", "แสน", "ล้าน"]

public class ThaiNum {
    
    // MARK: - digitizer
    
    private class func digitNumber(d: UnicodeScalar) -> Int {
        if let result = String(d).toInt() {
            return result
        }
        
        return 0
    }
    
    private class func digitToName(d: UnicodeScalar) -> String {
        if let result = String(d).toInt() {
            return digitNames[result]
        }
        
        return ""
    }
    
    // MARK: - digitize
    
    internal class func digitize<T>(s: String, mapper m: (UnicodeScalar) -> T) -> [T] {
        let decimalCharSet = NSCharacterSet.decimalDigitCharacterSet()
        
        return Array(s.unicodeScalars)
            .filter { (d: UnicodeScalar) -> Bool in
                decimalCharSet.longCharacterIsMember(d.value)
            }
            .map(m)
    }
    
    internal class func digitize<T>(n: Int64, mapper: (UnicodeScalar) -> T) -> [T] {
        return digitize(String(n), mapper)
    }
    
    // MARK: - convert
    
    internal class func convert(n: Int64) -> String {
        var dd = digitize(n, mapper: digitNumber)
        
        var result: String = "";
        
        if (n < 0) {
            result += "ลบ"
        }
        
        if (dd.count == 1) {
            return result + digitNames[dd[0]]
        }
        
        var t = false
        
        for (i, d) in enumerate(dd) {
            let c = (dd.count - i - 1) % 6
            
            if (d == 2 && c == 1) {
                result += "ยี่"
            } else if (d == 1 && c == 0 && t) {
                result += "เอ็ด"
            } else if ((d != 1 || c != 1) && (d != 0)) {
                result += digitNames[d];
            }
            
            if (c != 0 && d != 0) {
                result += unitNames[c]
            }
            
            if (c == 0 && i != dd.count - 1) {
                result += unitNames[6]
            }
            
            if (c == 1) {
                t = d != 0;
            }
            
        }
        
        return result
    }
    
    private typealias Part = (i: Int64, f: Double)
    
    private class func part(n: Double) -> Part {
        var p: Part = (i: 0, f: 0)
        
        if (n < 1e15) {
            p.i = Int64(n)
            p.f = n - Double(p.i)
        }
        
        return p
    }
    
    private class func extractDecimal(n: Double) -> String? {
        if let decimals = String(format: "%f", n).componentsSeparatedByString(".").last {
            var error: NSError?
            var regex = NSRegularExpression(pattern: "0*$", options: nil, error: &error)!
        
            var fs = regex.stringByReplacingMatchesInString(decimals, options: nil, range: NSMakeRange(0, countElements(decimals)), withTemplate: "")
            
            if !fs.isEmpty {
                return fs
            }
    
        }
        
        return nil
    }
    
    // MARK: - public
    
    public class func text(n: Double) -> String {
        var p = part(n)
        
        var result = convert(p.i)
        
        if (p.f != 0) {
            if let decimals = extractDecimal(n) {
                result += "จุด"
                
                for s in digitize(decimals, digitToName) {
                    result += s
                }
            }
        }
        
        return result
    }
    
    public class func bahtText(n: Double) -> String {
        var p = part(n)
        
        var result = convert(p.i) + "บาท"
        
        if (p.f != 0) {
            
            if let decimals = String(format: "%.2f", n).componentsSeparatedByString(".").last {
                if let satang = decimals.substringToIndex(advance(decimals.startIndex, 2)).toInt() {
                    result += convert(Int64(satang)) + "สตางค์"
                }
            
            }
        
        }
        
        return result
    }
}

