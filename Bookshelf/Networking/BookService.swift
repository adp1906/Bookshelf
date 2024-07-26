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
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(GoogleBooksResponse.self, from: data)
            
            return response.items?.compactMap { item in
                let imageLinks = BookObjectImageLinks(smallThumbnail: item.volumeInfo.imageLinks?.smallThumbnail?.replacingOccurrences(of: "http://", with: "https://") ?? "",
                                                      thumbnail: item.volumeInfo.imageLinks?.thumbnail?.replacingOccurrences(of: "http://", with: "https://") ?? "",
                                                      small: item.volumeInfo.imageLinks?.small?.replacingOccurrences(of: "http://", with: "https://") ?? "",
                                                      medium: item.volumeInfo.imageLinks?.medium?.replacingOccurrences(of: "http://", with: "https://") ?? "",
                                                      large: item.volumeInfo.imageLinks?.large?.replacingOccurrences(of: "http://", with: "https://") ?? "",
                                                      extraLarge: item.volumeInfo.imageLinks?.extraLarge?.replacingOccurrences(of: "http://", with: "https://") ?? "")
                
                return Book(title: item.volumeInfo.title ?? "Unknown Title",
                            author: item.volumeInfo.authors?.first ?? "Unknown Author",
                            publisher: item.volumeInfo.publisher ?? "",
                            publishedDate: item.volumeInfo.publishedDate ?? "",
                            description: item.volumeInfo.description ?? "",
                            pageCount: item.volumeInfo.pageCount ?? 0,
                            mainCategory: item.volumeInfo.mainCategory ?? "",
                            averageRating: item.volumeInfo.averageRating ?? 0,
                            ratingsCount: item.volumeInfo.ratingsCount ?? 0,
                            language: item.volumeInfo.language ?? "",
                            imageLinks: imageLinks)
            } ?? []
        } catch {
            print("Decoding Error: \(error)")
            throw error
        }
    }
}
