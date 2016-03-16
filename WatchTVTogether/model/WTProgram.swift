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
    var picture:UIImage?

    init(programId:String, programName:String, channelName:String, picture:UIImage? = nil){
        self.programId = programId
        self.programName = programName
        self.channelName = channelName
        self.picture = picture
    }
}