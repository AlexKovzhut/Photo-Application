//
//  NetworkDataFetcher.swift
//  Photo Application
//
//  Created by Alexander Kovzhut on 07.12.2021.
//

import Foundation

class NetworkDataFetcher {
    
    var networkService = NetworkService()
    
    func getPhotos(searchTerm: String, completion: @escaping (SearchResults?) -> ()) {
        networkService.request(searchTerm: searchTerm) { data, error in
            if let error = error {
                print("Error received requesting data: \(error.localizedDescription)")
                completion(nil)
            }
            
            let decode = self.decodeJSON(type: SearchResults.self, from: data)
            completion(decode)
        }
    }
    
    func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
        let decoder = JSONDecoder()
        guard let data = from else {
            return nil
        }
        
        do {
            let objects = try decoder.decode(type.self, from: data)
            return objects
        } catch let errorJSON {
            print("Failed to decode JSON", errorJSON)
            return nil
        }
    }
}
