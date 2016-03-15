//
//  WTChatMessageSender.swift
//  WatchTVTogether
//
//  Created by ChenDanny on 2016/3/11.
//  Copyright © 2016年 ChenDanny. All rights reserved.
//

import Foundation
import Chatto
import ChattoAdditions

public class WTChatMessageSender {
    let channel = WTSocketIOClient()
    
    public var onMessageChanged: ((message: MessageModelProtocol) -> Void)?
    
    public func sendMessages(messages: [MessageModelProtocol]) {
        for message in messages {
            self.fakeMessageStatus(message)
        }
    }
    
    public func sendMessage(message: MessageModelProtocol) {
//        channel.emit("", message.)
        self.fakeMessageStatus(message)
        
        let test = message as! TextMessageModel
        print("test", test)
    }
    
    private func fakeMessageStatus(message: MessageModelProtocol) {
        switch message.status {
        case .Success:
            break
        case .Failed:
            self.updateMessage(message, status: .Sending)
            self.fakeMessageStatus(message)
        case .Sending:
            
            print("")
            
//            switch arc4random_uniform(100) % 5 {
//            case 0:
//                if arc4random_uniform(100) % 2 == 0 {
//                    self.updateMessage(message, status: .Failed)
//                } else {
//                    self.updateMessage(message, status: .Success)
//                }
//            default:
//                let delaySeconds: Double = Double(arc4random_uniform(1200)) / 1000.0
//                let delayTime = dispatch_time(DISPATCH_TIME_NOW, Int64(delaySeconds * Double(NSEC_PER_SEC)))
//                dispatch_after(delayTime, dispatch_get_main_queue()) {
//                    self.fakeMessageStatus(message)
//                }
//            }
        }
    }
    
    private func updateMessage(message: MessageModelProtocol, status: MessageStatus) {
        if message.status != status {
            message.status = status
            self.notifyMessageChanged(message)
        }
    }
    
    private func notifyMessageChanged(message: MessageModelProtocol) {
        self.onMessageChanged?(message: message)
    }

}