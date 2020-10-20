//
//  BankRegions.swift
//  TablePassData
//
//  Created by ramil on 09.10.2020.
//

import Foundation

enum Country: String, CaseIterable, Codable {
    case estonia
    case latvia
    case lithuania
    
    var name: String {
        switch self {
        case .estonia:
            return "Estonia"
        case .latvia:
            return "Latvia"
        case .lithuania:
            return "Lithuania"
        }
    }
}

