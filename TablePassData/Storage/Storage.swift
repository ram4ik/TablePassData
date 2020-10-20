//
//  Storage.swift
//  TablePassData
//
//  Created by ramil on 20.10.2020.
//

import Foundation

class Storage {
    
    let defaults = UserDefaults.standard
    let savedSectionsKey = "SavedSections"
    
    func saveData(sections: [Section]) {
        let encoder = JSONEncoder()
        
        if let sectionsToSave = try? encoder.encode(sections) {
            defaults.set(sectionsToSave, forKey: savedSectionsKey)
        }
    }
    
    func loadData(completion: @escaping ([Section]) -> ()) {
        let decoder = JSONDecoder()
        
        if let savedSections = defaults.object(forKey: savedSectionsKey) as? Data {
            
            if let loadedSections = try? decoder.decode([Section].self, from: savedSections) {
                
                completion(loadedSections)
            }
        }
    }
}
