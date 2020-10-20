//
//  Region.swift
//  TablePassData
//
//  Created by ramil on 16.10.2020.
//

import Foundation

class Region: Codable {
    
    let name: String
    var points: [BankPoint]
    
    init(name: String, points: [BankPoint] = []) {
        self.name = name
        self.points = points
    }
}
