//
//  StaticDataSource.swift
//  MedBook
//
//  Created by Ajithmadhan Krishnamoorthy on 10/08/24.
//

import Foundation

final class StaticDataSource {
    static let book1 = Book(name: "The Great Gatsby", ratingsAverage: 4.4, ratingsCount: 3784327, authorName: "F. Scott Fitzgerald", coverImage: 984483, des: "A novel set in the Roaring Twenties, exploring themes of wealth, excess, and the American dream.")
    static let book2 = Book(name: "To Kill a Mockingbird", ratingsAverage: 4.3, ratingsCount: 4887654, authorName: "Harper Lee", coverImage: 822733, des: "A classic novel of racism and injustice in the Deep South through the eyes of young Scout Finch.")
    static let book3 = Book(name: "1984", ratingsAverage: 4.2, ratingsCount: 3275431, authorName: "George Orwell", coverImage: 654233, des: "A dystopian novel that explores the dangers of totalitarianism and extreme political ideology.")
    static let book4 = Book(name: "Pride and Prejudice", ratingsAverage: 4.5, ratingsCount: 2854321, authorName: "Jane Austen", coverImage: 762544, des: "A romantic novel that critiques the British landed gentry at the end of the 18th century.")
    static let book5 = Book(name: "The Catcher in the Rye", ratingsAverage: 3.9, ratingsCount: 2432543, authorName: "J.D. Salinger", coverImage: 937263, des: "A novel about teenage rebellion and angst, told through the eyes of Holden Caulfield.")
    static let book6 = Book(name: "Moby-Dick", ratingsAverage: 3.8, ratingsCount: 598234, authorName: "Herman Melville", coverImage: 843728, des: "A seafaring adventure that explores themes of obsession and revenge through the story of Captain Ahab.")
    static let book7 = Book(name: "War and Peace", ratingsAverage: 4.1, ratingsCount: 192843, authorName: "Leo Tolstoy", coverImage: 693872, des: "A historical epic that chronicles the French invasion of Russia and the impact on Russian society.")
    static let book8 = Book(name: "The Hobbit", ratingsAverage: 4.7, ratingsCount: 3759834, authorName: "J.R.R. Tolkien", coverImage: 784923, des: "A fantasy novel that follows the quest of Bilbo Baggins as he embarks on an adventure to win a share of treasure guarded by Smaug the dragon.")
    static let book9 = Book(name: "The Odyssey", ratingsAverage: 4.0, ratingsCount: 482739, authorName: "Homer", coverImage: 583729, des: "An ancient Greek epic poem that tells the story of Odysseus's journey home after the Trojan War.")
    static let book10 = Book(name: "Brave New World", ratingsAverage: 4.1, ratingsCount: 1654382, authorName: "Aldous Huxley", coverImage: 926382, des: "A dystopian novel that explores a future society driven by technological advancements and consumerism.")

    static let popularBooks = [book1, book2, book3, book4, book5, book6]
}
