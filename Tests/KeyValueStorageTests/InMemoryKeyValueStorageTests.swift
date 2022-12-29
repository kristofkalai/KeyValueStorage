//
//  InMemoryKeyValueStorageTests.swift
//  
//
//  Created by Kristof Kalai on 2022. 12. 29..
//

import XCTest
import Coder
import KeyValueStorage

final class InMemoryKeyValueStorageTests: BaseStorageTests {}

extension InMemoryKeyValueStorageTests {
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

extension InMemoryKeyValueStorageTests {
    func testGeneralSaveAndGet() {
        let object = firstBook
        let data: Data? = coder.encode(object, type: .json)
        let saveResult = generalStorage.save(data, forKey: key, storageType: .inMemory)
        XCTAssertTrue(saveResult)
        let storedData = generalStorage.get(forKey: key, storageType: .inMemory)
        let decodedObject: Book? = coder.decode(storedData, type: .json)
        XCTAssertEqual(object, decodedObject)
    }

    func testGeneralSaveAndCheck() {
        let object = firstBook
        let data: Data? = coder.encode(object, type: .json)
        let saveResult = generalStorage.save(data, forKey: key, storageType: .inMemory)
        XCTAssertTrue(saveResult)
        let result = generalStorage.has(key: key, storageType: .inMemory)
        XCTAssertTrue(result)
    }

    func testGeneralSaveAndCheckAndDelete() {
        let object = firstBook
        let data: Data? = coder.encode(object, type: .json)
        let saveResult = generalStorage.save(data, forKey: key, storageType: .inMemory)
        XCTAssertTrue(saveResult)
        let result = generalStorage.has(key: key, storageType: .inMemory)
        XCTAssertTrue(result)
        generalStorage.delete(forKey: key, storageType: .inMemory)
        let afterDeleteResult = generalStorage.has(key: key, storageType: .inMemory)
        XCTAssertFalse(afterDeleteResult)
    }

    func testGeneralSaveAndDeleteAndGet() {
        let object = firstBook
        let data: Data? = coder.encode(object, type: .json)
        let saveResult = generalStorage.save(data, forKey: key, storageType: .inMemory)
        XCTAssertTrue(saveResult)
        generalStorage.delete(forKey: key, storageType: .inMemory)
        let result = generalStorage.get(forKey: key, storageType: .inMemory)
        XCTAssertNil(result)
    }

    func testGeneralSaveAndDeleteAllAndGet() {
        let object = firstBook
        let data: Data? = coder.encode(object, type: .json)
        let saveResult = generalStorage.save(data, forKey: key, storageType: .inMemory)
        XCTAssertTrue(saveResult)
        let otherObject = secondBook
        let otherData: Data? = coder.encode(otherObject, type: .json)
        let otherSaveResult = generalStorage.save(otherData, forKey: otherKey, storageType: .inMemory)
        XCTAssertTrue(otherSaveResult)
        XCTAssertEqual(generalStorage.dictionaryRepresentation(storageType: .inMemory).count, 2)
        generalStorage.deleteAll(storageType: .inMemory)
        XCTAssertTrue(generalStorage.dictionaryRepresentation(storageType: .inMemory).isEmpty)
        let result = generalStorage.get(forKey: key, storageType: .inMemory)
        XCTAssertNil(result)
    }

    func testGeneralSaveAndGetAll() {
        let object = firstBook
        let data: Data? = coder.encode(object, type: .json)
        let saveResult = generalStorage.save(data, forKey: key, storageType: .inMemory)
        XCTAssertTrue(saveResult)
        let otherObject = secondBook
        let otherData: Data? = coder.encode(otherObject, type: .json)
        let otherSaveResult = generalStorage.save(otherData, forKey: otherKey, storageType: .inMemory)
        XCTAssertTrue(otherSaveResult)
        XCTAssertEqual(generalStorage.getAll(storageType: .inMemory).count, 2)
    }

    func testGeneralSaveNil() {
        let object = firstBook
        let data: Data? = coder.encode(object, type: .json)
        let firstSaveResult = generalStorage.save(data, forKey: key, storageType: .inMemory)
        XCTAssertTrue(firstSaveResult)
        XCTAssertNotNil(generalStorage.get(forKey: key, storageType: .inMemory))
        let secondSaveResult = generalStorage.save(nil, forKey: key, storageType: .inMemory)
        XCTAssertTrue(secondSaveResult)
        XCTAssertNil(generalStorage.get(forKey: key, storageType: .inMemory))
    }
}
