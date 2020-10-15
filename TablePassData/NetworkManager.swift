//
//  NetworkManager.swift
//  TablePassData
//
//  Created by ramil on 09.10.2020.
//

import Foundation

class Network {
    
    let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func getPosts(country: Country, url: URL, completion: @escaping ([BankPoint], Array<String>) -> ()) {
        
        session.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            
            let posts = try! JSONDecoder().decode([BankPoint].self, from: data)
            
            self.saveJsonFile(country.name, data: data)
            
            let regionList: Array<String> = self.getAllRegions(bankLocations: posts)
            
            DispatchQueue.main.async {
                completion(posts, regionList)
            }
        }.resume()
    }
    
    func getAllRegions(bankLocations: [BankPoint]) -> Array<String> {
        
        var allRegionsList = [String]()
        
        for bankLocation in bankLocations {
            if let region = bankLocation.r {
                allRegionsList.append(region)
            }
        }
        
        return Array(Set(allRegionsList)).sorted()
    }
    
    func saveJsonFile(_ name: String, data: Data) {
        guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileUrl = documentDirectoryUrl.appendingPathComponent(name + ".json")
        
        do {
            try data.write(to: fileUrl, options: .completeFileProtection)
        } catch {
            print(error)
        }
    }
    
    func retriveDataFromJsonFile(_ name: String, completion: @escaping ([BankPoint], Array<String>) ->()) {
        guard let documentsDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileUrl = documentsDirectoryUrl.appendingPathComponent(name + ".json")
        
        guard (FileManager.default.fileExists(atPath: fileUrl.path)) else { return }
        
        do {
            let data = try Data(contentsOf: fileUrl, options: [])
            let posts = try! JSONDecoder().decode([BankPoint].self, from: data)
            
            let regionList: Array<String> = self.getAllRegions(bankLocations: posts)
            
            DispatchQueue.main.async {
                completion(posts, regionList)
            }
            
        } catch {
            print(error.localizedDescription)
            return
        }
    }
}
