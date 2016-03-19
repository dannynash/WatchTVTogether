//
//  WTImageProxy.swift
//  WatchTVTogether
//
//  Created by dannynash on 2016/3/19.
//  Copyright © 2016年 ChenDanny. All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SwiftyJSON

class WTImageProxy:BaseProxy{
    func fetchImage(url:String, completion:(result:UIImage) -> Void){
        let qUrl = "\(WTServerConfig.kServerUrl)url"

        Alamofire.request(.GET, qUrl).responseJSON { response in
            if response.response?.statusCode == 200 {
                let image = UIImage(data: response.data!, scale:1)
                completion(result: image!)
            }
        }
        
    }
    
}