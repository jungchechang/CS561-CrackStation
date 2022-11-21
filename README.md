# CrackStation, a Decrypter implementation
A decrypter can crack any three-character(including "!?") password.

## Overview
This decrypter can crack unsalted hashes, and it uses a large lookup table to find the password.

## Mission Statement
This decrypter can make people know that unsalted hashes are unreliable.

## Installation
**Swift Package Manager**

The [Swift Package Manager](https://www.swift.org/package-manager/) is "a tool for managing the distribution of Swift code. It's integrated with the Swift build system to automate the process of downloading, compiling, and linking dependencies."

Once you have your Swift package set up, and add CrackStation to the list of dependencies in your in your `Package.swift` file:
```
dependencies: [
        .package(url: "git@github.com:JungCheChang/CrackStation.git", from: "1.1.4"),
    ]
```


## Usage

### The API
`init` will load the .json file for SHA1 and SHA256
```
required public init() {
    do{
        lookupTable = try loadDictionaryFromDisk()
    }
    catch{
        print("Error")
    }
}
```

`decrypt` The function has one parameter, ShaHash and it will return the password corresponding to the ShaHash.
```
public func decrypt(shaHash: String) -> String?
```
### An example
```
import CrackStation
let password = CrackStation().decrypt(shaHash:  "356a192b7913b04c54574d18c28d46e6395428ab")
XCTAssertEqual("1", password)
```

## Author
Jung-Che Chang
