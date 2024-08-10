//
//  MDetailView.swift
//  MedBook
//
//  Created by Ajithmadhan Krishnamoorthy on 09/08/24.
//

import SwiftUI

struct MDetailView: View {
    @Environment(\.modelContext) var context
    var book: Book
    @StateObject var vm = MDetailViewModel()
    var body: some View {
        VStack(alignment: .center) {
            ScrollView {
                MCachedImage(url: "https://covers.openlibrary.org/b/id/\(book.coverImage ?? 123432)-M.jpg")
                    .frame(width: 180, height: 280)
                    .cornerRadius(12)
                    .padding(.bottom, 40)
                VStack(alignment: .center, spacing: 16) {
                    Text(book.name ?? "Yet to be announced😅")
                        .font(MFont.MBold(16))
                        .lineLimit(2)
                        .multilineTextAlignment(.center)
                    Text(book.authorName ?? "Ajithmadhan")
                        .font(MFont.MRegular(16))
                        .foregroundStyle(Color.gray)
                    HStack(spacing: 20){
                        VStack {
                            Text("Average Rating")
                                .font(MFont.MBold(16))
                                .foregroundStyle(Color.gray)
                            Text("\(Int(book.ratingsAverage ?? 0))⭐️")
                                .font(MFont.MRegular(16))
                                .foregroundStyle(Color.black)
                        }
                        Divider()
                        VStack {
                            Text("Total Ratings")
                                .font(MFont.MBold(16))
                                .foregroundStyle(Color.gray)
                            Text("\(book.ratingsCount ?? 0)")
                                .font(MFont.MRegular(16))
                                .foregroundStyle(Color.black)
                        }
                    }
                    .cornerRadius(16)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(MColor.lightBlue)
                }
                Text("Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.")
                    .multilineTextAlignment(.leading)
                    
                    .font(MFont.MRegular(16))
                Spacer()
            }
            .scrollIndicators(.hidden)
            Spacer()
            HStack {
                MFillButton(title: "Start Reading", isPrimary: true) {
                    //
                }
            }
        }
        .padding()
        .navigationTitle("Book Detail")
        .toolbar {
            ToolbarItem {
                Button {
                    if vm.isBookMarked {
                        vm.removeFromFav(book: book, context: context)
                    } else {
                        vm.addToFav(book: book, context: context)
                    }
                } label: {
                    Image(systemName: vm.isBookMarked ? "bookmark.fill" : "bookmark")
                }

            }
        }
        .onAppear {
            vm.isBookmarked(book: book, context: context)
        }
    }
}
