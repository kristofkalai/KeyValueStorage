//
//  FileKeyValueStorage.swift
//  
//
//  Created by Kristof Kalai on 2022. 12. 29..
//

import Foundation

public final class FileKeyValueStorage {
    private var documentsDirectory: URL {
        if #available(iOS 16.0, *) {
            return URL.documentsDirectory
        } else {
            return fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        }
    }

    private var rootUrl: URL {
        documentsDirectory.appendingPathComponent("\(separator)")
    }

    private func url(forKey key: String) -> URL {
        rootUrl.appendingPathComponent("\(key)")
    }

    private let fileManager: FileManager
    private let separator: String

    public init(fileManager: FileManager = .default, separator: String = "fileKeyValueStorage") {
        self.fileManager = fileManager
        self.separator = separator
        checkDirectories()
    }
}

extension FileKeyValueStorage {
    private func checkDirectories() {
        if !fileManager.fileExists(atPath: rootUrl.path) {
            try? fileManager.createDirectory(at: rootUrl, withIntermediateDirectories: false)
        }
    }
}

extension FileKeyValueStorage: KeyValueStorage {
    public var dictionaryRepresentation: [String: Data] {
        var objects = [String: Data]()
        try? fileManager.contentsOfDirectory(at: rootUrl, includingPropertiesForKeys: [])
            .filter { $0.path.contains(rootUrl.path) }
            .map(\.path)
            .compactMap {
                var absoluteString = $0
                absoluteString.removeAll { $0 == "/" }
                let components = absoluteString.components(separatedBy: separator)
                return Array(components.dropFirst()).first
            }
            .forEach {
                guard let value = get(forKey: $0) else { return }
                objects.updateValue(value, forKey: $0)
            }
        return objects
    }

    @discardableResult public func save(_ data: Data?, forKey key: String) -> Bool {
        checkDirectories()
        let url = url(forKey: key)
        do {
            if let data {
                if fileManager.fileExists(atPath: url.path) {
                    try data.write(to: url)
                } else {
                    fileManager.createFile(atPath: url.path, contents: data)
                }
            } else {
                if fileManager.fileExists(atPath: url.path) {
                    try fileManager.removeItem(atPath: url.path)
                }
            }
            return true
        } catch {
            return false
        }
    }

    public func get(forKey key: String) -> Data? {
        checkDirectories()
        do {
            let result = try Data(contentsOf: url(forKey: key))
            return result
        } catch {
            return nil
        }
    }

    @discardableResult public func delete(forKey key: String) -> Data? {
        checkDirectories()
        let path = url(forKey: key).path
        let value = get(forKey: key)
        if fileManager.fileExists(atPath: path) {
            try? fileManager.removeItem(atPath: path)
        }
        return value
    }
}
