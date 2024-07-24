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
                
                List {
                    ForEach(viewModel.books) { book in
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
                        }
                    }
                    .onDelete(perform: viewModel.deleteBook)
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
