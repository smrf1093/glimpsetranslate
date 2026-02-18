import Foundation

struct MyMemoryProvider: TranslationProvider {
    let name = "MyMemory"
    let requiresAPIKey = false

    private let baseURL = "https://api.mymemory.translated.net/get"

    func translate(text: String, from: String?, to: String) async throws -> TranslationResult {
        let sourceLang = from ?? "autodetect"

        var components = URLComponents(string: baseURL)!
        components.queryItems = [
            URLQueryItem(name: "q", value: text),
            URLQueryItem(name: "langpair", value: "\(sourceLang)|\(to)"),
        ]

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

        let apiResponse = try JSONDecoder().decode(MyMemoryResponse.self, from: data)

        if apiResponse.quotaFinished == true {
            throw TranslationError.quotaExceeded
        }

        guard apiResponse.responseStatus == 200 else {
            throw TranslationError.apiError(apiResponse.responseDetails ?? "Unknown error")
        }

        return TranslationResult(
            originalText: text,
            translatedText: apiResponse.responseData.translatedText,
            detectedSourceLanguage: apiResponse.responseData.detectedLanguage ?? from,
            targetLanguage: to,
            provider: name,
            confidence: apiResponse.responseData.match
        )
    }
}

// MARK: - API Response Models

private struct MyMemoryResponse: Codable {
    let responseData: ResponseData
    let responseStatus: Int
    let responseDetails: String?
    let quotaFinished: Bool?

    struct ResponseData: Codable {
        let translatedText: String
        let match: Double?
        let detectedLanguage: String?
    }
}
