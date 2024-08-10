//
//  SignInRepo.swift
//  MedBook
//
//  Created by Ajithmadhan Krishnamoorthy on 09/08/24.
//

import Foundation
import SwiftData

class SignInRepo {
    
    func signin(email: String, password: String, context: ModelContext) -> Result<Bool, AuthDomainError> {
        let predicate = #Predicate<User> { user in
                user.email == email
            }
        var fetchDescriptor = FetchDescriptor<User>(predicate: predicate)
        fetchDescriptor.fetchLimit = 1
        
        do {
            let user = try context.fetch(fetchDescriptor)
            if let currentUser = user.first {
                if currentUser.password == password {
                    MUserDefaultsUtil.shared.setUserId(userId: currentUser.id)
                    return .success(true)
                }
                return .failure(.email_or_password_invalid)
            } else {
                return .failure(.no_user_found)
            }
        } catch {
            return .failure(.no_user_found)
        }
    }
    
}
