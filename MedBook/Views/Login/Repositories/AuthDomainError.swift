//
//  AuthDomainError.swift
//  MedBook
//
//  Created by Ajithmadhan Krishnamoorthy on 09/08/24.
//

import Foundation

enum AuthDomainError: String, Error {
    case no_user_found = "No user found"
    case email_or_password_invalid = "Email or password is invalid"
    case invalid_email = "Invalid email address"
    case invalid_password = "Password should contain minimum 8 Characters, at least 1 number, at least 1 uppercase character, at least 1 special character"
    case empty_state = "Please fill all fields"
    case invalid_state = "Invalid Inputs"
    case save_failed = "Error saving user"
    case user_exists = "User already exists"
}
