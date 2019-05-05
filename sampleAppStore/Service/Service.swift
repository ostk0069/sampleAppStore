//
//  Service.swift
//  sampleAppStore
//
//  Created by Takuma Osada on 2019/05/04.
//  Copyright © 2019 Takuma Osada. All rights reserved.
//

import Foundation

class Service {
    static let shared = Service()
    
    func fetchApps(searchTerm: String, completion: @escaping ([Result], Error?) -> ()) {
        guard let url = URL(string: "https://itunes.apple.com/search?term=\(searchTerm)&entity=software") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("failed tp fetch apps:", error)
                completion([], nil)
                return
            }
            guard let data = data else {
                return
            }
            do {
                let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
                
                completion(searchResult.results, nil)
                
            } catch let jsonError {
                print("failed to decode json:", jsonError)
                completion([], jsonError)
            }
            }.resume()
    }
    
    func fetchGames(completion: @escaping (AppGroup?, Error?) -> ()) {
        let urlString: String = "https://rss.itunes.apple.com/api/v1/jp/ios-apps/new-games-we-love/all/50/explicit.json"
        fetchAppGroup(urlString: urlString, completion: completion)
    }
    
    func fetchTopGrossing(completion: @escaping (AppGroup?, Error?) -> ()) {
        let urlString: String = "https://rss.itunes.apple.com/api/v1/jp/ios-apps/top-grossing/all/50/explicit.json"
        fetchAppGroup(urlString: urlString, completion: completion)
    }
    
    func fetchAppsWeLove(completion: @escaping (AppGroup?, Error?) -> ()) {
        let urlString: String = "https://rss.itunes.apple.com/api/v1/jp/ios-apps/new-apps-we-love/all/50/explicit.json"
        fetchAppGroup(urlString: urlString, completion: completion)
    }
    
    func fetchAppGroup(urlString: String, completion: @escaping (AppGroup?, Error?) -> Void) {
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if let error = error {
                completion(nil, error)
                return
            }
            
            do {
                let appGroup = try JSONDecoder().decode(AppGroup.self, from: data!)
                completion(appGroup, nil)
            } catch {
                completion(nil, error)
                print("failed to decode:", error)
            }
            }.resume()
    }
}
