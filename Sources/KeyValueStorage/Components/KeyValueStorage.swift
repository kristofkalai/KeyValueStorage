//
//  KeyValueStorage.swift
//
//
//  Created by Kristof Kalai on 2022. 12. 29..
//

import Foundation

public protocol KeyValueStorage {
    var dictionaryRepresentation: [String: Data] { get }
    @discardableResult func save(_ data: Data?, forKey key: String) -> Bool
    func get(forKey key: String) -> Data?
    @discardableResult func delete(forKey key: String) -> Data?
}

extension KeyValueStorage {
    public func has(key: String) -> Bool {
        get(forKey: key) != nil
    }

    public func getAll() -> [Data] {
        Array(dictionaryRepresentation.values.compactMap { $0 })
    }

    @discardableResult public func deleteAll() -> [Data] {
        dictionaryRepresentation.map { delete(forKey: $0.key) }.compactMap { $0 }
    }

    public func `do`<T>(closure: (Self) -> T) -> T {
        closure(self)
    }
}
