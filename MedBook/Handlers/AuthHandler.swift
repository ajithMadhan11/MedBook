//
//  AuthHandler.swift
//  MedBook
//
//  Created by Ajithmadhan Krishnamoorthy on 09/08/24.
//

import Foundation
import Combine

struct AuthHandler {
    static var Authenticated = PassthroughSubject<Bool, Never>()
    static func IsAuthenticated() -> Bool {
        return MUserDefaultsUtil.shared.getUserId() != nil
    }
}
