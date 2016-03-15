//
//  AFPUploadManager.h
//  AFPDetectLibrary
//
//  Created by Ulyness Chen on 11/2/15.
//  Copyright © 2015 III_SNSI. All rights reserved.
//

#import <Foundation/Foundation.h>

//! @brief 錄音上傳結果通知用的block格式。參數意義參考說明文件
typedef void(^ACRUploadCompletedHandler)(BOOL isCompleted, NSArray *uploadedRecordInfo);

@interface AFPUploadManager : NSObject
//! @brief 初始化
- (instancetype)initWithAPIKey:(NSString *)APIKey uploadCompletedHandler:(ACRUploadCompletedHandler)uploadCompletedHandler;
//! @brief 取得目前保存的錄音的資料
- (NSArray *)getRecordList;
//! @brief 要求上傳最新的錄音
- (void)uploadLastRecord;
//! @brief 指定要求上傳數筆錄音
- (void)uploadRecordsWithFilenames:(NSArray *)filenames;
//! @brief 是否有指定上傳但尚未上傳成功的錄音
- (BOOL)hasUnfinishedUpload;
//! @brief 立刻上傳被指定上傳但尚未上傳成功的錄音
- (void)triggerUploadNow;

@end
