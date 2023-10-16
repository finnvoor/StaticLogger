# StaticLogger
[![](https://img.shields.io/endpoint?url=https%3A%2F%2Fswiftpackageindex.com%2Fapi%2Fpackages%2FFinnvoor%2FStaticLogger%2Fbadge%3Ftype%3Dplatforms)](https://swiftpackageindex.com/Finnvoor/StaticLogger)

A simple Swift macro that adds a static `logger` method to a class, struct, actor, or enum, with a default subsystem and category based on the bundle identifier and type name.

## Usage

```swift
import OSLog
import StaticLogger

@StaticLogger
struct MyStruct {
    let x: Int

    func test() {
        Self.logger.debug("X is \(x)")
    }
}
```

Expands to:

```swift
struct MyStruct {
    let x: Int

    func test() {
        Self.logger.debug("X is \(x)")
    }

    static let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "", category: "MyStruct")
}
```

You can also override the logger's subsystem or category by passing them to `@StaticLogger`:

```swift
@StaticLogger(subsystem: "MySubsystem", category: "MyCategory")
```
