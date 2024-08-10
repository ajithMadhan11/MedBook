//
//  MLoginViewModel.swift
//  MedBook
//
//  Created by Ajithmadhan Krishnamoorthy on 08/08/24.
//

import Foundation
import SwiftData


final class AuthViewModel: ObservableObject {
    
    private lazy var signInRepo = SignInRepo()
    private lazy var signUpRepo = SignUnRepo()
    
    @Published var userEmail: String = ""
    @Published var userPassword: String = ""
    @Published var userCountry: String?
    @Published var countriesList: [String: Country]?
    
    @Published var errorInCountriesList: Bool = false
    @Published var fetchingCountriesList: Bool = false
    
    @Published var authState: AuthState = .login
    
    @Published var error: AuthDomainError? = nil
    
    func signin(context: ModelContext) {
        guard userEmail != "" && userPassword != "" else {
            error = .empty_state
            return
        }
        
        let result = signInRepo.signin(email: userEmail, password: userPassword, context: context)
        switch result {
        case .success(let success):
            if success {
                error = nil
                AuthHandler.Authenticated.send(true)
            }
        case .failure(let failure):
            error = failure
        }
    }
    
    func signup(context: ModelContext) {
        guard userEmail != "" && userPassword != "" && userCountry != nil else {
            error = .empty_state
            return
        }
        
        let result = signUpRepo.signup(email: userEmail, password: userPassword, country: userCountry!, context: context)
        switch result {
        case .success(let success):
            if success {
                error = nil
                AuthHandler.Authenticated.send(true)
            }
        case .failure(let failure):
            error = failure
        }
    }
    
}

extension AuthViewModel {
    func getCurrentCountry() {
        let controller = GetCurrentCountryController()
        controller.getCountry { response in
            switch response {
            case .success(let data):
                if self.userCountry == nil {
                    //Status check should be done
                    DispatchQueue.main.async {
                        self.userCountry = data.country
                    }
                }
            case .failure(_): break
                //Can be handled to retry
            }
        }
    }
    
    func getCountriesList() {
        self.fetchingCountriesList = true
        defer {
            DispatchQueue.main.async {
                self.fetchingCountriesList = false
            }
        }
        if let countries = MUserDefaultsUtil.shared.getCountries() {
            DispatchQueue.main.async {
                self.errorInCountriesList = false
                self.countriesList = countries
            }
            return
        }
        let controller = GetCountriesListController()
        controller.getCountries { response in
            DispatchQueue.main.async {
                switch response {
                case .success(let data):
                    self.errorInCountriesList = false
                    MUserDefaultsUtil.shared.setCountries(data: data.data)
                    self.countriesList = data.data
                case .failure(_):
                    self.errorInCountriesList = true
                }
            }
        }
    }
}
