//
//  BookEntity+CoreDataProperties.swift
//  Bookshelf
//
//  Created by Aaron Peterson on 7/26/24.
//
//

import Foundation
import CoreData


extension BookEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookEntity> {
        return NSFetchRequest<BookEntity>(entityName: "BookEntity")
    }

    @NSManaged public var author: String?
    @NSManaged public var averageRating: NSNumber?
    @NSManaged public var id: UUID?
    @NSManaged public var isLoaned: Bool
    @NSManaged public var language: String?
    @NSManaged public var mainCategory: String?
    @NSManaged public var pageCount: NSNumber?
    @NSManaged public var publishedDate: String?
    @NSManaged public var publisher: String?
    @NSManaged public var ratingsCount: NSNumber?
    @NSManaged public var summary: String?
    @NSManaged public var title: String?
    @NSManaged public var isMissing: Bool
    @NSManaged public var quantity: NSNumber?
    @NSManaged public var dimensions: BookDimensions?
    @NSManaged public var imageLinks: BookImageLinks?

}

extension BookEntity : Identifiable {

}
