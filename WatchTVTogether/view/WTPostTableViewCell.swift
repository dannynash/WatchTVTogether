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
    @IBOutlet weak var responseNums: UILabel!
    @IBOutlet weak var pictrueView: UIImageView!
    @IBOutlet weak var rankLabel: UILabel!
    
    
    func setPost(post:WTPost!, rank:Int = -1){
        programTitle.text = post.programTitle
        responseNums.text = "\(post.responseNums)\(NSLocalizedString("totalPostNumber", comment: ""))"
        if rank != -1 {
            rankLabel.text = "#\(rank)"
        } else {
            rankLabel.text = ""
        }

        if post.picture != nil{
            self.pictrueView.image = post.picture
            self.pictrueView.autoresizingMask = .FlexibleHeight
            self.pictrueView.contentMode = .ScaleAspectFit
        }
        
        
    }
    
}
