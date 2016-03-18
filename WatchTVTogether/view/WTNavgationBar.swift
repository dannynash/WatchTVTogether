//
//  WTNavgationBar.swift
//  WatchTVTogether
//
//  Created by ChenDanny on 2016/3/18.
//  Copyright © 2016年 ChenDanny. All rights reserved.
//

import Foundation
import UIKit

class WTNavgationBar:UINavigationBar {
    
    let navGradient = WTGradientView()
    var isSetColor = false
    
    func setGradientAndLayout(){
//        if isSetColor == false {
            let firstColor = UIColor(red: 232.0/255.0, green: 121.0/255.0, blue: 117.0/255.0, alpha: 1.0)
            let secondColor = UIColor(red: 243.0/255.0, green: 199.0/255.0, blue: 161.0/255.0, alpha: 1.0)
            
            //        myGradientView.frame = a!
            navGradient.backgroundColor = UIColor.yellowColor()
            navGradient.gradientWithColors(firstColor, secondColor)
            //        let layer = self.layer.sublayers![0]
            //        layer.insertSublayer(navGradient as , atIndex: 0)
            
            self.insertSubview(navGradient, atIndex: 0)
            
            isSetColor = true
//        }
        
//        let a = self.frame
//        let b = navGradient.frame
        navGradient.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)
    }
    
    override func layoutSubviews() {
        self.navGradient.removeFromSuperview()
        self.setGradientAndLayout()
        
//        self.navGradient
    }
    
    
    
}