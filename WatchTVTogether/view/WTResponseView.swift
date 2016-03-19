//
//  WTResponseView.swift
//  WatchTVTogether
//
//  Created by ChenDanny on 2016/3/18.
//  Copyright © 2016年 ChenDanny. All rights reserved.
//

import Foundation
import UIKit

class WTResponseView:UITableViewCell{

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var responseLabel: UILabel!

    func setData(name:String, response:String){
        self.nameLabel.text = "\(name):"
        self.responseLabel.text = response
    }
    
}