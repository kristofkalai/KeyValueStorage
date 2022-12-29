//
//  FileKeyValueStorageTests.swift
//  
//
//  Created by Kristof Kalai on 2022. 12. 29..
//

import XCTest
import Coder
import KeyValueStorage

final class FileKeyValueStorageTests: BaseStorageTests {}

extension FileKeyValueStorageTests {
    func testSaveAndGet() {
        let object = firstBook
        let data: Data? = coder.encode(object, type: .json)
        let saveResult = storage.save(data, forKey: key)
        XCTAssertTrue(saveResult)
        let storedData = storage.get(forKey: key)
        let decodedObject: Book? = coder.decode(storedData, type: .json)
        XCTAssertEqual(object, decodedObject)
    }

    func testSaveAndCheck() {
        let object = firstBook
        let data: Data? = coder.encode(object, type: .json)
        let saveResult = storage.save(data, forKey: key)
        XCTAssertTrue(saveResult)
        let result = storage.has(key: key)
        XCTAssertTrue(result)
    }

    func testSaveAndCheckAndDelete() {
        let object = firstBook
        let data: Data? = coder.encode(object, type: .json)
        let saveResult = storage.save(data, forKey: key)
        XCTAssertTrue(saveResult)
        let result = storage.has(key: key)
        XCTAssertTrue(result)
        storage.delete(forKey: key)
        let afterDeleteResult = storage.has(key: key)
        XCTAssertFalse(afterDeleteResult)
    }

    func testSaveAndDeleteAndGet() {
        let object = firstBook
        let data: Data? = coder.encode(object, type: .json)
        let saveResult = storage.save(data, forKey: key)
        XCTAssertTrue(saveResult)
        storage.delete(forKey: key)
        let result = storage.get(forKey: key)
        XCTAssertNil(result)
    }

    func testSaveAndDeleteAllAndGet() {
        let object = firstBook
        let data: Data? = coder.encode(object, type: .json)
        let saveResult = storage.save(data, forKey: key)
        XCTAssertTrue(saveResult)
        let otherObject = secondBook
        let otherData: Data? = coder.encode(otherObject, type: .json)
        let otherSaveResult = storage.save(otherData, forKey: otherKey)
        XCTAssertTrue(otherSaveResult)
        XCTAssertEqual(storage.dictionaryRepresentation.count, 2)
        storage.deleteAll()
        XCTAssertTrue(storage.dictionaryRepresentation.isEmpty)
        let result = storage.get(forKey: key)
        XCTAssertNil(result)
    }

    func testSaveAndGetAll() {
        let object = firstBook
        let data: Data? = coder.encode(object, type: .json)
        let saveResult = storage.save(data, forKey: key)
        XCTAssertTrue(saveResult)
        let otherObject = secondBook
        let otherData: Data? = coder.encode(otherObject, type: .json)
        let otherSaveResult = storage.save(otherData, forKey: otherKey)
        XCTAssertTrue(otherSaveResult)
        XCTAssertEqual(storage.getAll().count, 2)
    }

    func testSaveNil() {
        let object = firstBook
        let data: Data? = coder.encode(object, type: .json)
        let firstSaveResult = storage.save(data, forKey: key)
        XCTAssertTrue(firstSaveResult)
        XCTAssertNotNil(storage.get(forKey: key))
        let secondSaveResult = storage.save(nil, forKey: key)
        XCTAssertTrue(secondSaveResult)
        XCTAssertNil(storage.get(forKey: key))
    }
}

extension FileKeyValueStorageTests {
    func testGeneralSaveAndGet() {
        let object = firstBook
        let data: Data? = coder.encode(object, type: .json)
        let saveResult = generalStorage.save(data, forKey: key, storageType: .file)
        XCTAssertTrue(saveResult)
        let storedData = generalStorage.get(forKey: key, storageType: .file)
        let decodedObject: Book? = coder.decode(storedData, type: .json)
        XCTAssertEqual(object, decodedObject)
    }

    func testGeneralSaveAndCheck() {
        let object = firstBook
        let data: Data? = coder.encode(object, type: .json)
        let saveResult = generalStorage.save(data, forKey: key, storageType: .file)
        XCTAssertTrue(saveResult)
        let result = generalStorage.has(key: key, storageType: .file)
        XCTAssertTrue(result)
    }

    func testGeneralSaveAndCheckAndDelete() {
        let object = firstBook
        let data: Data? = coder.encode(object, type: .json)
        let saveResult = generalStorage.save(data, forKey: key, storageType: .file)
        XCTAssertTrue(saveResult)
        let result = generalStorage.has(key: key, storageType: .file)
        XCTAssertTrue(result)
        generalStorage.delete(forKey: key, storageType: .file)
        let afterDeleteResult = generalStorage.has(key: key, storageType: .file)
        XCTAssertFalse(afterDeleteResult)
    }

    func testGeneralSaveAndDeleteAndGet() {
        let object = firstBook
        let data: Data? = coder.encode(object, type: .json)
        let saveResult = generalStorage.save(data, forKey: key, storageType: .file)
        XCTAssertTrue(saveResult)
        generalStorage.delete(forKey: key, storageType: .file)
        let result = generalStorage.get(forKey: key, storageType: .file)
        XCTAssertNil(result)
    }

    func testGeneralSaveAndDeleteAllAndGet() {
        let object = firstBook
        let data: Data? = coder.encode(object, type: .json)
        let saveResult = generalStorage.save(data, forKey: key, storageType: .file)
        XCTAssertTrue(saveResult)
        let otherObject = secondBook
        let otherData: Data? = coder.encode(otherObject, type: .json)
        let otherSaveResult = generalStorage.save(otherData, forKey: otherKey, storageType: .file)
        XCTAssertTrue(otherSaveResult)
        XCTAssertEqual(generalStorage.dictionaryRepresentation(storageType: .file).count, 2)
        generalStorage.deleteAll(storageType: .file)
        XCTAssertTrue(generalStorage.dictionaryRepresentation(storageType: .file).isEmpty)
        let result = generalStorage.get(forKey: key, storageType: .file)
        XCTAssertNil(result)
    }

    func testGeneralSaveAndGetAll() {
        let object = firstBook
        let data: Data? = coder.encode(object, type: .json)
        let saveResult = generalStorage.save(data, forKey: key, storageType: .file)
        XCTAssertTrue(saveResult)
        let otherObject = secondBook
        let otherData: Data? = coder.encode(otherObject, type: .json)
        let otherSaveResult = generalStorage.save(otherData, forKey: otherKey, storageType: .file)
        XCTAssertTrue(otherSaveResult)
        XCTAssertEqual(generalStorage.getAll(storageType: .file).count, 2)
    }

    func testGeneralSaveNil() {
        let object = firstBook
        let data: Data? = coder.encode(object, type: .json)
        let firstSaveResult = generalStorage.save(data, forKey: key, storageType: .file)
        XCTAssertTrue(firstSaveResult)
        XCTAssertNotNil(generalStorage.get(forKey: key, storageType: .file))
        let secondSaveResult = generalStorage.save(nil, forKey: key, storageType: .file)
        XCTAssertTrue(secondSaveResult)
        XCTAssertNil(generalStorage.get(forKey: key, storageType: .file))
    }
}
