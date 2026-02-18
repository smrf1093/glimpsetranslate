import Foundation

struct TranslationResult: Sendable {
    let originalText: String
    let translatedText: String
    let detectedSourceLanguage: String?
    let targetLanguage: String
    let provider: String
    let confidence: Double?
}

enum TranslationError: LocalizedError {
    case invalidURL
    case networkError(String)
    case apiError(String)
    case missingAPIKey
    case emptyText
    case quotaExceeded

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "Invalid translation URL"
        case .networkError(let detail):
            return "Network error: \(detail)"
        case .apiError(let msg):
            return "API error: \(msg)"
        case .missingAPIKey:
            return "API key is required for this provider"
        case .emptyText:
            return "No text to translate"
        case .quotaExceeded:
            return "Translation quota exceeded. Try again tomorrow or switch provider."
        }
    }
}
