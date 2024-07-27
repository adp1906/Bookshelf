//
//  BookGridViewModel.swift
//  Bookshelf
//
//  Created by Aaron Peterson on 7/27/24.
//

import Foundation
import Combine
import CoreData

class BookGridViewModel: ObservableObject {
    @Published var books: [Book]
    let context: NSManagedObjectContext
    
    private var cancellables = Set<AnyCancellable>()
    
    init(books: [Book], context: NSManagedObjectContext = CoreDataManager.shared.context) {
        self.books = books
        self.context = context
    }
}
