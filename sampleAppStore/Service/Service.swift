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
    
    func fetchApps(searchTerm: String, completion: @escaping (SearchResult?, Error?) -> ()) {
        let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&entity=software"
        APIClient.shared.fetchGenerticJsonData(urlString: urlString, completion: completion)
    }
    
    func fetchGames(completion: @escaping (AppGroup?, Error?) -> ()) {
        let urlString: String = "https://rss.itunes.apple.com/api/v1/jp/ios-apps/new-games-we-love/all/50/explicit.json"
        APIClient.shared.fetchGenerticJsonData(urlString: urlString, completion: completion)
    }
    
    func fetchTopGrossing(completion: @escaping (AppGroup?, Error?) -> ()) {
        let urlString: String = "https://rss.itunes.apple.com/api/v1/jp/ios-apps/top-grossing/all/50/explicit.json"
        APIClient.shared.fetchGenerticJsonData(urlString: urlString, completion: completion)
    }
    
    func fetchAppsWeLove(completion: @escaping (AppGroup?, Error?) -> ()) {
        let urlString: String = "https://rss.itunes.apple.com/api/v1/jp/ios-apps/new-apps-we-love/all/50/explicit.json"
        APIClient.shared.fetchGenerticJsonData(urlString: urlString, completion: completion)
    }
    
    func fetchSocialApps(completion: @escaping ([SocialApp]?, Error?) -> Void) {
        let urlString: String = "https://api.letsbuildthatapp.com/appstore/social"
        APIClient.shared.fetchGenerticJsonData(urlString: urlString, completion: completion)
    }
    
    func fetchSearchResult(id: String, completion: @escaping (SearchResult?, Error?) -> Void) {
        let urlString: String = "https://itunes.apple.com/lookup?id=\(id)"
        APIClient.shared.fetchGenerticJsonData(urlString: urlString, completion: completion)
    }
}

