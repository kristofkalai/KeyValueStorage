//
//  GeneralKeyValueStorage.swift
//
//
//  Created by Kristof Kalai on 2022. 12. 29..
//

import Foundation

public final class GeneralKeyValueStorage {
    public enum StorageType {
        case inMemory
        case userDefaults
        case file
    }

    private lazy var inMemoryKeyValueStorage = InMemoryKeyValueStorage()
    private lazy var userDefaultsKeyValueStorage = UserDefaultsKeyValueStorage()
    private lazy var fileKeyValueStorage = FileKeyValueStorage()

    public init() {}
}

extension GeneralKeyValueStorage {
    public func dictionaryRepresentation(storageType: StorageType) -> [String: Data] {
        storage(storageType: storageType).dictionaryRepresentation
    }

    @discardableResult public func save(_ data: Data?, forKey key: String, storageType: StorageType) -> Bool {
        storage(storageType: storageType).save(data, forKey: key)
    }

    public func get(forKey key: String, storageType: StorageType) -> Data? {
        storage(storageType: storageType).get(forKey: key)
    }

    @discardableResult public func delete(forKey key: String, storageType: StorageType) -> Data? {
        storage(storageType: storageType).delete(forKey: key)
    }

    public func has(key: String, storageType: StorageType) -> Bool {
        storage(storageType: storageType).has(key: key)
    }

    public func getAll(storageType: StorageType) -> [Data] {
        storage(storageType: storageType).getAll()
    }

    @discardableResult public func deleteAll(storageType: StorageType) -> [Data] {
        storage(storageType: storageType).deleteAll()
    }

    public func `do`<T>(storageType: StorageType, closure: (KeyValueStorage) -> T) -> T {
        storage(storageType: storageType).do(closure: closure)
    }
}

extension GeneralKeyValueStorage {
    private func storage(storageType: StorageType) -> KeyValueStorage {
        switch storageType {
        case .inMemory: return inMemoryKeyValueStorage
        case .userDefaults: return userDefaultsKeyValueStorage
        case .file: return fileKeyValueStorage
        }
    }
}
