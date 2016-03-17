//
//  WTHotDiscussProxy.swift
//  WatchTVTogether
//
//  Created by ChenDanny on 2016/3/17.
//  Copyright © 2016年 ChenDanny. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

protocol WTHotDiscussProxy{
    func fetchHotDiscuss(program:WTProgram, completion:(result:[WTHotDiscuss]) -> Void)
    
}

struct WTDiscussProtocol {
    static let kProgram = ""
}

class WTHotDiscussWorker: WTHotDiscussProxy{
    
    func fetchHotDiscuss(program: WTProgram, completion: (result: [WTHotDiscuss]) -> Void) {
        
        Alamofire.request(.GET,WTServerConfig.kQueryHotDiscussUrl, parameters: [WTDiscussProtocol.kProgram: program.programId as AnyObject])
            .responseJSON { response in
                print(response.request)  // original URL request
                print(response.response) // URL response
                print(response.data)     // server data
                print(response.result)   // result of response serialization
                
                if let value = response.result.value {
                    let json = JSON(value)
                    let discusses = self.createDiscusses(json)
                    completion(result: discusses)
                }
        }
    }


    func createDiscusses(response:JSON) -> [WTHotDiscuss]{
        var discusses = [WTHotDiscuss]()
//        for program in response{
//            let discuss = WTHotDiscuss(response: program)
//            discusses.append(discuss)
//        }
        
        return discusses
    }
    
}