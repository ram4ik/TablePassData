//
//  Utils.swift
//  TablePassData
//
//  Created by Ramill Ibragimov on 17.10.2020.
//

import Foundation

class Utils {
    
    func getDateDiff(start: Date, end: Date) -> Int  {
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([Calendar.Component.hour], from: start, to: end)

        let hour = dateComponents.hour
        return Int(hour!)
    }
}
