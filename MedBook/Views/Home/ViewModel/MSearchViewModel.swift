//
//  MSearchViewModel.swift
//  MedBook
//
//  Created by Ajithmadhan Krishnamoorthy on 10/08/24.
//

import Foundation
import SwiftData
import SwiftUI

final class MSearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var debounceSearchText: String = ""
    @Published var selectedSort: SortOptions? = nil
    @Published var searchResults: [Book] = []
    @Published var isFetchingFreshRecords: Bool = false
    @Published var isLoadingMore: Bool = false
    @Published var noDataFound: Bool = false
    @Published var errorInData: Bool = false
    @Published var startSearch: Bool = true
    @Published var isBookMarkAdded: Bool = false
    var hasMore: Bool = false
    var currentOffset: Int = 0
    var totalBooksFound: Int = 0
    private let controller = searchBookController()
    
    private lazy var bookMarkRepo = MBookMarkRepo()
    
    func resetData() {
        withAnimation(.smooth) {
            self.searchResults = []
            self.isFetchingFreshRecords = false
            self.isLoadingMore = false
            self.noDataFound = false
            self.errorInData = false
            self.startSearch = true
            self.selectedSort = nil
        }
        hasMore = false
        currentOffset = 0
        totalBooksFound = 0
    }
    
    init() {
        setupTitleDebounce()
    }
    
    func addToFav(book: Book, context: ModelContext) {
        let isAdded = bookMarkRepo.addToFav(book: book, context: context)
        if isAdded {
            self.isBookMarkAdded.toggle()
        }
    }
    
    func setupTitleDebounce() {
        debounceSearchText = self.searchText
        $searchText
            .debounce(for: .seconds(0.300), scheduler: RunLoop.main)
            .assign(to: &$debounceSearchText)
    }
    
    func getSearchResult(isForLoadMode: Bool = false) {
        if searchText.count >= 3 {
            if isForLoadMode {
                if self.searchResults.count > currentOffset {
                    self.currentOffset += 10
                    self.isLoadingMore = true
                } else {
                    hasMore = false
                    return
                }
            } else {
                self.currentOffset = 0
                totalBooksFound = 0
                self.updateLoadingState(state: true)
            }
            print("Started searching - \(isLoadingMore)")
            
            controller.searchBook(title: searchText, limit: 10, offset: currentOffset) {[weak self] response in
                guard let self = self else { return }
                switch response {
                case .success(let res):
                    self.transformModelToViewModel(books: res)
                    self.updateLoadingState(state: false)
                    DispatchQueue.main.async {
                        self.isLoadingMore = false
                        self.errorInData = false
                    }
                case .failure(_):
                    //TODO: No known domain errors from API
                    DispatchQueue.main.async {
                        self.errorInData = true
                    }
                }
            }
        }
    }
    
    private func updateLoadingState(state: Bool) {
        DispatchQueue.main.async {
            self.isFetchingFreshRecords = state
        }
    }
    
    private func transformModelToViewModel(books: BookResponse) {
        self.totalBooksFound = books.numFound
        let isLoadMore = self.currentOffset > 0
        
        var result: [Book] = []
        for book in books.docs {
            if let title = book.title, let author = book.author_name?[0] {
                result.append(Book(name: title, ratingsAverage: book.ratings_average, ratingsCount: book.ratings_count, authorName: author, coverImage: book.cover_i, des: ""))
            }
        }
        if isLoadMore {
            DispatchQueue.main.async {
                self.searchResults += result
            }
        } else {
            DispatchQueue.main.async {
                self.searchResults = result
            }
        }
        self.hasMore =  totalBooksFound >= self.searchResults.count
    }
    
    func sortRecords() {
        switch self.selectedSort {
        case .title:
            withAnimation(.linear) {
                self.searchResults.sort{$0.name ?? "" < $1.name ?? ""}
            }
        case .average:
            withAnimation(.linear) {
                self.searchResults.sort{$0.ratingsAverage ?? 0.0 > $1.ratingsAverage ?? 0.0}
            }
        case .none:
            return
        }
    }
    
}
