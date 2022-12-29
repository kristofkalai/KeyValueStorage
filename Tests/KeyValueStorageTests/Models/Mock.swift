//
//  Mock.swift
//  
//
//  Created by Kristof Kalai on 2022. 12. 29..
//

import Foundation

fileprivate struct Helper {
    private static func page(prefix: String, bookPrefix: String) -> Page {
        Page(text: "\(bookPrefix) codable book \(prefix) codable page text")
    }

    private static func pages(bookPrefix: String) -> [Page] {
        [page(prefix: "first", bookPrefix: bookPrefix), page(prefix: "second", bookPrefix: bookPrefix)]
    }

    private static func book(prefix: String, pages: [Page], price: Double) -> Book {
        Book(title: "\(prefix) codable book title",
             author: "\(prefix) codable book author", pages: pages,
             price: price)
    }

    static func book(prefix: String, price: Double) -> Book {
        book(prefix: prefix, pages: pages(bookPrefix: prefix), price: price)
    }
}

let firstBook = Helper.book(prefix: "first", price: 1.99)
let secondBook = Helper.book(prefix: "second", price: 2.99)
