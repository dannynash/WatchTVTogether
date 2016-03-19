//
//  WTUtility.swift
//  WatchTVTogether
//
//  Created by ChenDanny on 2016/3/18.
//  Copyright © 2016年 ChenDanny. All rights reserved.
//

import Foundation
import UIKit

func UIColorFromRGB(rgbValue: UInt) -> UIColor {
    return UIColor(
        red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
}

extension NSTimeInterval {
    var minuteSecondMS: String {
        return String(format:"%d:%02d.%03d", minute, second, millisecond)
    }
    var minute: Int {
        return Int(self/60.0 % 60)
    }
    var second: Int {
        return Int(self % 60)
    }
    var millisecond: Int {
        return Int(self*1000 % 1000 )
    }
}


class WTTimeUtility{
    
    static let shareInstance = WTTimeUtility()
    
//    let reponseTimeFormatter =
//    NSTimeInterval // sec
    func getResponseTime(timestamp:NSTimeInterval) -> String{
        let now = NSDate().timeIntervalSince1970
        let offset = now - timestamp
        
        if (offset < 60){
            // sec
            return "\(Int(offset))秒前"
        } else if (offset < 3600){
            // min
            let min = offset/60.0
            return "\(Int(min))分鐘前"

        } else if (offset < 86400){
            // hour
            let min = offset/3600
            return "\(Int(min))小時前"
            
        } else {
            return ""
        }
    }
    
    func timeIntervalWithServerTime(time:Int) -> NSTimeInterval{
        
        return NSTimeInterval(time/1000)
    }

}