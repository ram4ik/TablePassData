//
//  BankLocations.swift
//  TablePassData
//
//  Created by ramil on 09.10.2020.
//

import Foundation

struct BankPoint: Codable {
    
    let t: Int
    let n, a: String
    let av, r: String?
    static let ncash: Bool = false
    let lat, lon: Double
    let i: String?
    static let cs: Bool = false
}
