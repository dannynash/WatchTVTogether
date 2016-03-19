//
//  WatchTVTogetherTests.swift
//  WatchTVTogetherTests
//
//  Created by ChenDanny on 2016/3/10.
//  Copyright © 2016年 ChenDanny. All rights reserved.
//

import XCTest
//@testable import WatchTVTogether
//import WatchTVTogether

class WatchTVTogetherTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
    func testTime(){
        let sec = NSTimeInterval(50)
        XCTAssertEqual(getResponseTime(sec), "50秒前", "secs failed")
    }
    
    func getResponseTime(timestamp:NSTimeInterval) -> String{
        let now = NSDate().timeIntervalSince1970
        let offset = now - timestamp
        
        if (offset < 60){
            // sec
            return "\(Int(offset))秒前"
        } else if (offset < 3600){
            // min
            let min = offset/60.0
            return "\(Int(min))分鐘前"
            
        } else if (offset < 86400){
            // hour
            let min = offset/3600
            return "\(Int(min))小時前"
            
        } else {
            return ""
        }
    }

}
