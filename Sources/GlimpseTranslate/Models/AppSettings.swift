import SwiftUI

final class AppSettings: ObservableObject {
    @AppStorage("targetLanguage") var targetLanguage: String = "fa"
    @AppStorage("translationProvider") var providerRawValue: String = TranslationProviderType.myMemory.rawValue
    @AppStorage("googleTranslateAPIKey") var googleAPIKey: String = ""
    @AppStorage("showDetectedLanguage") var showDetectedLanguage: Bool = true

    var selectedProvider: TranslationProviderType {
        get { TranslationProviderType(rawValue: providerRawValue) ?? .myMemory }
        set { providerRawValue = newValue.rawValue }
    }
}
