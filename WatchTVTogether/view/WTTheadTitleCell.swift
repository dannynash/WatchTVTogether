//
//  WTTheadTitleCell.swift
//  WatchTVTogether
//
//  Created by dannynash on 2016/3/19.
//  Copyright © 2016年 ChenDanny. All rights reserved.
//

import Foundation
import UIKit

public enum WTThreadSource {
    case FB
    case PTT
}

class WTTheadTitleCell:UITableViewCell {
    
    @IBOutlet weak var sourceName: UILabel!
    @IBOutlet weak var responseNum: UILabel!
    
    func setData(source:WTThreadSource, responseNum:Int){
        
        if source == WTThreadSource.FB {
            self.sourceName.text = "臉書 好友"
        } else if source == WTThreadSource.PTT {
            self.sourceName.text = "PTT 鄉民"
        }
        
        self.responseNum.text = "\(responseNum)則"
    }
    
    
}