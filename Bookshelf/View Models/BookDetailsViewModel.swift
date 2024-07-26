//
//  BookDetailsViewModel.swift
//  Bookshelf
//
//  Created by Aaron Peterson on 7/24/24.
//

import Foundation
import CoreData

class BookDetailsViewModel: ObservableObject {
    @Published var book: Book
    private let context: NSManagedObjectContext
    
    init(book: Book, context: NSManagedObjectContext = CoreDataManager.shared.context) {
        self.book = book
        self.context = context
    }
    
    func toggleLoanedStatus() {
        let request: NSFetchRequest<BookEntity> = BookEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", book.id as CVarArg)
        
        do {
            let bookEntities = try context.fetch(request)
            if let bookEntity = bookEntities.first {
                bookEntity.isLoaned.toggle()
                saveContext()
                book.isLoaned = bookEntity.isLoaned
            }
        } catch {
            print("Error updating book: \(error)")
        }
    }
    
    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
}
