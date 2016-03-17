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

extension MessageModel{
    
}
extension TextMessageModel{
    func toPackage(userId:String, peerId:String) -> AnyObject {
        var package = [String:AnyObject]()
        package["senderId"] = userId
        package["peerId"] = peerId
        package["uid"] = self.uid
        package["date"] = self.messageModel.date.timeIntervalSince1970/1000
        package["text"] = self.text

        return package
    }
}

public class WTChatMessageSender {
    let channel = WTSocketIOClient.sharedInstance
    
    var peerId:String
    var currentUserId:String
    
    init(peerId:String){
        self.peerId = peerId
        self.currentUserId = channel.currentUserId
    }
    public var onMessageChanged: ((message: MessageModelProtocol) -> Void)?
    
    public func sendMessages(messages: [MessageModelProtocol]) {
    }
    
    public func sendTextMessage(message:TextMessageModel){
        if channel.socket.status == .Connected{
            channel.emit("chat", message.toPackage(currentUserId, peerId: peerId))
            self.updateMessage(message, status: .Success)
        }
    }
    
    public func sendPhotoMessage(message:PhotoMessageModel){
        // TODO
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