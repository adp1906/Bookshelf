//
//  BookGridView.swift
//  Bookshelf
//
//  Created by Aaron Peterson on 7/24/24.
//

import SwiftUI

struct BookGridView: View {
    var books: [Book]
    var columns: [GridItem] = Array(repeating: .init(.flexible()), count: 3)
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(books) { book in
                    if let url = URL(string: book.imageLinks?.thumbnail ?? "") {
                        AsyncImage(url: url) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                                .cornerRadius(8)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                }
            }
        }
        .padding()
    }
}

struct BookGridView_Previews: PreviewProvider {
    static var previews: some View {
        BookGridView(books: [Book(id: UUID(),
                                  title: "Sample Book",
                                  author: "Sample Author",
                                  publisher: "",
                                  publishedDate: "",
                                  description: "",
                                  pageCount: 100,
                                  mainCategory: "",
                                  averageRating: 5.0,
                                  ratingsCount: 100,
                                  language: "",
                                  isLoaned: false)])
    }
}
