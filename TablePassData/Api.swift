//
//  Api.swift
//  TablePassData
//
//  Created by ramil on 16.10.2020.
//

import Foundation

struct Api {
    
    static func getBAvkPointsRequest(country: Country) -> Request<[BankPoint]> {
        
        return .init(url: country.url)
    }
}
