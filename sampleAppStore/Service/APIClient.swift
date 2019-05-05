//
//  APIClient.swift
//  sampleAppStore
//
//  Created by Takuma Osada on 2019/05/05.
//  Copyright © 2019 Takuma Osada. All rights reserved.
//

import Foundation

class APIClient {
    
    static let shared = APIClient()
    
    func fetchGenerticJsonData<T: Decodable>(urlString: String, completion: @escaping (T?, Error?) -> Void) {
        
        guard let url = URL(string: urlString) else {
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                completion(nil, error)
                return
            }
            
            do {
                let object = try JSONDecoder().decode(T.self, from: data!)
                completion(object, nil)
            } catch {
                completion(nil, error)
                print("failed to decode:", error)
            }
        }.resume()
    }
}
