//
//  DecodeJSON.swift
//  Affirmation
//
//  Created by Michael & Diana Pascucci on 3/6/22.
//

import Foundation

extension Bundle {
    
    func decode<T: Codable>(_ file: String) -> T {
        
        // Does the file exist
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in bundle.")
        }
        
        // Can the file be loaded
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to load \(file) from bundle.")
        }
 
        // Set up the decoder
        let decoder = JSONDecoder()
        
        // Can the file be decoded
        guard let loaded = try? decoder.decode(T.self, from: data) else {
            fatalError("Failed to decode \(file) from bundle.")
        }
        
        // Return the data
        return loaded
    }
}
