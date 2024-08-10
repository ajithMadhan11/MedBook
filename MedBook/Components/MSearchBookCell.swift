//
//  MSearchBookCell.swift
//  MedBook
//
//  Created by Ajithmadhan Krishnamoorthy on 10/08/24.
//

import SwiftUI

struct MSearchBookCell: View {
    @State var book: Book
    var body: some View {
        HStack {
            MCachedImage(url: "https://covers.openlibrary.org/b/id/\(book.coverImage ?? 560976)-M.jpg")
                .frame(width: 80, height: 80)
                .cornerRadius(12)
            VStack(alignment: .leading, spacing: 4) {
                Text(book.name ?? "No Title")
                    .font(MFont.MBold(12))
                    .lineLimit(2)
                Text(book.authorName ?? "No name found")
                    .font(MFont.MRegular(12))
                    .foregroundStyle(Color.gray)
                HStack(spacing: 20){
                    Text("\(Int(book.ratingsAverage ?? 0)) ⭐️")
                        .font(MFont.MBold(12))
                }
            }
        }
        .background(Color.white)
    }
}
