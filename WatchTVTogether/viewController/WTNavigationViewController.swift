//
//  WTNavigationViewController.swift
//  WatchTVTogether
//
//  Created by dannynash on 2016/3/20.
//  Copyright © 2016年 ChenDanny. All rights reserved.
//

import Foundation
import UIKit

class WTNavigationViewController:UINavigationController{
    
    override func viewDidLoad() {
        self.navigationBar.backgroundColor = UIColor(red: 232.0/255.0, green: 121.0/255.0, blue: 117.0/255.0, alpha: 1.0)
        self.navigationBar.barTintColor = UIColor(red: 227.0/255.0, green: 94.0/255.0, blue: 85.0/255.0, alpha: 1.0)
        self.navigationBar.opaque = true
        
        let titleDict: NSDictionary = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        
        self.navigationBar.titleTextAttributes = titleDict as? [String : AnyObject]
        
        self.navigationBar.barStyle = .Default

        self.setNeedsStatusBarAppearanceUpdate();

        self.navigationBar.backItem?.setHidesBackButton(true, animated: false)
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }
    
}