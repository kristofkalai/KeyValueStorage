//
//  Book.swift
//  
//
//  Created by Kristof Kalai on 2022. 12. 29..
//

struct Book {
    let title: String
    let author: String
    let pages: [Page]
    let price: Double

    var pageCount: Int {
        pages.count
    }
}

extension Book: Codable {}

extension Book: Equatable {}
