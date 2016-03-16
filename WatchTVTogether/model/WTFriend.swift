//
//  WTFriend.swift
//  WatchTVTogether
//
//  Created by ChenDanny on 2016/3/16.
//  Copyright © 2016年 ChenDanny. All rights reserved.
//

import Foundation
import UIKit

enum WTFriendStatus {
    case online
    case offline
}

class WTFriend {
    let userId:String
    let userName:String
    var userStatus:WTFriendStatus
    var programId:String?
    var picture:UIImage?
    
    init(userId:String, userName:String, userStatus:WTFriendStatus = WTFriendStatus.offline , programId:String? = nil, picture:UIImage? = nil){
        
        self.userId = userId
        self.userName = userName
        self.userStatus = userStatus
        self.programId = programId
        self.picture = picture
    }
    
}