//
//  MHomeView.swift
//  MedBook
//
//  Created by Ajithmadhan Krishnamoorthy on 09/08/24.
//

import SwiftUI

struct MHomeView: View {
    @Environment(\.modelContext) var context
    @EnvironmentObject var navigator: MNavigator
    @State private var isLogoutPressed: Bool = false
    @StateObject private var vm = MHomeViewModel()
    
    var body: some View {
        NavigationStack(path: $navigator.routes) {
            ScrollView {
                VStack {
                    ContinueReadingSection()
                    MCategoryChips()
                    ExploreSection()
                    Spacer()
                    
                }
            }
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        navigator.push(to: .SEARCH)
                    }) {
                        Image(systemName: "magnifyingglass")
                    }
                    .foregroundColor(.black)
                }
                ToolbarItem {
                    Button(action: {
                        navigator.push(to: .BOOKMARKS)
                    }) {
                        Image(systemName: "bookmark.fill")
                    }
                    .foregroundColor(.black)
                }
                ToolbarItem {
                    Button(action: {
                        isLogoutPressed.toggle()
                    }) {
                        Image(systemName: "power")
                    }
                    .foregroundColor(.red)
                }
            }
            .alert("Are you sure want to logout?", isPresented: $isLogoutPressed, actions: {
                Button("Yes", action: {
                    AuthHandler.Authenticated.send(false)
                })
                Button("No", action: {
                    isLogoutPressed.toggle()
                })
            })
            .navigationDestination(for: MRoutes.self) { $0 }
            .navigationTitle("MedBook")
            .navigationBarTitleDisplayMode(.large)
        }
    }
    
    @ViewBuilder
    private func ContinueReadingSection() -> some View {
        
        VStack() {
            HStack {
                Text("Continue Reading")
                    .font(MFont.MBold(16))
                Spacer()
                Button(action: {
                    navigator.push(to: .LIST(type: .continueReading, books: vm.bookMarkedBooks))
                }) {
                    Text("See all")
                        .font(MFont.MBold(14))
                        .foregroundStyle(MColor.primaryGreen)
                }
            }
            .padding()
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(vm.bookMarkedBooks, id: \.self) { book in
                        MReadBookCell(book: book)
                            .frame(width: UIScreen.main.bounds.width - 50)
                            .onTapGesture {
                                navigator.push(to: .DETAIL(book: book))
                            }
                    }
                }
                .scrollTargetLayout()
            }
            .frame(height: 200)
            .scrollIndicators(.hidden)
            .safeAreaPadding(.leading, 20)
        }
        .task {
            vm.getBookMarkedBooks(context: context)
        }
    }
    
    @ViewBuilder
    private func ExploreSection() -> some View {
        VStack {
            HStack {
                Text("Most Popular")
                    .font(MFont.MBold(16))
                Spacer()
                Button(action: {
                    navigator.push(to: .LIST(type: .popular, books: StaticDataSource.popularBooks))
                }) {
                    Text("See all")
                        .font(MFont.MBold(14))
                        .foregroundStyle(MColor.primaryGreen)
                }
                
            }
            .padding()
            ScrollView(.horizontal) {
                LazyHStack {
                    ForEach(StaticDataSource.popularBooks, id: \.self) { book in
                        MPopularCell(book: book)
                            .onTapGesture {
                                navigator.push(to: .DETAIL(book: book))
                            }
                    }
                }
                .scrollTargetLayout()
            }
            .scrollIndicators(.hidden)
            .safeAreaPadding(.leading, 20)
        }
    }
    
}
