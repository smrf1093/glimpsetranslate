import SwiftUI

struct SettingsView: View {
    @EnvironmentObject var settings: AppSettings
    @EnvironmentObject var translationService: TranslationService

    var body: some View {
        TabView {
            GeneralSettingsView(settings: settings)
                .tabItem { Label("General", systemImage: "gear") }

            ProviderSettingsView(settings: settings, translationService: translationService)
                .tabItem { Label("Provider", systemImage: "server.rack") }
        }
        .frame(width: 420, height: 260)
    }
}

private struct GeneralSettingsView: View {
    @ObservedObject var settings: AppSettings

    var body: some View {
        Form {
            Picker("Target Language", selection: $settings.targetLanguage) {
                ForEach(LanguageCodes.allLanguages, id: \.code) { lang in
                    Text(lang.name).tag(lang.code)
                }
            }

            Toggle("Show detected source language", isOn: $settings.showDetectedLanguage)

            LabeledContent("Hotkey") {
                Text("Cmd + Shift + D")
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
    }
}

private struct ProviderSettingsView: View {
    @ObservedObject var settings: AppSettings
    @ObservedObject var translationService: TranslationService

    var body: some View {
        Form {
            Picker("Translation Provider", selection: $settings.selectedProvider) {
                ForEach(TranslationProviderType.allCases, id: \.self) { provider in
                    Text(provider.rawValue).tag(provider)
                }
            }
            .onChange(of: settings.selectedProvider) { _, newValue in
                translationService.currentProviderType = newValue
            }

            if settings.selectedProvider == .google {
                SecureField("Google API Key", text: $settings.googleAPIKey)
                Text("Get a key at console.cloud.google.com")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            if settings.selectedProvider == .myMemory {
                Text("Free tier: 5,000 characters/day (no API key needed)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
    }
}
