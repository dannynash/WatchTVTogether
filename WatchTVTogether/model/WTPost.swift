//
//  WTPost.swift
//  WatchTVTogether
//
//  Created by ChenDanny on 2016/3/15.
//  Copyright © 2016年 ChenDanny. All rights reserved.
//

import Foundation
import UIKit

class WTPost {
    let programId:String
    let programTitle:String
    let channelTitle:String
    var responseNums:String
    var lastResponse:String
    var lastUpdateTime:String
    var picture:UIImage?
    
    init(programId:String, programTitle:String, channelTitle:String, responseNums:String, lastResponse:String, lastUpdateTime:String, picture:UIImage?){
    
        self.programId = programId
        self.programTitle = programTitle
        self.channelTitle = channelTitle
        self.responseNums = responseNums
        self.lastResponse = lastResponse
        self.lastUpdateTime = lastUpdateTime
        
        if picture != nil{
            self.picture = picture
        }
    }

}