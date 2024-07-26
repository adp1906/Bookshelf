//
//  GoogleBooksResponse.swift
//  Bookshelf
//
//  Created by Aaron Peterson on 7/24/24.
//

import Foundation

struct GoogleBooksResponse: Codable {
    let items: [Item]?
}

struct Item: Codable {
    let kind: String?
    let id: String?
    let etag: String?
    let selfLink: String?
    let volumeInfo: VolumeInfo
}

struct VolumeInfo: Codable {
    let title: String?
    let authors: [String]?
    let publisher: String?
    let publishedDate: String?
    let description: String?
    let pageCount: Int?
    let dimensions: Dimensions?
    let mainCategory: String?
    let averageRating: Double?
    let ratingsCount: Int?
    let imageLinks: ImageLinks?
    let language: String?
}

struct ImageLinks: Codable {
    let smallThumbnail: String?
    let thumbnail: String?
    let small: String?
    let medium: String?
    let large: String?
    let extraLarge: String?
}

struct Dimensions: Codable {
    let height: String?
    let width: String?
    let thickness: String?
}
