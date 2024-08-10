//
//  MBookMarkRepo.swift
//  MedBook
//
//  Created by Ajithmadhan Krishnamoorthy on 10/08/24.
//

import Foundation
import SwiftData

class MBookMarkRepo {
    
    func addToFav(book: Book, context: ModelContext) -> Bool {
        if let userId = MUserDefaultsUtil.shared.getUserId(), let idString = UUID(uuidString: userId) {
            let predicate = #Predicate<User> { user in
                user.id == idString
            }
            var fetchDescriptor = FetchDescriptor<User>(predicate: predicate)
            fetchDescriptor.fetchLimit = 1
            
            do {
                let user = try context.fetch(fetchDescriptor)
                if let currentUser = user.first {
                    currentUser.collection.append(book)
                    try context.save()
                    print("Saved successfully")
                    return true
                }
            } catch {
                print("Error saving book to user")
                return false
            }
        }
        return false
    }
    
    func removeFromFav(book: Book, context: ModelContext) -> Bool {
        if let userId = MUserDefaultsUtil.shared.getUserId(), let idString = UUID(uuidString: userId) {
            let predicate = #Predicate<User> { user in
                user.id == idString
            }
            var fetchDescriptor = FetchDescriptor<User>(predicate: predicate)
            fetchDescriptor.fetchLimit = 1
            
            do {
                let user = try context.fetch(fetchDescriptor)
                if let currentUser = user.first {
                    currentUser.collection.removeAll { _book in
                        _book.id == book.id
                    }
                    try context.save()
                    print("removed successfully")
                    return true
                }
            } catch {
                print("Error saving book to user")
                return false
            }
        }
        return false
    }
    
    func isBookmarked(book: Book, context: ModelContext) -> Bool {
        if let userId = MUserDefaultsUtil.shared.getUserId(), let idString = UUID(uuidString: userId) {
            let predicate = #Predicate<User> { user in
                user.id == idString
            }
            var fetchDescriptor = FetchDescriptor<User>(predicate: predicate)
            fetchDescriptor.fetchLimit = 1
            
            do {
                let user = try context.fetch(fetchDescriptor)
                if let currentUser = user.first {
                    return currentUser.collection.contains { _book in
                        _book.id == book.id
                    }
                }
            } catch {
                print("Error getting book from user")
                return false
            }
        }
        return false
    }
    
    func getBookMarkedBooks(context: ModelContext) -> [Book] {
        if let userId = MUserDefaultsUtil.shared.getUserId(), let idString = UUID(uuidString: userId) {
            let predicate = #Predicate<User> { user in
                user.id == idString
            }
            var fetchDescriptor = FetchDescriptor<User>(predicate: predicate)
            fetchDescriptor.fetchLimit = 1
            
            do {
                let user = try context.fetch(fetchDescriptor)
                if let currentUser = user.first {
                    return currentUser.collection 
                }
            } catch {
                print("Error getting book from user")
                return []
            }
        }
        return []
    }
}
