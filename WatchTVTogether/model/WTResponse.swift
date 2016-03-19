//
//  WTResponse.swift
//  WatchTVTogether
//
//  Created by ChenDanny on 2016/3/18.
//  Copyright © 2016年 ChenDanny. All rights reserved.
//

import Foundation
import UIKit

class WTResponse {
    let name:String
    let response:String
    let updateTime:NSTimeInterval?
    let userPicture:UIImage?
    
    init(name:String, response:String, updateTime:NSTimeInterval? = -1, userPicture:UIImage? = nil){
        self.name = name
        self.response = response
        self.updateTime = updateTime
        self.userPicture = userPicture
    }
    
    
}