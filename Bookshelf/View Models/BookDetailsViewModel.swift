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
    @Published var shouldDismiss = false
    private let context: NSManagedObjectContext
    var onBookChanged: (() -> Void)?
    
    init(book: Book, context: NSManagedObjectContext, onBookChanged: (() -> Void)?) {
        self.book = book
        self.context = context
        self.onBookChanged = onBookChanged
    }
    
    func toggleLoanedStatus() {
        book.isLoaned.toggle()
        if book.isLoaned {
            book.isMissing = false
        }
        saveChanges()
    }
    
    func toggleMissingStatus() {
        book.isMissing.toggle()
        if book.isMissing {
            book.isLoaned = false
        }
        saveChanges()
    }
    
    func increaseQuantity() {
        book.quantity += 1
        saveChanges()
    }
    
    func decreaseQuantity() {
        if book.quantity > 1 {
            book.quantity -= 1
            saveChanges()
        }
    }
    
    func deleteBook() {
        let request: NSFetchRequest<BookEntity> = BookEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", book.id as CVarArg)
        
        do {
            let bookEntities = try context.fetch(request)
            if let bookEntity = bookEntities.first {
                context.delete(bookEntity)
                try context.save()
                shouldDismiss = true
                onBookChanged?()
            }
        } catch {
            print("Error deleting book: \(error)")
        }
    }
    
    private func saveChanges() {
        let request: NSFetchRequest<BookEntity> = BookEntity.fetchRequest()
        request.predicate = NSPredicate(format: "id == %@", book.id as CVarArg)
        
        do {
            let bookEntities = try context.fetch(request)
            if let bookEntity = bookEntities.first {
                bookEntity.isLoaned = book.isLoaned
                bookEntity.isMissing = book.isMissing
                bookEntity.quantity = NSNumber(value: book.quantity)
                try context.save()
                onBookChanged?()
            }
        } catch {
            print("Error saving changes: \(error)")
        }
    }
}
