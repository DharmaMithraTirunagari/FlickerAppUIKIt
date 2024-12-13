//
//  NetworkManager.swift
//  FlickerAppUIKIt
//
//  Created by Srikanth Kyatham on 12/12/24.
//


import Foundation
class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetch<T: Decodable>(searchTerm: String? = nil) async throws -> T {

        let query = (searchTerm ?? "").replacingOccurrences(of: " ", with: ",")
        let urlString = "\(ServerConstants.baseURL)\(ServerConstants.Endpoints.publicPhotos)?format=json&nojsoncallback=1&tags=\(query)"
 
        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        do {
            let decoder = JSONDecoder()
            let result = try decoder.decode(T.self, from: data)
            return result
        } catch {
            print("Decoding Error: \(error)")
            throw NetworkError.decodingError
        }
    }
}
