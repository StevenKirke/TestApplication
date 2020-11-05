//
//  NetworkService.swift
//  TestApplication
//
//  Created by JARVIS on 02.11.2020.
//

import Foundation

class NetworkService {
    
    func request(urlString: String, lastName: String?, completion: @escaping (Data?, Error?) -> Void) {
        let name = lastName?.trimmingCharacters(in: .whitespaces)
        let headers: [String : Any] = [
            "Content-Type": "application/json; charset=utf-8",
            "Accept": "application/json; charset=utf-8"
        ]
        var urlComponents = URLComponents(string: urlString)
        urlComponents?.queryItems = [
            URLQueryItem(name: "lastName", value: name)
        ]
        guard let url = urlComponents?.url else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        guard headers is [String: String] else { return }
        for (key, value) in headers {
            request.setValue("\(value)", forHTTPHeaderField: "\(key)")
        }
        
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
        return URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                completion(data, error)
            }
        }
    }
}
