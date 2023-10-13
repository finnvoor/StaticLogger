import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

#if canImport(StaticLoggerMacros)
import StaticLoggerMacros

let testMacros: [String: Macro.Type] = [
    "StaticLogger": StaticLogger.self,
]
#endif

// MARK: - StaticLoggerTests

final class StaticLoggerTests: XCTestCase {
    func testDefaults() throws {
        #if canImport(StaticLoggerMacros)
        assertMacroExpansion(
            """
            @StaticLogger
            struct MyStruct {
                let x: Int
            }
            """,
            expandedSource: """
            struct MyStruct {
                let x: Int

                static let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "", category: "MyStruct")
            }
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }

    func testSubsystem() throws {
        #if canImport(StaticLoggerMacros)
        assertMacroExpansion(
            """
            @StaticLogger(subsystem: "MySubsystem")
            struct MyStruct {
                let x: Int
            }
            """,
            expandedSource: """
            struct MyStruct {
                let x: Int

                static let logger = Logger(subsystem: "MySubsystem", category: "MyStruct")
            }
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }

    func testCategory() throws {
        #if canImport(StaticLoggerMacros)
        assertMacroExpansion(
            """
            @StaticLogger(category: "MyCategory")
            struct MyStruct {
                let x: Int
            }
            """,
            expandedSource: """
            struct MyStruct {
                let x: Int

                static let logger = Logger(subsystem: Bundle.main.bundleIdentifier ?? "", category: "MyCategory")
            }
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }

    func testSubsystemAndCategory() throws {
        #if canImport(StaticLoggerMacros)
        assertMacroExpansion(
            """
            @StaticLogger(subsystem: "MySubsystem", category: "MyCategory")
            struct MyStruct {
                let x: Int
            }
            """,
            expandedSource: """
            struct MyStruct {
                let x: Int

                static let logger = Logger(subsystem: "MySubsystem", category: "MyCategory")
            }
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
}
