//
//  WTPostTableViewCell.swift
//  WatchTVTogether
//
//  Created by ChenDanny on 2016/3/15.
//  Copyright © 2016年 ChenDanny. All rights reserved.
//

import Foundation
import UIKit

class WTPostTableViewCell: UITableViewCell {
    
    @IBOutlet weak var programTitle: UILabel!
    @IBOutlet weak var channelTitle: UILabel!
    @IBOutlet weak var responseNums: UILabel!
    @IBOutlet weak var lastResponse: UILabel!
    @IBOutlet weak var lastUpdateTime: UILabel!
    @IBOutlet weak var pictrueView: UIImageView!
    
    func setPost(post:WTPost!){
        programTitle.text = post.programTitle
        channelTitle.text = post.channelTitle
        responseNums.text = post.responseNums
        lastResponse.text = post.lastResponse
        lastUpdateTime.text = post.lastUpdateTime
        
        if post.picture != nil{
            self.pictrueView.image = post.picture
        }
    }
    
    
}
