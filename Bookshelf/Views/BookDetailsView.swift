//
//  BookDetailsView.swift
//  Bookshelf
//
//  Created by Aaron Peterson on 7/26/24.
//

import SwiftUI

struct BookDetailsView: View {
    @ObservedObject var viewModel: BookDetailsViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                if let url = URL(string: viewModel.book.imageLinks?.thumbnail ?? "") {
                    AsyncImage(url: url) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity)
                            .cornerRadius(8)
                    } placeholder: {
                        ProgressView()
                    }
                } else {
                    Image(systemName: "book")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .cornerRadius(8)
                }
                
                Text(viewModel.book.title)
                    .font(.largeTitle)
                    .padding(.top)
                
                Text("Author: \(viewModel.book.author)")
                    .font(.title2)
                    .padding(.vertical, 2)
                
                Text("Publisher: \(viewModel.book.publisher)")
                    .font(.title3)
                    .padding(.vertical, 2)
                
                Text("Published Date: \(viewModel.book.publishedDate)")
                    .font(.subheadline)
                    .padding(.vertical, 2)

                Text(viewModel.book.description)
                    .font(.body)
                    .padding(.top)
                
                HStack {
                    Text("Page Count: \(viewModel.book.pageCount)")
                    Spacer()
                    Text("Rating: \(String(format: "%.2f", viewModel.book.averageRating))/5 (\(viewModel.book.ratingsCount) reviews)")
                }
                .font(.subheadline)
                .padding(.top)
                
                HStack {
                    Toggle(isOn: Binding(
                        get: { viewModel.book.isLoaned },
                        set: { newValue in
                            viewModel.toggleLoanedStatus()
                        })) {
                            Text("Loaned")
                        }
                        .disabled(viewModel.book.isMissing)
                    
                    Toggle(isOn: Binding(
                        get: { viewModel.book.isMissing },
                        set: { newValue in
                            viewModel.toggleMissingStatus()
                        })) {
                            Text("Missing")
                        }
                        .disabled(viewModel.book.isLoaned)
                }
                .padding(.top)
                
                HStack {
                    Text("Quantity: \(viewModel.book.quantity)")
                        .font(.title2)
                        .padding(.vertical, 2)
                    
                    Spacer()
                    
                    Button(action: {
                        viewModel.decreaseQuantity()
                    }) {
                        Image(systemName: "minus.circle.fill")
                            .foregroundColor(.red)
                            .font(.title)
                    }
                    .padding(.horizontal, 8)
                    
                    Button(action: {
                        viewModel.increaseQuantity()
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .foregroundColor(.red)
                            .font(.title)
                    }
                }
                .padding(.top)
                
                Button(action: {
                    viewModel.deleteBook()
                }) {
                    Text("Delete Book")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(8)
                }
                .padding(.top)
            }
            .padding()
        }
        .navigationTitle(viewModel.book.title)
        .navigationBarTitleDisplayMode(.inline)
        .onChange(of: viewModel.shouldDismiss) { shouldDismiss in
            if shouldDismiss {
                presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct BookDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        BookDetailsView(viewModel: BookDetailsViewModel(book: Book(id: UUID(),
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
                                                                isLoaned: false,
                                                                isMissing: false,
                                                                quantity: 1),
                                                        context: CoreDataManager.shared.context, onBookChanged: {}))
    }
}
