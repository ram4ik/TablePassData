//
//  Request.swift
//  TablePassData
//
//  Created by ramil on 16.10.2020.
//

import Foundation

class Request<Response: Decodable> {
    
    var request: URLRequest
    
    init(url: URL) {
        
        self.request = URLRequest(url: url)
        self.request.setValue("iphone-app", forHTTPHeaderField: "Swedbank-Embedded")
    }
}
