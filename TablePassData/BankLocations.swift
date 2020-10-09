//
//  BankLocations.swift
//  TablePassData
//
//  Created by ramil on 09.10.2020.
//

import Foundation

struct BankLocations: Codable, Identifiable {
    let id = UUID()
    let t: Int
    let n, a: String
    let av, r: String?
    let ncash: Bool?
    let lat, lon: Double
    let i: String?
    let cs: Bool?
}
