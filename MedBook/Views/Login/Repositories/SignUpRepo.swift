//
//  SignUpRepo.swift
//  MedBook
//
//  Created by Ajithmadhan Krishnamoorthy on 09/08/24.
//

import Foundation
import SwiftData

class SignUnRepo {
   
    func signup(email: String, password: String, country: String, context: ModelContext) -> Result<Bool, AuthDomainError> {
        if isValidEmailAddress(email: email) {
            if isValidPassword(password: password) {
                let res = saveUser(user: User(email: email, password: password, country: country), email: email, context: context)
                return res
            } else {
                return .failure(.invalid_password)
            }
        } else {
            return .failure(.invalid_email)
        }
    }

    func isValidEmailAddress(email: String) -> Bool {
        let emailRegEx = "^[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Z|a-z]{2,}$"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func isValidPassword(password: String) -> Bool {
        let passwordRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$"
        let passwordPred = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordPred.evaluate(with: password)
    }

    //TODO: refactor this email method
    func saveUser(user: User, email: String, context: ModelContext) -> Result<Bool, AuthDomainError> {
        let predicate = #Predicate<User> { currentUser in
            currentUser.email == email
        }
        var fetchDescriptor = FetchDescriptor<User>(predicate: predicate)
        fetchDescriptor.fetchLimit = 1

        do {
            let existingUsers = try context.fetch(fetchDescriptor)
            
            if existingUsers.isEmpty {
                // User does not exist, proceed to save the new user
                context.insert(user)
                
                do {
                    user.collection.append(contentsOf: [StaticDataSource.book7, StaticDataSource.book8, StaticDataSource.book9, StaticDataSource.book10])
                    try context.save()
                    MUserDefaultsUtil.shared.setUserId(userId: user.id)
                    return .success(true)
                } catch {
                    return .failure(.save_failed)
                }
            } else {
                // User already exists
                return .failure(.user_exists)
            }
        } catch {
            return .failure(.save_failed)
        }
    }
    
}
