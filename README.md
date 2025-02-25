<p align="center">
  <img width="640px" src="https://user-images.githubusercontent.com/40610/229582719-89359acd-8b1e-4a88-9bc2-0a269afcadbd.png" />
</p>

# Swift Power Assert

Power asserts (also known as diagrammed assertions) augment your assertion failures with information about the values produced during evaluation of a condition, and present it in an easily digestible form. Power asserts are a popular feature of [Spock](https://github.com/spockframework/spock) (and later the entire [Groovy](https://github.com/apache/groovy) language independent of Spock), [ScalaTest](http://www.scalatest.org/) and [Expecty](https://github.com/pniederw/expecty).

Power asserts provide descriptive assertion messages for your tests, like the following examples:

```swift
#powerAssert(max(a, b) == c)
             |   |  |  |  |
             7   4  7  |  12
                       false

#powerAssert(xs.contains(4))
             |  |        |
             |  false    4
             [1, 2, 3]

#powerAssert("hello".hasPrefix("h") && "goodbye".hasSuffix("y"))
             |       |         |    |  |         |         |
             "hello" true      "h"  |  "goodbye" false     "y"
                                    false
```

## Why Power Assert?

When writing tests, we need to use different assertion functions. With Power Assert you only use the `#powerAssert()` function. There are many
Assertion APIs, no need to remember them. Just create an expression that returns a boolean value and Power Assert will automatically display rich error information.

## Getting Started

Swift Power Assert is implemented using [macros](https://github.com/apple/swift-evolution/blob/main/proposals/0382-expression-macros.md), an experimental feature of Swift. Therefore, you must use the pre-release version of the Swift toolchain to use this library.

1. Download and install the toolchain from [the development snapshot on Swift.org](https://www.swift.org/download/) after March 31, 2023.
2. Set the toolchain identifier in the `TOOLCHAINS` environment variable to use the pre-release toolchain.
   For example:

   ```shell
   export TOOLCHAINS=org.swift.59202303301a
   ```

   Note: To find out the toolchain identifier, check the Info.plist in the toolchain. Toolchains are usually installed in `/Library/Developer/Toolchains/'. Right-click on the toolchain icon and select "Show Package Contents" to find the Info.plist; the value of the Bundle Identifier key in the Info.plist is the toolchain identifier.
   For more information, see Sarun's excellent article.
   https://sarunw.com/posts/how-to-use-pre-release-swift-version-with-command-line-tools/

## Check it out

To see PowerAssert in action, go to the Examples directory and run `swift test`.

```shell
$ cd Example
$ swift test
```

See the following results?

```shell
...
Test Suite 'All tests' started at 2023-04-05 07:17:58.800
Test Suite 'swift-power-assert-examplePackageTests.xctest' started at 2023-04-05 07:17:58.801
Test Suite 'PowerAssertTests' started at 2023-04-05 07:17:58.801
Test Case '-[ExampleTests.PowerAssertTests testExample]' started.
/swift-power-assert/Example/"ExampleTests/ExampleTests.swift":8: error: -[ExampleTests.PowerAssertTests testExample] : failed -
#powerAssert(a * b == 91)
             |   | |  |
             10  9 |  91
                   false
/swift-power-assert/Example/"ExampleTests/ExampleTests.swift":11: error: -[ExampleTests.PowerAssertTests testExample] : failed -
#powerAssert(xs.contains(4))
             |  |        |
             |  false    4
             [1, 2, 3]
...
```

Modify the code in `Example/Tests/ExampleTests.swift` to try different patterns you like.

## Usage

To use Swift Power Assert in your library or application, first add SwiftPowerAssert to the Swift package manager.

```swift
// swift-tools-version:5.8
import PackageDescription

let package = Package(
  name: "MyLibrary",
  dependencies: [
    ...,
    .package(
        url: "https://github.com/kishikawakatsumi/swift-power-assert.git",
        branch: "main"
    ),
  ],
  targets: [
    ...,
    .testTarget(
      name: "MyLibraryTests", .
      Dependencies: [
        ...,
        .product(name: "PowerAssert", package: "swift-power-assert"),
      ]
    ),
  ]
)
```

Next, you can use Power Assert in your tests with the `#powerAssert()` macro.

```swift
// MyLibraryTests.swift
import XCTest
import PowerAssert
@testable import MyLibrary

final class MyLibraryTests: XCTestCase {
  func testExample() {
    let a = 7
    let b = 4
    let c = 12

    #powerAssert(max(a, b) == c)
  }
}
```

## Testing assistance requested

Swift Power Assert is still in the early stages of development. If you could help us with testing, we would greatly appreciate it! Please try different code patterns using this library and report any problems you encounter. We welcome your feedback and improvement suggestions. Thank you very much!

## Frequently Asked Questions

**Q: I want to display the result even if the test is successful (i.e. the expression in the `#powerAssert()` function evaluates to `true`).**

A: By default, the `#powerAssert()` function does not display the result if the expression evaluates to `true`, because the test was successful. To always print the result, set the `verbose` argument to true.

For example:

```swift
#powerAssert(x == y, verbose: true)
```

## Author

[Kishikawa Katsumi](https://github.com/kishikawakatsumi)

## License

The project is released under the [MIT License](https://github.com/kishikawakatsumi/SwiftPowerAssert/blob/master/LICENSE.txt)
