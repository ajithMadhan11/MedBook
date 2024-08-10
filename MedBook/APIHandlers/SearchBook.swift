//
//  SearchBook.swift
//  MedBook
//
//  Created by Ajithmadhan Krishnamoorthy on 10/08/24.
//

import Foundation

struct BookDetail: Codable {
    var title: String?
    var cover_i: Int64?
    var ratings_average: Double?
    var ratings_count: Int64?
    var author_name: [String]?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decodeIfPresent(String.self, forKey: .title)
        self.cover_i = try container.decodeIfPresent(Int64.self, forKey: .cover_i)
        self.ratings_average = try container.decodeIfPresent(Double.self, forKey: .ratings_average)
        self.ratings_count = try container.decodeIfPresent(Int64.self, forKey: .ratings_count)
        self.author_name = try container.decodeIfPresent([String].self, forKey: .author_name)
    }
    
}

struct BookResponse: Codable {
    var numFound: Int
    var docs: [BookDetail]
}


class searchBookController: BaseNetworkHandler<BookResponse> {
    
    func searchBook(title: String, limit: Int, offset: Int, completion: @escaping (Result<BookResponse, MError>) -> Void) {
        let path = APIEndpoints.searchBook.rawValue
        
        let parameters = ["title": title, "limit": "\(limit)", "offset": "\(offset)"]
        
        self.execute(path, method: .get, parameters: parameters, completion: completion)
    }
    
}
