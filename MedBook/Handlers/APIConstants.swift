//
//  APIConstants.swift
//  MedBook
//
//  Created by Ajithmadhan Krishnamoorthy on 09/08/24.
//

import Foundation

enum APIEndpoints: String {
    case countries = "https://api.first.org/data/v1/countries?limit=249"
    case currentCountry = "http://ip-api.com/json"
    case searchBook = "https://openlibrary.org/search.json"
}
