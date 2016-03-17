//
//  WTChatMessageFactory.swift
//  WatchTVTogether
//
//  Created by ChenDanny on 2016/3/11.
//  Copyright © 2016年 ChenDanny. All rights reserved.
//

import Foundation
import Chatto
import ChattoAdditions

extension Array {
    func randomItem() -> Element {
        let index = Int(arc4random_uniform(UInt32(self.count)))
        return self[index]
    }
}

func createTextMessageModel(uid: String, text: String, isIncoming: Bool) -> TextMessageModel {
    let messageModel = createMessageModel(uid, isIncoming: isIncoming, type: TextMessageModel.chatItemType)
    let textMessageModel = TextMessageModel(messageModel: messageModel, text: text)
    return textMessageModel
}

func createMessageModel(uid: String, isIncoming: Bool, type: String) -> MessageModel {
    let senderId = isIncoming ? "1" : "2"
    let messageStatus = isIncoming ? MessageStatus.Success : .Sending
    let messageModel = MessageModel(uid: uid, senderId: senderId, type: type, isIncoming: isIncoming, date: NSDate(), status: messageStatus)
    return messageModel
}

func createPhotoMessageModel(uid: String, image: UIImage, size: CGSize, isIncoming: Bool) -> PhotoMessageModel {
    let messageModel = createMessageModel(uid, isIncoming: isIncoming, type: PhotoMessageModel.chatItemType)
    let photoMessageModel = PhotoMessageModel(messageModel: messageModel, imageSize:size, image: image)
    return photoMessageModel
}


extension TextMessageModel {
    static var chatItemType: ChatItemType {
        return "text"
    }
}

extension PhotoMessageModel {
    static var chatItemType: ChatItemType {
        return "photo"
    }
}
