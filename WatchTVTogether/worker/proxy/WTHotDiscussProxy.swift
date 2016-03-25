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
        
        
        let threads = self.createFakeThreads()
        completion(result: threads)
        return
        
//        let queryUrl = "\(WTServerConfig.kServerUrl)\(WTServerConfig.kQueryThreads)\(program.programId)"
//        Alamofire.request(.GET, queryUrl)
//            .responseJSON { [weak self] response in
//                
//                guard self != nil else {
//                    completion(result: Array<WTThread>())
//                    return
//                }
//                guard response.response?.statusCode == 200 else{
//                    let threads = self!.createFakeThreads()
//                    completion(result: threads)
//                    return
//                }
//
//                if let value = response.result.value {
//                    let json = JSON(value)
//                    let threads = self!.createDiscusses(json["threads"])
//                    completion(result: threads)
//                }
//        }
    }
    
    func createFakeThreads() -> [WTThread]{
        let thread = WTThread(threadId: "1", source: WTThreadSource.PTT, url: "", responseNum: 799, lastResponse: [WTResponse](), lastUpdateTime: 1458537996.875392)
        
        return [thread]
    }

    func fetchThreadResponse(thread: WTThread, completion: (result: [WTResponse]) -> Void) {
        
        
        let responeses = self.createFakeThreadResponse()
        completion(result: responeses)
        return

//        let queryUrl = "\(WTServerConfig.kServerUrl)\(WTServerConfig.kQueryDetailCommentPost)\(thread.threadId)/\(WTServerConfig.kQueryDetailComment)"
//        
//        Alamofire.request(.GET, queryUrl)
//            .responseJSON { response in
//                
//            if let value = response.result.value {
//                let json = JSON(value)
//                let threads = self.createThreadResponse(json["comments"])
//                completion(result: threads)
//            }
//        }

    }
    func createFakeThreadResponse() -> [WTResponse]{
        var responeses = Array<WTResponse>()
        let response1 = WTResponse(name: "danny", response: "shortResponse")
        let response2 = WTResponse(name: "danny", response: "longResponselongResponselongResponselongResponselongResponselongResponselongResponselongResponselongResponselongResponselongResponselongResponselongResponselongResponselongResponselongResponselongResponse")
        
        responeses.append(response1)
        responeses.append(response2)
        
        return responeses
    }
    
    func createDiscusses(threads:JSON) -> [WTThread]{
        var discusses = [WTThread]()
        
        for (index,thread):(String, JSON) in threads {
            var s:WTThreadSource
            
            if thread["source"].stringValue == "fb" {
                s = WTThreadSource.FB
            } else if thread["source"].stringValue == "ptt" {
                s = WTThreadSource.PTT
            } else {
                s = WTThreadSource.PTT
            }
            
            let time = WTTimeUtility.shareInstance.timeIntervalWithServerTime(thread["lastUpdateTime"].intValue)
            let responses = createRespones(thread["lastResponse"])
            
            let threadObject = WTThread(threadId:thread["threadId"].stringValue, source: s, url: "", responseNum: thread["responseNum"].intValue, lastResponse: responses, lastUpdateTime: time)
            
            discusses.append(threadObject)
        }
        
        return discusses
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

    func createThreadResponse(comments:JSON) -> [WTResponse]{
        var reponses = [WTResponse]()
        
        for (index,comment):(String, JSON) in comments {
            let time = self.mongodbDateFormatter(comment["comment_time"].stringValue).timeIntervalSince1970
            let response = WTResponse(name: comment["user"].stringValue, response: comment["content"].stringValue, updateTime: time)
            reponses.append(response)
        }
        
        return reponses
    }
    
    
    func mongodbDateFormatter(rawDate:String) -> NSDate {
        let formatter = NSDateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        if let parsedDate = formatter.dateFromString(rawDate) {
            return parsedDate
        }
        // you can handle as you wish
        return NSDate()
    }

    
    
}