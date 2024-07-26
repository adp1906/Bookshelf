//
//  BookImageLinks+CoreDataProperties.swift
//  Bookshelf
//
//  Created by Aaron Peterson on 7/25/24.
//
//

import Foundation
import CoreData


extension BookImageLinks {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<BookImageLinks> {
        return NSFetchRequest<BookImageLinks>(entityName: "BookImageLinks")
    }

    @NSManaged public var smallThumbnail: String?
    @NSManaged public var thumbnail: String?
    @NSManaged public var small: String?
    @NSManaged public var medium: String?
    @NSManaged public var large: String?
    @NSManaged public var extraLarge: String?
    @NSManaged public var book: BookEntity?

}

extension BookImageLinks : Identifiable {

}
