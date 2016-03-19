//
//  WTDetailThread.swift
//  WatchTVTogether
//
//  Created by dannynash on 2016/3/19.
//  Copyright © 2016年 ChenDanny. All rights reserved.
//

import Foundation

struct WTDetailThread{
    let thread:WTThread
    var moreResponse = [WTResponse]()
    
    init(thread:WTThread, moreResponse:[WTResponse]? = nil){
        
        self.thread = thread
        if let more = moreResponse {
            self.moreResponse = more
        }
    }
    
    
}