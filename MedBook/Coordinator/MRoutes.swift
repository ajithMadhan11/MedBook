//
//  MRoutes.swift
//  MedBook
//
//  Created by Ajithmadhan Krishnamoorthy on 08/08/24.
//

import Foundation
import SwiftUI

enum ListTypes: String {
    case continueReading = "Readings"
    case popular = "Popular Reading"
}

enum MRoutes: Hashable{
    case SEARCH
    case HOME
    case BOOKMARKS
    case DETAIL(book: Book)
    case LIST(type: ListTypes, books: [Book])
}

extension MRoutes: View {
    var body: some View {
        switch self {
        case .SEARCH:
            MSearchView()
        case .HOME:
            Text("Home")
        case .DETAIL(let book):
            MDetailView(book: book)
        case .LIST(let type, let books):
            MBooksList(listFromHome: type, bookList: books)
                .tint(Color.black)
        case .BOOKMARKS:
            MBookMarkView()
        }
    }
}
