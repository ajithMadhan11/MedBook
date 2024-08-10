//
//  ReadBookCell.swift
//  MedBook
//
//  Created by Ajithmadhan Krishnamoorthy on 09/08/24.
//

import SwiftUI

struct MReadBookCell: View {
    
    var book: Book
    @State private var range: Int = 0
    var body: some View {
        HStack {
            MCachedImage(url: "https://covers.openlibrary.org/b/id/\(book.coverImage ?? 560976)-M.jpg")
                .frame(width: 130, height: 180)
                .cornerRadius(12)
            VStack(alignment: .leading, spacing: 12) {
                Text(book.name ?? "Not yet Named!😅")
                    .font(MFont.MBold(16))
                    .lineLimit(2)
                Text(book.authorName ?? "Ajithmadhan")
                    .font(MFont.MRegular(16))
                    .foregroundStyle(Color.gray)
                HStack {
                    MCircularProgressBar(progress: .constant(Float.random(in: 0.2...1.0)))
                        .frame(width: 75, height: 75)
                    Text("\(range)%")
                        .font(MFont.MBold(15))
                        .foregroundStyle(MColor.primaryGreen)
                }
            }
        }
        .onAppear {
            self.range = Int.random(in: 25...100)
        }
    }
}
