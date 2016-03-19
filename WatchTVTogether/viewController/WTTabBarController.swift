//
//  WTTabBarController.swift
//  WatchTVTogether
//
//  Created by ChenDanny on 2016/3/18.
//  Copyright © 2016年 ChenDanny. All rights reserved.
//

import Foundation
import UIKit

class WTTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        for barItem in self.tabBar.items!{
            barItem.image = barItem.image?.imageWithRenderingMode(.AlwaysOriginal)
        }

    }
    
    
}
