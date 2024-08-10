//
//  MBookmarkViewModel.swift
//  MedBook
//
//  Created by Ajithmadhan Krishnamoorthy on 10/08/24.
//

import Foundation
import SwiftData
import SwiftUI


final class MBookmarkViewModel: ObservableObject {
    @Published var books: [Book] = []
    @Published var isFetchingBooks: Bool = true
    
    private lazy var bookMarkRepo: MBookMarkRepo = MBookMarkRepo()
    
    func fetchBookFromDB(context: ModelContext) {
        isFetchingBooks = true
        if let userId = MUserDefaultsUtil.shared.getUserId(), let idString = UUID(uuidString: userId) {
            let predicate = #Predicate<User> { user in
                user.id == idString
            }
            var fetchDescriptor = FetchDescriptor<User>(predicate: predicate)
            fetchDescriptor.fetchLimit = 1
            
            do {
                let user = try context.fetch(fetchDescriptor)
                if let currentUser = user.first {
                    DispatchQueue.main.async {
                        self.books = currentUser.collection
                    }
                    isFetchingBooks = false
                    print("fetched successfully")
                }
            } catch {
                isFetchingBooks = false
                print("Error fetching book from user")
            }
        }
    }
    
    func removeFromFav(book: Book, context: ModelContext) {
        let isRemoved = bookMarkRepo.removeFromFav(book: book, context: context)
        if isRemoved {
            removeBookFromLocalCollection(book: book)
        }
    }
    
    private func removeBookFromLocalCollection(book: Book) {
        withAnimation(.linear) {
            self.books.removeAll { _book in
                book.id == _book.id
            }
        }
    }
    
}
