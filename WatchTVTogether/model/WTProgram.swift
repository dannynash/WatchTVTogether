//
//  WTProgram.swift
//  WatchTVTogether
//
//  Created by ChenDanny on 2016/3/16.
//  Copyright © 2016年 ChenDanny. All rights reserved.
//

import Foundation
import UIKit

struct WTProgram {
    
    let programId:String
    let programName:String
    let channelName:String
    var pictureUrl:String?

    init(programId:String, programName:String, channelName:String, pictureUrl:String? = nil){
        self.programId = programId
        self.programName = programName
        self.channelName = channelName
        
        guard pictureUrl != nil else {
            return
        }
        
        self.pictureUrl = pictureUrl
    }
}