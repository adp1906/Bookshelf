//
//  BookDimensions+CoreDataProperties.swift
//  Bookshelf
//
//  Created by Aaron Peterson on 7/25/24.
//
//

import Foundation
import CoreData


extension BookDimensions {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookDimensions> {
        return NSFetchRequest<BookDimensions>(entityName: "BookDimensions")
    }

    @NSManaged public var height: String?
    @NSManaged public var width: String?
    @NSManaged public var thickness: String?
    @NSManaged public var book: BookEntity?

}

extension BookDimensions : Identifiable {

}
