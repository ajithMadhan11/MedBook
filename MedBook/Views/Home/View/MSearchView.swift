//
//  MSearchView.swift
//  MedBook
//
//  Created by Ajithmadhan Krishnamoorthy on 10/08/24.
//

import SwiftUI

struct MSearchView: View {
    
    @Environment(\.modelContext) var context
    @EnvironmentObject var navigator: MNavigator
    
    @StateObject var vm = MSearchViewModel()
    
    var body: some View {
        VStack {
            if !vm.searchResults.isEmpty {
                HStack {
                    Text("Sort By:")
                        .font(MFont.MBold(14))
                    ForEach(SortOptions.allCases, id: \.self){ value in
                        MSortCell(title: value.rawValue, isSelected: vm.selectedSort == value)
                            .onTapGesture {
                                if vm.selectedSort == value {
                                    return
                                } else {
                                    vm.selectedSort = value
                                }
                            }
                    }
                    Spacer()
                }
                .id(vm.selectedSort)
                .padding()
                Spacer()
            }
            if vm.searchText.count == 0 {
                Image(.search)
                    .resizable()
                    .frame(width: 200, height: 200)
                Text("Start searching in library...")
                    .font(MFont.MBold(15))
                Spacer()
            } else if vm.isFetchingFreshRecords {
                ProgressView()
                Spacer()
            }
            else if vm.searchResults.isEmpty && !vm.isFetchingFreshRecords && !vm.isLoadingMore {
                Image(.empty)
                    .resizable()
                    .frame(width: 200, height: 200)
                Text("No Books found for - *\(vm.searchText)*")
                    .font(MFont.MBold(15))
                Spacer()
            }
            else if vm.errorInData {
                Image(.error)
                    .resizable()
                    .frame(width: 200, height: 200)
                Text("Something went wrong!")
                    .font(MFont.MBold(15))
                Spacer()
            }
            else {
                VStack {
                    List {
                        ForEach(vm.searchResults, id: \.self) { book in
                            MSearchBookCell(book: book)
                                .swipeActions {
                                    Button(action: {
                                        vm.addToFav(book: book, context: context)
                                    }, label: {
                                        Image(systemName: "bookmark")
                                    })
                                }
                                .onTapGesture {
                                    navigator.push(to: .DETAIL(book: book))
                                }
                                .tint(MColor.primaryGreen)
                                .onAppear {
                                    if book == vm.searchResults.last {
                                        if vm.hasMore {
                                            vm.getSearchResult(isForLoadMode: true)
                                        }
                                    }
                                }
                        }
                    }
                    .listStyle(.plain)
                }
            }
        }
        
        .alert("Added to Bookmark!", isPresented: $vm.isBookMarkAdded, actions: {
            Button("Yes", action: {
                vm.isBookMarkAdded.toggle()
            })
        })
        .searchable(text: $vm.searchText)
        .navigationTitle("Search Book")
        .navigationBarTitleDisplayMode(.large)
        .onChange(of: vm.debounceSearchText) { _, title in
            if title.count != 0 {
                vm.getSearchResult()
            } else {
                vm.resetData()
            }
        }
        .onChange(of: vm.selectedSort) { _, newValue in
            if newValue != nil {
                vm.sortRecords()
            }
        }
    }
}

