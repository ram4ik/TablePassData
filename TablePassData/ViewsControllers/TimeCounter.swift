//
//  TimeCounter.swift
//  TablePassData
//
//  Created by Ramill Ibragimov on 17.10.2020.
//

import Foundation

class TimeCounter {
    
    let key = "startTime"
    let currentTime = Date()
    let app = UserDefaults.standard
    let utils = Utils()
    
    func canRefresh() -> Bool {
        var result = true
        if let startTime = app.object(forKey: key) as? Date {
            if (utils.getDateDiff(start: startTime, end: currentTime) > 0) {
                result = true
            } else {
                result = false
            }
        } else {
            saveCurrentTime()
        }
        return result
    }
    
    func saveCurrentTime() {
        app.set(currentTime, forKey: key)
    }
}
