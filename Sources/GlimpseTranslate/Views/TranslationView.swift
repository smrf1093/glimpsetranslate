import SwiftUI

struct TranslationView: View {
    let sourceText: String
    let translationService: TranslationService
    let settings: AppSettings
    let onDismiss: () -> Void

    @State private var result: TranslationResult?
    @State private var error: String?
    @State private var isLoading = true

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            // Header
            HStack {
                if let detectedLang = result?.detectedSourceLanguage {
                    Text(LanguageCodes.displayName(for: detectedLang))
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    Image(systemName: "arrow.right")
                        .font(.caption2)
                        .foregroundStyle(.tertiary)
                }
                Text(LanguageCodes.displayName(for: settings.targetLanguage))
                    .font(.caption)
                    .foregroundStyle(.secondary)
                Spacer()
                Button(action: onDismiss) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundStyle(.secondary)
                        .font(.title3)
                }
                .buttonStyle(.plain)
            }

            // Source text
            Text(sourceText)
                .font(.callout)
                .foregroundStyle(.secondary)
                .lineLimit(2)

            Divider()

            // Translation result
            if isLoading {
                HStack(spacing: 8) {
                    ProgressView()
                        .controlSize(.small)
                    Text("Translating...")
                        .font(.callout)
                        .foregroundStyle(.secondary)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            } else if let error {
                Label(error, systemImage: "exclamationmark.triangle")
                    .font(.callout)
                    .foregroundStyle(.red)
                    .lineLimit(3)
            } else if let result {
                Text(result.translatedText)
                    .font(.body)
                    .textSelection(.enabled)
            }

            Spacer()

            // Bottom toolbar
            HStack {
                if let result {
                    Button(action: { copyToClipboard(result.translatedText) }) {
                        Label("Copy", systemImage: "doc.on.doc")
                    }
                    .buttonStyle(.plain)
                    .font(.caption)
                }
                Spacer()
                Text(translationService.currentProvider.name)
                    .font(.caption2)
                    .foregroundStyle(.tertiary)
            }
        }
        .padding(14)
        .task {
            await performTranslation()
        }
    }

    private func performTranslation() async {
        do {
            let translationResult = try await translationService.translate(
                text: sourceText,
                from: nil,
                to: settings.targetLanguage
            )
            self.result = translationResult
        } catch {
            self.error = error.localizedDescription
        }
        self.isLoading = false
    }

    private func copyToClipboard(_ text: String) {
        NSPasteboard.general.clearContents()
        NSPasteboard.general.setString(text, forType: .string)
    }
}
