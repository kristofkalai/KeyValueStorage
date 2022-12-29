//
//  BaseStorageTests.swift
//  
//
//  Created by Kristof Kalai on 2022. 12. 29..
//

import XCTest
import Coder
import KeyValueStorage

class BaseStorageTests: XCTestCase {
    let coder = Coder()
    let storage = FileKeyValueStorage()
    let generalStorage = GeneralKeyValueStorage()
    let key = "KEY"
    let otherKey = "OTHERKEY"
}
