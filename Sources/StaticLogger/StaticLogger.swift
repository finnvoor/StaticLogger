// Adds a static `logger` member to the type.
// - Parameters:
//   - subsystem: An optional subsystem for the logger to use. Defaults to `Bundle.main.bundleIdentifier`.
//   - category: An optional category for the logger to use. Defaults to `String(describing: Self.self)`.
@attached(member, names: named(logger)) public macro StaticLogger(
    subsystem: String? = nil,
    category: String? = nil
) = #externalMacro(module: "StaticLoggerMacros", type: "StaticLogger")
