//
//  WTDetailResponseCell.swift
//  WatchTVTogether
//
//  Created by dannynash on 2016/3/19.
//  Copyright © 2016年 ChenDanny. All rights reserved.
//

import Foundation
import UIKit

class WTDetailResponseCell:UITableViewCell{
    
    @IBOutlet weak var picture: UIImageView!
    
    @IBOutlet weak var name: UILabel!
    
    @IBOutlet weak var response: UILabel!
    
    @IBOutlet weak var time: UILabel!
    
    
    func setData(response:WTResponse){
        self.name.text = response.name
        self.response.text = response.response
        
        if let pic = response.userPicture{
            self.picture.image = pic
        }
        
        if let time = response.updateTime{
            self.time.text = WTTimeUtility().getResponseTime(time)
        } else {
            self.time.text = ""
        }
    }
}
