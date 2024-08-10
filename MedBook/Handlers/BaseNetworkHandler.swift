//
//  BaseNetworkHandler.swift
//  MedBook
//
//  Created by Ajithmadhan Krishnamoorthy on 09/08/24.
//

import Foundation



class BaseNetworkHandler <T: Codable> {
    
    typealias Completion = (Result<T, MError>) -> Void
    
    var currentTask: URLSessionDataTask?
    
    func execute(_ path: String, method: MHTTPMethod, parameters: [String: Any]? = nil, completion: @escaping Completion) {
        
        guard var url = URL(string: path) else {
            return
        }
        
        if let parameters = parameters {
            for param in parameters {
                url.appendQueryItem(name: param.key, value: "\(param.value)")
            }
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = method.rawValue
        
        currentTask?.cancel()
        
        currentTask = URLSession.shared.dataTask(with: request) { (data, response, error) in
            self.currentTask = nil
            if error != nil {
                print("Error in error")
                // we can have some retry logics here
                completion(.failure(MError.RequestFailed))
                return
            }
            
            guard response is HTTPURLResponse else {
                print("Error in response")
                //Instead of propagating this issue we can handle this in common place
                completion(.failure(MError.RequestFailed))
                return
            }
            
            guard let data = data else {
                print("Error in data")
                completion(.failure(MError.ParserError))
                return
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(T.self, from: data)
                print("\n 🛜\(decodedResponse)")
                // some common cases can be handled here like no user, blocked...
                completion(.success(decodedResponse))
                
            } catch {
                print("Error in catch")
                completion(.failure(MError.ParserError))
            }
        }
        currentTask?.resume()
    }
}
