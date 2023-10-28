//
//  NetworkManager.swift
//  SendlerPhoto
//
//  Created by Vlad Kugan on 28.10.23.
//

import Foundation

class NetworkManager {
        
    typealias NetworkRequestCompletion = ([Welcome]?, Error?) -> Void
    
    func fetchData(completion: @escaping NetworkRequestCompletion) {
        guard let url = URL(string: "https://junior.balinasoft.com/api/v2/photo/type") else {
            completion(nil, NetworkError.invalidURL)
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            guard let data = data else {
                completion(nil, NetworkError.noData)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                do {
                    let decoder = JSONDecoder()
                    let responseData = try decoder.decode(Welcome.self, from: data)
                    completion([responseData], nil)
                    
                } catch {
                    completion(nil, NetworkError.invalidResponse)
                }
            } else {
                completion(nil, NetworkError.invalidResponseCode)
            }
        }
        task.resume()
    }
}
