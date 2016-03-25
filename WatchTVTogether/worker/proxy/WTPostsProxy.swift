//
//  WTPostsProxy.swift
//  WatchTVTogether
//
//  Created by dannynash on 2016/3/19.
//  Copyright © 2016年 ChenDanny. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class WTPostsProxy{
    static let shareInstance = WTPostsProxy()
    
    func fetchPosts(completion: (result: [WTPost]) -> Void) {
        let queryUrl = "\(WTServerConfig.kServerUrl)\(WTServerConfig.kQueryPosts)"
        
        Alamofire.request(.GET, queryUrl).responseJSON { [weak self] response in

            guard self != nil else {
                completion(result: Array<WTPost>())
                return
            }

            guard response.response?.statusCode == 200 else{
                let posts = self!.createFakeData()
                completion(result: posts)
                return
            }
            
            if let value = response.result.value {
                let json = JSON(value)
                let posts = self!.createPosts(json["posts"])
                completion(result: posts)
            }
        }
    }
    
    func createPosts(data:JSON) -> [WTPost]{
        var posts = [WTPost]()
        for (index,subJson):(String, JSON) in data {
            //Do something you want
            let program = WTProgram(programId: subJson["program"]["id"].stringValue, programName: subJson["program"]["programName"].stringValue, channelName: subJson["program"]["channelName"].stringValue, pictureUrl:subJson["program"]["picture"].stringValue)
            let reponses = createRespones(subJson["lastResponse"])
            
            let time = WTTimeUtility.shareInstance.timeIntervalWithServerTime(subJson["lastUpdateTime"].intValue)

            let post = WTPost(program: program, responseNums: subJson["responseNum"].intValue, lastResponse: reponses, lastUpdateTime: time)
            
            posts.append(post)
        }
        
        posts.sortInPlace { (a, b) -> Bool in
            return a.responseNums > b.responseNums
        }
        return posts
    }
    
    func createRespones(res:JSON) -> [WTResponse]{
        var responses = [WTResponse]()
        for (index,res):(String, JSON) in res {
            let time = WTTimeUtility.shareInstance.timeIntervalWithServerTime(res["comment_time"].intValue)
            let response = WTResponse(name: res["user"].stringValue, response: res["content"].stringValue, updateTime: time)
            
            responses.append(response)
        }
        return responses
    }
    
    func createFakeData() -> [WTPost]{
        let program1 = WTProgram(programId: "1", programName: "一把青", channelName: "公視")
        let responses = [WTResponse(name: "danny", response: "HiHi")]
        
        let post = WTPost(program: program1, responseNums: 759, lastResponse: responses, lastUpdateTime: 1458537996.875392)
        
        return [post]
    }
    
}
