//
//  SearchOverlayView.swift
//  Bookshelf
//
//  Created by Aaron Peterson on 7/24/24.
//

import SwiftUI

import SwiftUI

struct SearchOverlayView: View {
    @ObservedObject var viewModel: BookListViewModel
    @Binding var isPresented: Bool
    
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    isPresented = false
                }) {
                    Image(systemName: "xmark")
                        .foregroundColor(.blue)
                }
                
                Spacer()
            }
            .padding()
            
            SearchBar(text: $viewModel.searchQuery)
                .padding()
            
            List(viewModel.searchResults) { book in
                HStack {
                    if let url = URL(string: book.imageUrl) {
                        AsyncImage(url: url) { image in
                            image.resizable()
                                .frame(width: 50, height: 50)
                                .cornerRadius(8)
                        } placeholder: {
                            ProgressView()
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Text(book.title)
                            .font(.headline)
                        Text(book.author)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                    
                    Button(action:{
                        viewModel.addBookToList(book)
                        isPresented = false
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.blue)
                    }
                }
            }
        }
        .backgroundStyle(Color(.systemBackground).opacity(0.95))
        .cornerRadius(10)
        .shadow(radius: 20)
        .padding()
    }
}

struct SearchOverlayView_Previews: PreviewProvider {
    static var previews: some View {
        SearchOverlayView(viewModel: BookListViewModel(), isPresented: .constant(true))
    }
}
