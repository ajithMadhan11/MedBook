//
//  GetCountriesList.swift
//  MedBook
//
//  Created by Ajithmadhan Krishnamoorthy on 09/08/24.
//

import Foundation

struct Countries: Codable {
    let status: String
    let data: [String: Country]
}

struct Country: Codable {
    let country: String
}

class GetCountriesListController: BaseNetworkHandler<Countries> {
    
    func getCountries(completion: @escaping (Result<Countries, MError>) -> Void) {
        let path = APIEndpoints.countries.rawValue
        self.execute(path, method: .get, completion: completion)
    }
    
}
