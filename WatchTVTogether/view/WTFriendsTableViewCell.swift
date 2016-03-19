//
//  WTFriendsTableViewCell.swift
//  WatchTVTogether
//
//  Created by ChenDanny on 2016/3/15.
//  Copyright © 2016年 ChenDanny. All rights reserved.
//

import Foundation
import UIKit

class WTFriendsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var pictureView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var programLabel: UILabel!
    
    func setFriend(friend:WTFriend){
        self.nameLabel.text = friend.userName
        self.programLabel.text = friend.programName
        
        if friend.pictureUrl != nil{
            self.setImage(friend.pictureUrl!)
        }
    }
    
    private func setImage(pictureUrl:String){
        self.pictureView.image = UIImage(named: pictureUrl)
    }
}