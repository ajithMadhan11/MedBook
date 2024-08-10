//
//  MDetailViewModel.swift
//  MedBook
//
//  Created by Ajithmadhan Krishnamoorthy on 10/08/24.
//

import Foundation
import SwiftData
import SwiftUI

final class MDetailViewModel: ObservableObject {
    @Published var isBookMarked: Bool = false
    
    private lazy var bookMarkRepo = MBookMarkRepo()
    
    func isBookmarked(book: Book, context: ModelContext) {
        self.isBookMarked = bookMarkRepo.isBookmarked(book: book, context: context)
    }
    
    func removeFromFav(book: Book, context: ModelContext) {
        let isRemoved = bookMarkRepo.removeFromFav(book: book, context: context)
        if isRemoved {
            withAnimation(.smooth) {
                isBookMarked = false
            }
        }
    }
    
    func addToFav(book: Book, context: ModelContext) {
        let isAdded = bookMarkRepo.addToFav(book: book, context: context)
        if isAdded {
            withAnimation(.smooth) {
                isBookMarked = true
            }
        }
    }
    
}
