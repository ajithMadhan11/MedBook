//
//  MPopularCell.swift
//  MedBook
//
//  Created by Ajithmadhan Krishnamoorthy on 09/08/24.
//

import SwiftUI

struct MPopularCell: View {
    var book: Book
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: 160, height: 240)
                .cornerRadius(16)
                .foregroundStyle(MColor.lightGray)
            VStack {
                MCachedImage(url: "https://covers.openlibrary.org/b/id/\(book.coverImage ?? 560976)-M.jpg")
                    .frame(width: 130, height: 180)
                    .cornerRadius(12)
                VStack(alignment: .leading, spacing: 6) {
                    Text(book.name ?? "Yet to be named!")
                        .font(MFont.MBold(16))
                        .lineLimit(2)
                    Text(book.authorName ?? "Ajithmadhan")
                        .font(MFont.MRegular(16))
                        .foregroundStyle(Color.gray)
                }
            }
            .frame(width: 130)
            .padding(.bottom, 60)
        }
    }
}
