# KeyValueStorage
Store any data on the device! 🧳

## Setup

Add the following to `Package.swift`:

```swift
.package(url: "https://github.com/stateman92/KeyValueStorage", exact: .init(0, 0, 2))
```

[Or add the package in Xcode.](https://developer.apple.com/documentation/xcode/adding_package_dependencies_to_your_app)

## Usage

```swift
import KeyValueStorage

struct CodablePage {
    let text: String
}

extension CodablePage: Codable {}

let coder = Coder()
let object = CodablePage(text: "Text")
let data: Data? = coder.encode(object, type: .json)
let storageData = UserDefaultsKeyValueStorage().do {
    let key = "KEY"
    $0.save(data, forKey: key)
    return $0.get(forKey: key)
}
let result: CodablePage? = coder.decode(storageData, type: .json)
// object.text == result?.text
```

For details see the Example app.

## Tests

The library is well-tested with practically 100% coverage (96.0%).
