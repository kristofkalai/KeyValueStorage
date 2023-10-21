//
//  InMemoryKeyValueStorage.swift
//
//
//  Created by Kristof Kalai on 2022. 12. 29..
//

import Foundation

public final class InMemoryKeyValueStorage {
    private var defaults: [String: Data]

    public init(initialData: [String: Data] = [String: Data]()) {
        defaults = initialData
    }
}

extension InMemoryKeyValueStorage: KeyValueStorage {
    public var dictionaryRepresentation: [String: Data] {
        defaults
    }

    @discardableResult public func save(_ data: Data?, forKey key: String) -> Bool {
        if let data {
            defaults.updateValue(data, forKey: key)
        } else {
            delete(forKey: key)
        }
        return true
    }

    public func get(forKey key: String) -> Data? {
        defaults[key]
    }

    @discardableResult public func delete(forKey key: String) -> Data? {
        defaults.removeValue(forKey: key)
    }
}
