//
//  BookController.swift
//  ReadingList
//
//  Created by Alex Rhodes on 8/20/19.
//  Copyright © 2019 Alex Rhodes. All rights reserved.
//

import Foundation

class BookController {
    
    init() {
        loadFromPersistentStore()
    }
    
    var books: [Book] = []
    
    var readBooks: [Book] {
        return books.filter { $0.hasBeenRead == true }
    }
    
    var unreadBooks: [Book] {
        return books.filter { $0.hasBeenRead == false }
    }
    
    func updateHasBeenRead(for book: Book) {
        var newBook = book
        guard let index = books.firstIndex(of: book) else { return }
        books[index] = newBook
        newBook.hasBeenRead.toggle()
    }
    
    func toggleHasBeenRead(for cell: BookTableViewCell) {
        guard let book = cell.book else {return}
        updateHasBeenRead(for: book)
        if book.hasBeenRead == true {
           cell.hasBeenReadButton.setBackgroundImage(#imageLiteral(resourceName: "checked"), for: .selected)
        } else {
            cell.hasBeenReadButton.setBackgroundImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
        }
    }
    
    @ discardableResult func createBook(_ title: String, reasonToRead: String, hasBeenRead: Bool) -> Book {
        let book = Book(title: title, reasonToRead: reasonToRead, hasBeenRead: hasBeenRead)
        books.append(book)
        saveToPersistentStore()
        return book
        
    }
    
    func deleteBook(book: Book) {
        if let index = books.firstIndex(of: book) {
            books.remove(at: index)
            saveToPersistentStore()
        }
    }
    
    func loadFromPersistentStore() {
        let fm = FileManager.default
        guard let url = readingListURL else {return}
        fm.fileExists(atPath: url.path)
        
        do {
            let decoder = PropertyListDecoder()
            let data = try Data(contentsOf: url)
            books = try decoder.decode([Book].self, from: data)
        } catch {
            print("Error loading book data: \(error)")
        }
    }
    
    func saveToPersistentStore() {
        guard let url = readingListURL else { return }
        
        do {
            let encoder = PropertyListEncoder()
            let data = try encoder.encode(books)
            try data.write(to: url)
        } catch {
            print("Error loading book data: \(error)")
        }
    }
    
    private var readingListURL: URL? {
        let fm = FileManager.default
        guard let dir = fm.urls(for: .documentDirectory, in: .userDomainMask).first else {return nil}
        return dir.appendingPathComponent("books.plist")
        
    }
}
