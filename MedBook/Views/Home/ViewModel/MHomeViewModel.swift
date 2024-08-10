//
//  MHomeViewModel.swift
//  MedBook
//
//  Created by Ajithmadhan Krishnamoorthy on 10/08/24.
//

import Foundation
import SwiftData
import SwiftUI

final class MHomeViewModel: ObservableObject {
    @Published var bookMarkedBooks: [Book] = []
    private lazy var bookMarkRepo = MBookMarkRepo()
    
    func getBookMarkedBooks(context: ModelContext) {
        withAnimation(.linear) {
            self.bookMarkedBooks = bookMarkRepo.getBookMarkedBooks(context: context)
        }
    }
    
}
