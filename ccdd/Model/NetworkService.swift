//
//  NetworkService.swift
//  ccdd
//
//  Created by Zakirov Tahir on 14.11.2021.
//

import Foundation

enum NetworkError: Error {
    case transportError(Error)
    case serverError(statusCode: Int)
    case noData
    case decodingError(Error)
    case encodingError(Error)
}

class NetworkService {
    
    static let shared = NetworkService()
    
    func fetchData<T: Decodable>(urlString: String, completion: @escaping (T?, NetworkError?) -> ()) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(nil, .transportError(error))
            }
            
            guard let data = data else { return }
            
            if let response = response as? HTTPURLResponse, !(200...299).contains(response.statusCode) {
                completion(nil, .serverError(statusCode: response.statusCode))
                return
            }
            
            do {
                let objects = try JSONDecoder().decode(T.self, from: data)
                completion(objects, nil)
            } catch {
                completion(nil, .decodingError(error))
                print("Failed to decode:", error)
            }
            
        }.resume()
    }
    
}
