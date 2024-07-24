//
//  Book.swift
//  Bookshelf
//
//  Created by Aaron Peterson on 7/24/24.
//

import Foundation

struct Book: Identifiable {
    let id: UUID
    let title: String
    let author: String
    let imageUrl: String
    var isLoaned: Bool = false
    
    // Initializer for creating a new book
    init(id: UUID = UUID(), title: String, author: String, imageUrl: String, isLoaned: Bool = false) {
        self.id = id
        self.title = title
        self.author = author
        self.imageUrl = imageUrl
        self.isLoaned = isLoaned
    }
    
    // Initializer for creating a book from a BookEntity
    init(entity: BookEntity) {
        self.id = entity.id ?? UUID()
        self.title = entity.title ?? "Unknown Title"
        self.author = entity.author ?? "Unknown Author"
        self.imageUrl = entity.imageUrl ?? ""
        self.isLoaned = entity.isLoaned
    }
}
