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
    let imageLinks: ImageLinks?
}

struct ImageLinks: Codable {
    let thumbnail: String?
}
