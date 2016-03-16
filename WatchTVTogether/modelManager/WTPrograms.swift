//
//  WTPrograms.swift
//  WatchTVTogether
//
//  Created by ChenDanny on 2016/3/16.
//  Copyright © 2016年 ChenDanny. All rights reserved.
//

import Foundation

class WTPrograms {
    
    var programs = [String:WTProgram]()
    
    func nameWithId(programId:String) -> String?{
        let program = programs[programId]
        
        return program?.programName
   }
    

    
}