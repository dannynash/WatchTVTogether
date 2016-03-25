//
//  WTFlexibleCell.swift
//  WatchTVTogether
//
//  Created by ChenDanny on 2016/3/24.
//  Copyright © 2016年 ChenDanny. All rights reserved.
//

import Foundation
import UIKit

class WTFlexibleCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!    
    
    func setData(response:WTResponse){
        self.titleLabel.text = response.name
        self.subtitleLabel.text = response.response

    }
    
}