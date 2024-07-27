//
//  Book.swift
//  Bookshelf
//
//  Created by Aaron Peterson on 7/24/24.
//

import Foundation
import CoreData

struct Book: Identifiable {
    let id: UUID
    let title: String
    let author: String
    let publisher: String
    let publishedDate: String
    let description: String
    let pageCount: Int
    let mainCategory: String
    let averageRating: Double
    let ratingsCount: Int
    let language: String
    let dimensions: BookObjectDimensions?
    let imageLinks: BookObjectImageLinks?
    var isLoaned: Bool = false
    var isMissing: Bool = false
    var quantity: Int = 1
    
    // Initializer for creating a new book
    init(id: UUID = UUID(),
         title: String,
         author: String,
         publisher: String,
         publishedDate: String,
         description: String,
         pageCount: Int,
         mainCategory: String,
         averageRating: Double,
         ratingsCount: Int,
         language: String,
         dimensions: BookObjectDimensions? = nil,
         imageLinks: BookObjectImageLinks? = nil,
         isLoaned: Bool = false,
         isMissing: Bool = false,
         quantity: Int = 1) {
        self.id = id
        self.title = title
        self.author = author
        self.publisher = publisher
        self.publishedDate = publishedDate
        self.description = description
        self.pageCount = pageCount
        self.mainCategory = mainCategory
        self.averageRating = averageRating
        self.ratingsCount = ratingsCount
        self.language = language
        self.dimensions = dimensions
        self.imageLinks = imageLinks
        self.isLoaned = isLoaned
        self.isMissing = isMissing
        self.quantity = quantity
    }
    
    // Initializer for creating a book from a BookEntity
    init(entity: BookEntity) {
        self.id = entity.id ?? UUID()
        self.title = entity.title ?? "Unknown Title"
        self.author = entity.author ?? "Unknown Author"
        self.publisher = entity.publisher ?? ""
        self.publishedDate = entity.publishedDate ?? ""
        self.description = entity.summary ?? ""
        self.pageCount = entity.pageCount?.intValue ?? 0
        self.mainCategory = entity.mainCategory ?? ""
        self.averageRating = entity.averageRating?.doubleValue ?? 0.0
        self.ratingsCount = entity.ratingsCount?.intValue ?? 0
        self.dimensions = entity.dimensions != nil ? BookObjectDimensions(entity: entity.dimensions!) : nil
        self.imageLinks = entity.imageLinks != nil ? BookObjectImageLinks(entity: entity.imageLinks!) : nil
        self.language = entity.language ?? ""
        self.isLoaned = entity.isLoaned
        self.isMissing = entity.isMissing
        self.quantity = entity.quantity?.intValue ?? 1
    }
}

struct BookObjectDimensions {
    let height: String
    let width: String
    let thickness: String
    
    init(height: String, width: String, thickness: String) {
        self.height = height
        self.width = width
        self.thickness = thickness
    }
    
    init(entity: BookDimensions) {
        self.height = entity.height ?? ""
        self.width = entity.width ?? ""
        self.thickness = entity.thickness ?? ""
    }
    
    func toCoreDataObject(context: NSManagedObjectContext) -> BookDimensions {
        let dimensions = BookDimensions(context: context)
        
        dimensions.height = self.height
        dimensions.width = self.width
        dimensions.thickness = self.thickness
        
        return dimensions
    }
}

struct BookObjectImageLinks {
    let smallThumbnail: String
    let thumbnail: String
    let small: String
    let medium: String
    let large: String
    let extraLarge: String
    
    init(smallThumbnail: String, thumbnail: String, small: String, medium: String, large: String, extraLarge: String) {
        self.smallThumbnail = smallThumbnail
        self.thumbnail = thumbnail
        self.small = small
        self.medium = medium
        self.large = large
        self.extraLarge = extraLarge
    }
    
    init(entity: BookImageLinks) {
        self.smallThumbnail = entity.smallThumbnail ?? ""
        self.thumbnail = entity.thumbnail ?? ""
        self.small = entity.small ?? ""
        self.medium = entity.medium ?? ""
        self.large = entity.large ?? ""
        self.extraLarge = entity.extraLarge ?? ""
    }
    
    func toCoreDataObject(context: NSManagedObjectContext) -> BookImageLinks {
        let imageLinks = BookImageLinks(context: context)
        
        imageLinks.smallThumbnail = self.smallThumbnail
        imageLinks.thumbnail = self.thumbnail
        imageLinks.small = self.small
        imageLinks.medium = self.medium
        imageLinks.large = self.large
        imageLinks.extraLarge = self.extraLarge
        
        return imageLinks
    }
}
