# StaticLogger
A simple Swift macro that adds a static `logger` method to a class, struct, or enum, with a default subsystem and category based on the bundle identifier and type name.

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
