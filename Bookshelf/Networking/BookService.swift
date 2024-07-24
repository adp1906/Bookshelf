//
//  BookService.swift
//  Bookshelf
//
//  Created by Aaron Peterson on 7/24/24.
//

import Foundation

class BookService {
    private let baseUrl = "https://www.googleapis.com/books/v1/volumes"
    private let apiKey: String
    
    init() {
        if let path = Bundle.main.path(forResource: "Keys", ofType: "plist"),
                   let keys = NSDictionary(contentsOfFile: path) as? [String: Any],
                   let googleBooksAPIKey = keys["GoogleBooksAPIKey"] as? String {
            self.apiKey = googleBooksAPIKey
        } else {
            fatalError("Google Books API Key is missing!")
        }
    }
    
    @MainActor
    func searchBooks(query: String) async throws -> [Book] {
        guard var urlComponents = URLComponents(string: baseUrl) else {
            throw URLError(.badURL)
        }
        
        urlComponents.queryItems = [
            URLQueryItem(name: "q", value: query),
            URLQueryItem(name: "key", value: apiKey)
        ]
        
        guard let url = urlComponents.url else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        do {
            let response = try JSONDecoder().decode(GoogleBooksResponse.self, from: data)
            
            return response.items?.compactMap { item in
                let imageUrl = item.volumeInfo.imageLinks?.thumbnail?.replacingOccurrences(of: "http://", with: "https://") ?? ""
                return Book(title: item.volumeInfo.title ?? "Unknown Title",
                            author: item.volumeInfo.authors?.first ?? "Unknown Author",
                            imageUrl: imageUrl)
            } ?? []
        } catch {
            print("Decoding Error: \(error)")
            throw error
        }
    }
}
