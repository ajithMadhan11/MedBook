//
//  MHorizontalCell.swift
//  MedBook
//
//  Created by Ajithmadhan Krishnamoorthy on 09/08/24.
//

import SwiftUI

struct MHorizontalCell: View {
    var book: Book
    @State private var loaded: Int = 0
    @State var isPopular: Bool = false
    var body: some View {
        HStack {
            MCachedImage(url: "https://covers.openlibrary.org/b/id/\(book.coverImage ?? 560976)-M.jpg")
                .frame(width: 120, height: 120)
                .cornerRadius(12)
            VStack(alignment: .leading, spacing: 12) {
                Text(book.name ?? "yet to be announced😅")
                    .font(MFont.MBold(16))
                    .lineLimit(2)
                Text(book.authorName ?? "Ajithmadhan")
                    .font(MFont.MRegular(16))
                    .foregroundStyle(Color.gray)
                if isPopular {
                    HStack(spacing: 20){
                        Text("\(Int(book.ratingsAverage ?? 0)) ⭐️")
                            .font(MFont.MBold(12))
                    }
                } else {
                    HStack(spacing: 20){
                        ProgressView(value: Float(loaded), total: 100)
                            .tint(MColor.primaryGreen)
                        Text("\(loaded)%")
                            .font(MFont.MBold(16))
                            .foregroundStyle(MColor.primaryGreen)
                    }
                }
            }
        }
        .onAppear {
            self.loaded = Int.random(in: 25...80)
        }
    }
}
