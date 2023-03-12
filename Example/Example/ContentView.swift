//
//  ContentView.swift
//  Example
//
//  Created by Kristóf Kálai on 2023. 03. 12..
//

import KeyValueStorage
import SwiftUI

struct ContentView: View {
    var body: some View {
        Text("Hello, world!")
            .onAppear(perform: keyValueStorageTestMethod)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

private func keyValueStorageTestMethod() {
    struct Page: Codable {
        let text: String
    }

    let coder = Coder()
    let object = Page(text: "Text")
    let data: Data? = coder.encode(object, type: .json)
    let storageData = UserDefaultsKeyValueStorage().do {
        let key = "KEY"
        $0.save(data, forKey: key)
        return $0.get(forKey: key)
    }
    let result: Page? = coder.decode(storageData, type: .json)
    assert(object.text == result?.text)
}
