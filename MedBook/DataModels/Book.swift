//
//  Book.swift
//  MedBook
//
//  Created by Ajithmadhan Krishnamoorthy on 09/08/24.
//

import Foundation
import SwiftData

@Model
class Book {
    @Attribute let id = UUID()
    @Attribute var name: String?
    @Attribute var ratingsAverage: Double?
    @Attribute var ratingsCount: Int64?
    @Attribute var authorName: String?
    @Attribute var coverImage: Int64?
    @Attribute var des: String
    @Attribute var isStarted: Bool?
    @Attribute var percentage: Float?
    
    init(name: String?, ratingsAverage: Double?, ratingsCount: Int64?, authorName: String?, coverImage: Int64?, des: String) {
        self.name = name
        self.ratingsAverage = ratingsAverage
        self.ratingsCount = ratingsCount
        self.authorName = authorName
        self.coverImage = coverImage
        self.des = des
    }
}
