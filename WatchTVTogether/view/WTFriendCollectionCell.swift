//
//  WTFriendCollectionCell.swift
//  WatchTVTogether
//
//  Created by ChenDanny on 2016/3/18.
//  Copyright © 2016年 ChenDanny. All rights reserved.
//

import Foundation
import UIKit

class WTFriendCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var pictureView: UIImageView!    
    @IBOutlet weak var nameLabel: UILabel!
    
    func setFriend(friend:WTFriend){
        self.nameLabel.text = friend.userName
        
        if friend.pictureUrl != nil {
            self.pictureView.image = UIImage(named:friend.pictureUrl!)
        }
    }
    
}