import SwiftUI

struct MenuBarView: View {
    @EnvironmentObject var settings: AppSettings
    @EnvironmentObject var translationService: TranslationService

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Glimpse Translate")
                .font(.headline)

            Text("Select text, then press \(Text("Cmd+Shift+D").bold())")
                .font(.caption)
                .foregroundStyle(.secondary)

            Divider()

            Picker("Translate to:", selection: $settings.targetLanguage) {
                ForEach(LanguageCodes.commonLanguages, id: \.code) { lang in
                    Text(lang.name).tag(lang.code)
                }
            }
            .pickerStyle(.menu)

            Divider()

            Button("Settings...") {
                NSApp.sendAction(Selector(("showSettingsWindow:")), to: nil, from: nil)
                NSApp.activate(ignoringOtherApps: true)
            }
            .keyboardShortcut(",", modifiers: .command)

            Button("Quit Glimpse Translate") {
                NSApplication.shared.terminate(nil)
            }
            .keyboardShortcut("q", modifiers: .command)
        }
        .padding()
        .frame(width: 260)
    }
}
