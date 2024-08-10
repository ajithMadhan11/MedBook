//
//  MBookMarkView.swift
//  MedBook
//
//  Created by Ajithmadhan Krishnamoorthy on 10/08/24.
//

import SwiftUI
import SwiftData

struct MBookMarkView: View {
    
    @EnvironmentObject var navigator: MNavigator
    @Environment(\.modelContext) var context
    @StateObject var vm = MBookmarkViewModel()
    
    var body: some View {
        VStack {
            if vm.isFetchingBooks {
                VStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
            } else if vm.books.isEmpty {
                VStack {
                    Image(.empty)
                        .resizable()
                        .frame(width: 200, height: 200)
                    Text("No Books Bookmarked yet")
                        .font(MFont.MBold(15))
                    Spacer()
                }
            } else {
                VStack {
                    List {
                        ForEach(vm.books, id: \.self) { book in
                            MHorizontalCell(book: book)
                                .swipeActions {
                                    Button(action: {
                                        vm.removeFromFav(book: book, context: context)
                                    }, label: {
                                        Image(systemName: "trash")
                                    })
                                    .tint(Color.red)
                                }
                                .onTapGesture {
                                    navigator.push(to: .DETAIL(book: book))
                                }
                                .tint(MColor.primaryGreen)
                        }
                    }
                }
            }
        }
        .navigationTitle("Bookmarks")
        .onAppear {
            vm.fetchBookFromDB(context: context)
        }
    }
}
