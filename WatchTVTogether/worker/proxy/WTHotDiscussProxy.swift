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
    func fetchHotDiscuss(program:WTProgram, completion:(result:[WTThread]) -> Void)
    
}

struct WTDiscussProtocol {
    static let kProgram = ""
}

class WTHotDiscussWorker: WTHotDiscussProxy{
    
    func fetchHotDiscuss(program: WTProgram, completion: (result: [WTThread]) -> Void) {
        
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

    func fetchThreadResponse(thread: WTThread, completion: (result: [WTResponse]) -> Void) {
        
        let result = createThreadResponse()
        completion(result: result)
    }
    
    func createDiscusses(response:JSON) -> [WTThread]{
        var discusses = [WTThread]()
//        for program in response{
//            let discuss = WTHotDiscuss(response: program)
//            discusses.append(discuss)
//        }
        
        return discusses
    }
    
    func createThreadResponse() -> [WTResponse]{
        var reponses = [WTResponse]()
        
        for (var i=0; i<10; i++){
            reponses.append(WTResponse(name: "Danny", response: "這摸蝦也有人看，今北七欸", updateTime: 1458373404.449833, userPicture: UIImage(named: "d873967.jpg")))
        }
        
        return reponses
    }
    
    
}