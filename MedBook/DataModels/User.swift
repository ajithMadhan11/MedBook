//
//  User.swift
//  MedBook
//
//  Created by Ajithmadhan Krishnamoorthy on 09/08/24.
//

import Foundation
import SwiftData


@Model
class User {
    @Attribute let id = UUID()
    @Attribute var email: String
    @Attribute var password: String
    @Attribute var country: String
    @Transient var name: String {
        let components = email.split(separator: "@")
           guard components.count == 2 else {
               return "User"
           }
           let namePart = String(components[0])
           let formattedName = namePart.replacingOccurrences(of: ".", with: " ")
           
           return formattedName
        }
    @Relationship var collection: [Book] = []
    
    init(email: String, password: String, country: String) {
        self.email = email
        self.password = password
        self.country = country
    }
}
