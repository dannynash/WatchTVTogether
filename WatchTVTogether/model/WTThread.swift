//
//  WTThread.swift
//  WatchTVTogether
//
//  Created by dannynash on 2016/3/19.
//  Copyright © 2016年 ChenDanny. All rights reserved.
//

import Foundation

struct WTThread{
    let threadId:String
    let source:WTThreadSource
    let url:String
    let responseNum:Int
    let lastResponse:[WTResponse]
    let lastUpdateTime:NSTimeInterval
    
    init(threadId:String, source:WTThreadSource, url:String, responseNum:Int, lastResponse:[WTResponse], lastUpdateTime:NSTimeInterval){
        self.threadId = threadId
        self.source = source
        self.url = url
        self.responseNum = responseNum
        self.lastResponse = lastResponse
        self.lastUpdateTime = lastUpdateTime
    }
    
    
}