import SwiftCompilerPlugin
import SwiftDiagnostics
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros

// MARK: - StaticLogger

public struct StaticLogger: MemberMacro {
    public static func expansion(
        of node: SwiftSyntax.AttributeSyntax,
        providingMembersOf declaration: some SwiftSyntax.DeclGroupSyntax,
        in _: some SwiftSyntaxMacros.MacroExpansionContext
    ) throws -> [SwiftSyntax.DeclSyntax] {
        guard let declarationName = declaration.as(ClassDeclSyntax.self)?.name.text ?? declaration.as(StructDeclSyntax.self)?.name.text ?? declaration.as(EnumDeclSyntax.self)?.name.text else {
            throw Error.unknownDeclaration
        }

        let subsystem: String? = if case let .argumentList(arguments) = node.arguments {
            Array(arguments)
                .first(where: { $0.label?.text == "subsystem" })?
                .expression
                .as(StringLiteralExprSyntax.self)?
                .representedLiteralValue
        } else {
            nil
        }

        let category: String? = if case let .argumentList(arguments) = node.arguments {
            Array(arguments)
                .first(where: { $0.label?.text == "category" })?
                .expression
                .as(StringLiteralExprSyntax.self)?
                .representedLiteralValue
        } else {
            nil
        }

        let syntaxNodeString = "static let logger = Logger(subsystem: \(subsystem != nil ? "\"\(subsystem!)\"" : "Bundle.main.bundleIdentifier ?? \"\""), category: \"\(category != nil ? category! : declarationName)\")"

        return try [DeclSyntax(VariableDeclSyntax(.init(stringLiteral: syntaxNodeString)))]
    }
}

// MARK: StaticLogger.Error

extension StaticLogger {
    enum Error: Swift.Error, CustomStringConvertible {
        case unknownDeclaration

        // MARK: Internal

        var description: String {
            switch self {
            case .unknownDeclaration:
                "Unknown declaration — StaticLogger must be used on a class, struct, or enum"
            }
        }
    }
}

// MARK: - StaticLoggerPlugin

@main struct StaticLoggerPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        StaticLogger.self,
    ]
}
