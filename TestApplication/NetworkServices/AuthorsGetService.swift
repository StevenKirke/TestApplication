//
//  AuthorsGetService.swift
//  TestApplication
//
//  Created by JARVIS on 02.11.2020.
//

import Foundation

class AuthorsGetService {
    func get(firstName: String?, lastName: String?, complition: @escaping (Result<Authors, Error>) -> Void) {
        let urlString = "https://reststop.randomhouse.com/resources/authors"
        var urlComponents = URLComponents(string: urlString)
        urlComponents?.queryItems = [
            //URLQueryItem(name: "firstName", value: firstName),
            URLQueryItem(name: "lastName", value: lastName)
        ]
        
        guard let url = urlComponents?.url else {
            return
        }
        var request = URLRequest(url: url)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")  // the request is JSON
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Accept")        // the expected response is also JSON
        request.httpMethod = "GET"
        //print(url.absoluteString)
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                complition(.failure(error))
                return
            }
            guard let data = data else {
                print("Wrong data")
                return
            }
            //print(String(data: data, encoding: .utf8))
            let decode = JSONDecoder()
            do {
                let result = try decode.decode(Authors.self, from: data)
                DispatchQueue.main.async {
                    complition(.success(result))
                }
            } catch {
                complition(.failure(error))
                print("Print error - \(error.localizedDescription)")
            }
        }
        task.resume()
    }
    
}

