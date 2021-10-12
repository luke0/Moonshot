//
//  bundle-decodable.swift
//  Moonshot
//
//  Created by Luke Inger on 08/10/2021.
//

import Foundation

extension Bundle {
    
    func decode<T: Codable>(_ file: String) -> T {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Unable to locate \(file) from bundle")
        }
        
        guard let data = try? Data(contentsOf: url) else {
             fatalError("Unable to load \(file) from bundle")
        }
        
        let decoder = JSONDecoder()
        let formatter = DateFormatter()
        formatter.dateFormat = "y-MM-dd"
        decoder.dateDecodingStrategy = .formatted(formatter)
        
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode data from bundle")
        }
        
        return loaded
    }
    
}
