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

        if post.pictureUrl != nil{
            self.setImage(post.pictureUrl!)
        }
    }
    
    private func setImage(pictureUrl:String){
        WTImageProxy().fetchImage(pictureUrl) { [weak self](result) -> Void in
            
            guard let sSelf = self else {
                return
            }
            sSelf.pictrueView.image = result
            sSelf.pictrueView.autoresizingMask = .FlexibleHeight
            sSelf.pictrueView.contentMode = .ScaleAspectFit
        }
    }
    
}
