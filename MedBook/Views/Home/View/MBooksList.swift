//
//  MBooksList.swift
//  MedBook
//
//  Created by Ajithmadhan Krishnamoorthy on 09/08/24.
//

import SwiftUI

struct MBooksList: View {
    @EnvironmentObject var navigator: MNavigator
    @State var listFromHome: ListTypes
    @State var bookList: [Book]
    var body: some View {
        VStack {
            if bookList.isEmpty {
                VStack {
                    Image(.empty)
                        .resizable()
                        .frame(width: 200, height: 200)
                    Text("Nothing is found here")
                        .font(MFont.MBold(15))
                    Spacer()
                }
            } else {
                List {
                    ForEach(bookList, id: \.self) { book in
                        MHorizontalCell(book: book, isPopular: listFromHome == .popular)
                            .onTapGesture {
                                navigator.push(to: .DETAIL(book: book))
                            }
                    }
                }
                .listStyle(.plain)
                .scrollIndicators(.hidden)
            }
        }
        .padding()
        .navigationTitle(listFromHome.rawValue)
        .navigationBarTitleDisplayMode(.large)
    }
}
