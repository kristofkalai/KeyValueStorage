//
//  UserDefaultsKeyValueStorage.swift
//
//
//  Created by Kristof Kalai on 2022. 12. 29..
//

import Foundation

public final class UserDefaultsKeyValueStorage {
    private let defaults: UserDefaults

    public init(defaults: UserDefaults = .init()) {
        self.defaults = defaults
    }
}

extension UserDefaultsKeyValueStorage: KeyValueStorage {
    public var dictionaryRepresentation: [String: Data] {
        defaults.dictionaryRepresentation().compactMapValues { $0 as? Data }
    }

    @discardableResult public func save(_ data: Data?, forKey key: String) -> Bool {
        defaults.set(data, forKey: key)
        return true
    }

    public func get(forKey key: String) -> Data? {
        defaults.data(forKey: key)
    }

    @discardableResult public func delete(forKey key: String) -> Data? {
        let object = get(forKey: key)
        defaults.removeObject(forKey: key)
        return object
    }
}
