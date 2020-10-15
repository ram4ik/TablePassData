//
//  NetworkRequest.swift
//  TablePassData
//
//  Created by ramil on 15.10.2020.
//

import Foundation

extension Country {
    var url: URL {
        switch self {
        case .estonia:
            return URL(string: "https://www.swedbank.ee/finder.json")!
        case .latvia:
            return URL(string: "https://ib.swedbank.lv/finder.json")!
        case .lithuania:
            return URL(string: "https://ib.swedbank.lt/finder.json")!
        }
    }
}
