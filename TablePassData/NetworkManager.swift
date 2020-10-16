//
//  NetworkManager.swift
//  TablePassData
//
//  Created by ramil on 09.10.2020.
//

import Foundation

class Network {
    
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    enum NetworkError: Error {
        case unexpected(statusCode: Int)
        case unexpected(response: URLResponse?)
    }
    
    func getPosts<T: Decodable>(_ request: Request<T>,
                                httpCodes: ClosedRange<Int> = 200...201,
                                completion: @escaping (Result<T, Error>) -> Void) {
        
        session.dataTask(with: request.request) { data, response, error in
            
            guard error == nil else {
                return completion(.failure(error!))
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                return completion(.failure(NetworkError.unexpected(response: response)))
            }
            
            guard httpCodes ~= httpResponse.statusCode else {
                return completion(.failure(NetworkError.unexpected(statusCode: httpResponse.statusCode)))
            }
            
            do {
                let obj = try JSONDecoder().decode(T.self, from: data ?? Data())
                completion(.success(obj))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
}
