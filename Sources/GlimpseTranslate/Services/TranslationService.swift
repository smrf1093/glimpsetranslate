import Foundation

protocol TranslationProvider: Sendable {
    var name: String { get }
    var requiresAPIKey: Bool { get }
    func translate(text: String, from: String?, to: String) async throws -> TranslationResult
}

enum TranslationProviderType: String, CaseIterable, Codable, Sendable {
    case myMemory = "MyMemory"
    case google = "Google Translate"
}

@MainActor
final class TranslationService: ObservableObject {
    @Published var currentProviderType: TranslationProviderType = .myMemory
    @Published var isTranslating: Bool = false

    private let providers: [TranslationProviderType: TranslationProvider] = [
        .myMemory: MyMemoryProvider(),
        .google: GoogleTranslateProvider(),
    ]

    var currentProvider: TranslationProvider {
        providers[currentProviderType] ?? providers[.myMemory]!
    }

    func translate(text: String, from: String? = nil, to: String) async throws -> TranslationResult {
        isTranslating = true
        defer { isTranslating = false }

        let provider = currentProvider
        return try await provider.translate(text: text, from: from, to: to)
    }
}
