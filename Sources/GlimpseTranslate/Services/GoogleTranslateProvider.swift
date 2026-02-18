import Foundation

struct GoogleTranslateProvider: TranslationProvider {
    let name = "Google Translate"
    let requiresAPIKey = true

    private let baseURL = "https://translation.googleapis.com/language/translate/v2"

    func translate(text: String, from: String?, to: String) async throws -> TranslationResult {
        guard let apiKey = UserDefaults.standard.string(forKey: "googleTranslateAPIKey"),
              !apiKey.isEmpty else {
            throw TranslationError.missingAPIKey
        }

        var components = URLComponents(string: baseURL)!
        components.queryItems = [
            URLQueryItem(name: "q", value: text),
            URLQueryItem(name: "target", value: to),
            URLQueryItem(name: "key", value: apiKey),
            URLQueryItem(name: "format", value: "text"),
        ]
        if let source = from {
            components.queryItems?.append(URLQueryItem(name: "source", value: source))
        }

        guard let url = components.url else {
            throw TranslationError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse else {
            throw TranslationError.networkError("Invalid response")
        }

        guard httpResponse.statusCode == 200 else {
            throw TranslationError.networkError("HTTP \(httpResponse.statusCode)")
        }

        let apiResponse = try JSONDecoder().decode(GoogleResponse.self, from: data)
        let translation = apiResponse.data.translations.first

        return TranslationResult(
            originalText: text,
            translatedText: translation?.translatedText ?? "",
            detectedSourceLanguage: translation?.detectedSourceLanguage ?? from,
            targetLanguage: to,
            provider: name,
            confidence: nil
        )
    }
}

private struct GoogleResponse: Codable {
    let data: DataContainer

    struct DataContainer: Codable {
        let translations: [Translation]
    }

    struct Translation: Codable {
        let translatedText: String
        let detectedSourceLanguage: String?
    }
}
