//
//  NetworkDataFetcher.swift
//  TestApplication
//
//  Created by JARVIS on 02.11.2020.
//

import Foundation

class NetworkDataFetcher {
    
    var networkService = NetworkService()
    
    init(networkService: NetworkService = NetworkService()) {
        self.networkService = networkService
    }
    
    func fetcherAuthor(lastName: String?, complition: @escaping (Authors?) -> Void) {
        let urlString = "https://reststop.randomhouse.com/resources/authors"
        networkService.request(urlString: urlString, lastName: lastName) { (data, error) in
            let decode = JSONDecoder()
            guard let data = data else {
                return
            }
            do {
                let result = try? decode.decode(Authors.self, from: data)
                complition(result)
            }
        }
    }
}

