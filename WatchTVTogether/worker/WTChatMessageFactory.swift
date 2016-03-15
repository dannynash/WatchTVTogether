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



//class WTMessageFactory {
//    class func createChatItem(uid: String) -> MessageModelProtocol {
//        let isIncoming: Bool = arc4random_uniform(100) % 2 == 0
//        return self.createChatItem(uid, isIncoming: isIncoming)
//    }
//    
//    class func createChatItem(uid: String, isIncoming: Bool) -> MessageModelProtocol {
//        if arc4random_uniform(100) % 2 == 0 {
//            return self.createTextMessageModel(uid, isIncoming: isIncoming)
//        } else {
//            return self.createPhotoMessageModel(uid, isIncoming: isIncoming)
//        }
//    }
//    
//    class func createTextMessageModel(uid: String, isIncoming: Bool) -> TextMessageModel {
//        let incomingText: String = isIncoming ? "incoming" : "outgoing"
//        let maxText = self.demoTexts.randomItem()
//        let length: Int = 10 + Int(arc4random_uniform(300))
//        let text = "\(maxText.substringToIndex(maxText.startIndex.advancedBy(length))) incoming:\(incomingText), #:\(uid)"
//        return ChattoApp.createTextMessageModel(uid, text: text, isIncoming: isIncoming)
//    }
//    class func createPhotoMessageModel(uid: String, isIncoming: Bool) -> PhotoMessageModel {
//        var imageSize = CGSize.zero
//        switch arc4random_uniform(100) % 3 {
//        case 0:
//            imageSize = CGSize(width: 400, height: 300)
//        case 1:
//            imageSize = CGSize(width: 300, height: 400)
//        case 2:
//            fallthrough
//        default:
//            imageSize = CGSize(width: 300, height: 300)
//        }
//        
//        var imageName: String
//        switch arc4random_uniform(100) % 3 {
//        case 0:
//            imageName = "pic-test-1"
//        case 1:
//            imageName = "pic-test-2"
//        case 2:
//            fallthrough
//        default:
//            imageName = "pic-test-3"
//        }
//        return ChattoApp.createPhotoMessageModel(uid, image: UIImage(named: imageName)!, size: imageSize, isIncoming: isIncoming)
//    }
//
//}

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
