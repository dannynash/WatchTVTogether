//
//  WTGradientView.swift
//  WatchTVTogether
//
//  Created by ChenDanny on 2016/3/18.
//  Copyright © 2016年 ChenDanny. All rights reserved.
//

import Foundation
import UIKit

class WTGradientView: UIView {
    
    override class func layerClass() -> AnyClass{
        return CAGradientLayer.self
    }
    
    func gradientWithColors(firstColor : UIColor, _ secondColor : UIColor) {
        
        let deviceScale = UIScreen.mainScreen().scale
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRectMake(0.0, 0.0, self.frame.size.width * deviceScale, self.frame.size.height * deviceScale)
        let frame = self.frame.size
        gradientLayer.colors = [ firstColor.CGColor, secondColor.CGColor ]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPointMake(0.0, 0.0)
        gradientLayer.endPoint = CGPointMake(1.0, 0.0)

        self.layer.insertSublayer(gradientLayer, atIndex: 0)
    }

}