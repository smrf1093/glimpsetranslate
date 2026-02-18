import Foundation

struct LanguageInfo: Identifiable {
    let code: String
    let name: String
    var id: String { code }
}

enum LanguageCodes {
    static let commonLanguages: [LanguageInfo] = [
        LanguageInfo(code: "en", name: "English"),
        LanguageInfo(code: "es", name: "Spanish"),
        LanguageInfo(code: "fr", name: "French"),
        LanguageInfo(code: "de", name: "German"),
        LanguageInfo(code: "it", name: "Italian"),
        LanguageInfo(code: "pt", name: "Portuguese"),
        LanguageInfo(code: "ja", name: "Japanese"),
        LanguageInfo(code: "ko", name: "Korean"),
        LanguageInfo(code: "zh", name: "Chinese (Simplified)"),
        LanguageInfo(code: "fa", name: "Persian (Farsi)"),
        LanguageInfo(code: "ar", name: "Arabic"),
        LanguageInfo(code: "ru", name: "Russian"),
        LanguageInfo(code: "hi", name: "Hindi"),
    ]

    static let allLanguages: [LanguageInfo] = {
        let extra: [LanguageInfo] = [
            LanguageInfo(code: "nl", name: "Dutch"),
            LanguageInfo(code: "sv", name: "Swedish"),
            LanguageInfo(code: "pl", name: "Polish"),
            LanguageInfo(code: "tr", name: "Turkish"),
            LanguageInfo(code: "th", name: "Thai"),
            LanguageInfo(code: "vi", name: "Vietnamese"),
            LanguageInfo(code: "uk", name: "Ukrainian"),
            LanguageInfo(code: "cs", name: "Czech"),
            LanguageInfo(code: "da", name: "Danish"),
            LanguageInfo(code: "fi", name: "Finnish"),
            LanguageInfo(code: "el", name: "Greek"),
            LanguageInfo(code: "he", name: "Hebrew"),
            LanguageInfo(code: "id", name: "Indonesian"),
            LanguageInfo(code: "ms", name: "Malay"),
            LanguageInfo(code: "no", name: "Norwegian"),
            LanguageInfo(code: "ro", name: "Romanian"),
        ]
        return (commonLanguages + extra).sorted { $0.name < $1.name }
    }()

    static func displayName(for code: String) -> String {
        allLanguages.first { $0.code == code }?.name
            ?? Locale.current.localizedString(forLanguageCode: code)
            ?? code.uppercased()
    }
}
