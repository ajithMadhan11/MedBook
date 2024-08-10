//
//  MUserDefaults.swift
//  MedBook
//
//  Created by Ajithmadhan Krishnamoorthy on 08/08/24.
//

import Foundation

enum MUserDefaultsKey: String, CaseIterable {
    case user
    case countries
}

final class MUserDefaultsUtil {
    
    let userdefault: UserDefaults
    
    static let shared = MUserDefaultsUtil()
    
    private init() {
        userdefault = UserDefaults.standard
    }
    
    func resetData() {
        MUserDefaultsKey.allCases.forEach { key in
            MUserDefaultsUtil.shared.userdefault.removeObject(forKey: key.rawValue)
        }
    }
    
    func setCountries(data: [String: Country]) {
        do {
            let countryData = try JSONEncoder().encode(data)
            self.userdefault.set(countryData, forKey: MUserDefaultsKey.countries.rawValue)
        } catch {
            print("Encoding Failed for setting countries in local storage")
        }
    }
    
    func getCountries() -> [String: Country]? {
        if let data = self.userdefault.value(forKey: MUserDefaultsKey.countries.rawValue) as? Data {
            do {
                let countries = try JSONDecoder().decode([String: Country].self, from: data)
                return countries
            } catch {
                print("Decoding Failed for getting countries from local storage")
            }
        }
       return nil
    }
    
    func setUserId(userId: UUID) {
        do {
            let userIdData = try JSONEncoder().encode(userId)
            self.userdefault.set(userIdData, forKey: MUserDefaultsKey.user.rawValue)
        } catch {
            print("Encoding Failed for setting userId in local storage")
        }
    }
    
    func getUserId() -> String? {
        if let data = self.userdefault.value(forKey: MUserDefaultsKey.user.rawValue) as? Data {
            do {
                let userId = try JSONDecoder().decode(String.self, from: data)
                return userId
            } catch {
                print("Decoding Failed for getting userId from local storage")
            }
        }
       return nil
    }
}

