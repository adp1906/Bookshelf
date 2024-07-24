//
//  BookListViewModel.swift
//  Bookshelf
//
//  Created by Aaron Peterson on 7/24/24.
//

import Foundation
import Combine
import CoreData

class BookListViewModel: ObservableObject {
    @Published var books: [Book] = []
    @Published var searchResults: [Book] = []
    @Published var searchQuery: String = ""

    private var cancellables = Set<AnyCancellable>()
    private let bookService = BookService()
    private let context: NSManagedObjectContext
    
    init(context: NSManagedObjectContext = CoreDataManager.shared.context) {
        self.context = context
        fetchBooks()
        
        $searchQuery
            .debounce(for: .milliseconds(300), scheduler: RunLoop.main)
            .removeDuplicates()
            .sink { [weak self] query in
                self?.searchBooks(query: query)
            }
            .store(in: &cancellables)
    }
    
    private func fetchBooks() {
        let request: NSFetchRequest<BookEntity> = BookEntity.fetchRequest()
        
        do {
            let bookEntities = try context.fetch(request)
            books = bookEntities.map { Book(entity: $0) }
        } catch {
            print("Error fetching books: \(error)")
        }
    }

    private func searchBooks(query: String) {
        Task {
            do {
                let books = try await bookService.searchBooks(query: query)
                
                DispatchQueue.main.async {
                    self.searchResults = books
                }
            } catch {
                print("Error fetching books: \(error)")
            }
        }
    }
    
    func addBookToList(_ book: Book) {
        if !books.contains(where: { $0.id == book.id }) {
            let newBook = BookEntity(context: context)
            newBook.id = book.id
            newBook.title = book.title
            newBook.author = book.author
            newBook.imageUrl = book.imageUrl
            newBook.isLoaned = false
            
            saveContext()
            fetchBooks()
        }
        searchQuery = ""
    }
    
    func deleteBook(at offsets: IndexSet) {
        for index in offsets {
            let book = books[index]
            let request: NSFetchRequest<BookEntity> = BookEntity.fetchRequest()
            request.predicate = NSPredicate(format: "id == %@", book.id as CVarArg)
            
            do {
                let bookEntities = try context.fetch(request)
                if let bookEntity = bookEntities.first {
                    context.delete(bookEntity)
                    saveContext()
                }
            } catch {
                print("Error deleting book: \(error)")
            }
        }
        fetchBooks()
    }
    
    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Error fetching context: \(error)")
        }
    }
    
}
