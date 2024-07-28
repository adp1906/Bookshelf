//
//  ContentView.swift
//  Bookshelf
//
//  Created by Aaron Peterson on 7/24/24.
//

import SwiftUI

struct BookListView: View {
    @StateObject var viewModel = BookListViewModel()
    @State private var isSearchOverlayPresented = false
    @State private var isGridView = false
    @State private var selectedBook: Book?
    
    var body: some View {
        NavigationView {
            VStack {
                Button(action: {
                    isSearchOverlayPresented = true
                }) {
                    Text("Search for Books")
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
                
                Toggle(isOn: $isGridView) {
                    Text("Grid View")
                }
                .padding()
                
                if isGridView {
                    BookGridView(viewModel: BookGridViewModel(books: viewModel.books))
                } else {
                    List {
                        ForEach(viewModel.books) { book in
                            NavigationLink(destination: BookDetailsView(viewModel: BookDetailsViewModel(book: book, context: viewModel.context, onBookChanged: {
                                viewModel.fetchBooks()
                            }))) {
                                HStack {
                                    if let url = URL(string: book.imageLinks?.thumbnail ?? "") {
                                        AsyncImage(url: url) { image in
                                            image.resizable()
                                                .aspectRatio(contentMode: .fit)
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
                                    
                                    if book.isMissing {
                                        Image(systemName: "exclamationmark.triangle.fill")
                                            .foregroundColor(.red)
                                    }
                                    
                                    if book.isLoaned {
                                        Image(systemName: "book.fill")
                                            .foregroundColor(.yellow)
                                    }
                                }
                                .contentShape(Rectangle())
                            }
                        }
                        .onDelete(perform: viewModel.deleteBook)
                    }
                }
            }
            .navigationTitle("My Book Collection")
            .overlay(
                Group {
                    if isSearchOverlayPresented {
                        Color.black.opacity(0.4)
                            .edgesIgnoringSafeArea(.all)
                        SearchOverlayView(viewModel: viewModel, isPresented: $isSearchOverlayPresented)
                            .transition(.move(edge: .bottom))
                    }
                }
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        BookListView()
    }
}
