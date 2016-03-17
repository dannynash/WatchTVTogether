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
    let program:WTProgram
    var responseNums:String
    var lastResponse:String
    var lastUpdateTime:String
    
    var programId:String{
        get{
            return program.programId
        }
    }
    var programTitle:String{
        get{
            return program.programName
        }
    }
    var channelTitle:String{
        get{
            return program.channelName
        }
    }
    var picture:UIImage?{
        get{
            return program.picture
        }
    }

    init(program:WTProgram, responseNums:String, lastResponse:String, lastUpdateTime:String){
        self.program = program
        self.responseNums = responseNums
        self.lastResponse = lastResponse
        self.lastUpdateTime = lastUpdateTime
        
    }
    
    init(programId:String, programTitle:String, channelTitle:String, responseNums:String, lastResponse:String, lastUpdateTime:String, picture:UIImage?){
    
        self.program = WTProgram(programId: programId, programName: programTitle, channelName: channelTitle, picture: picture)
        
        self.responseNums = responseNums
        self.lastResponse = lastResponse
        self.lastUpdateTime = lastUpdateTime
        
    }

}