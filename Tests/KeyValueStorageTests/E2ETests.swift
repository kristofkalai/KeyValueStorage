//
//  E2ETests.swift
//  
//
//  Created by Kristof Kalai on 2022. 12. 29..
//

import XCTest
import Coder
import KeyValueStorage

final class E2ETests: XCTestCase {
    private let key = "KEY"
}

extension E2ETests {
    func testE2E() {
        let coder = Coder()
        let object = firstBook
        let data: Data? = coder.encode(object, type: .json)
        let storageData = UserDefaultsKeyValueStorage().do {
            $0.save(data, forKey: key)
            return $0.get(forKey: key)
        }
        let result: Book? = coder.decode(storageData, type: .json)
        XCTAssertEqual(result, object)
    }

    func testGeneralE2E() {
        let coder = Coder()
        let object = firstBook
        let data: Data? = coder.encode(object, type: .json)
        let storageData = GeneralKeyValueStorage().do(storageType: .inMemory) {
            $0.save(data, forKey: key)
            return $0.get(forKey: key)
        }
        let result: Book? = coder.decode(storageData, type: .json)
        XCTAssertEqual(result, object)
    }
}
