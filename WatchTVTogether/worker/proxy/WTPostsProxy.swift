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
    
    func fetchPosts(completion: (result: [WTPost]) -> Void) {
        let qUrl = "\(WTServerConfig.kServerUrl)popular"
        
        Alamofire.request(.GET, qUrl).responseJSON { response in
            
            print(response.request)  // original URL request
            print(response.response) // URL response
            print(response.data)     // server data
            print(response.result)   // result of response serialization
            
            if let value = response.result.value {
                let json = JSON(value)
                print(json["posts"])
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
            return posts
        }
        
        func createRespones(res:JSON) -> [WTResponse]{
            var responses = [WTResponse]()
            for (index,res):(String, JSON) in res {
                let time = WTTimeUtility.shareInstance.timeIntervalWithServerTime(res["comment_time"].intValue)
                let response = WTResponse(name: res["name"].stringValue, response: res["content"].stringValue, updateTime: time)
                
                responses.append(response)
            }
            return responses
        }
        
        

        
        
    }
    
}