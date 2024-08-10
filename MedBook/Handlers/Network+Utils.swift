//
//  Network+Utils.swift
//  MedBook
//
//  Created by Ajithmadhan Krishnamoorthy on 09/08/24.
//

import Foundation

enum MHTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

enum MError: Error {
    case NetworkError
    case RequestFailed
    case ParserError
    case DomainError(DomainError)
}

enum DomainError {
    
}

extension URL {
    mutating func appendQueryItem(name: String, value: String) {
        guard var urlComponents = URLComponents(string: absoluteString) else { return }
        var queryItems: [URLQueryItem] = urlComponents.queryItems ??  []
        let queryItem = URLQueryItem(name: name, value: value)
        queryItems.append(queryItem)
        urlComponents.queryItems = queryItems
        self = urlComponents.url!
    }
}
