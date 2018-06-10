//
//  Global.swift
//  sva1
//
//  Created by Benjamin Levine on 5/19/18.
//  Copyright © 2018 scoring app code. All rights reserved.
//

import Foundation

class Global {
    
    static let shared = Global()
    private init() {
        
        formatter.dateFormat = "MMddYYYY"
        
    }
    
    let formatter = DateFormatter()
    var currentDate : String {
        return formatter.string(from: Date())
    }
    
}
