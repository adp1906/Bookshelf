//
//  BookEntity+CoreDataProperties.swift
//  Bookshelf
//
//  Created by Aaron Peterson on 7/24/24.
//

import Foundation
import CoreData

extension BookEntity {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookEntity> {
        return NSFetchRequest<BookEntity>(entityName: "BookEntity")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var author: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var isLoaned: Bool
}

extension BookEntity: Identifiable {
    
}
