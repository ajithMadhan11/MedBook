//
//  GetCurrentCountry.swift
//  MedBook
//
//  Created by Ajithmadhan Krishnamoorthy on 09/08/24.
//

import Foundation

struct CurrentCountry: Codable {
    let status: String
    let country: String
}


class GetCurrentCountryController: BaseNetworkHandler<CurrentCountry> {
    
    func getCountry(completion: @escaping (Result<CurrentCountry, MError>) -> Void) {
        let path = APIEndpoints.currentCountry.rawValue
        self.execute(path, method: .get, completion: completion)
    }
    
}
