import AppKit
import SwiftUI

@MainActor
class AppDelegate: NSObject, NSApplicationDelegate {
    private var hotkeyManager: HotkeyManager?
    let panelManager = PanelManager()
    let translationService = TranslationService()
    let accessibilityService = AccessibilityService()
    let appSettings = AppSettings()

    func applicationDidFinishLaunching(_ notification: Notification) {
        accessibilityService.requestPermissionIfNeeded()

        hotkeyManager = HotkeyManager { [weak self] in
            self?.handleTranslationTrigger()
        }

        NSApp.servicesProvider = self

        // Sync provider setting
        if let provider = TranslationProviderType(rawValue: appSettings.providerRawValue) {
            translationService.currentProviderType = provider
        }
    }

    private func handleTranslationTrigger() {
        let selectedText = accessibilityService.getSelectedText()
            ?? NSPasteboard.general.string(forType: .string)

        guard let text = selectedText, !text.isEmpty else { return }

        let mouseLocation = NSEvent.mouseLocation
        panelManager.showPanel(
            near: mouseLocation,
            text: text,
            translationService: translationService,
            settings: appSettings
        )
    }

    @objc func translateService(
        _ pasteboard: NSPasteboard,
        userData: String?,
        error: AutoreleasingUnsafeMutablePointer<NSString>
    ) {
        guard let text = pasteboard.string(forType: .string),
              !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }

        let mouseLocation = NSEvent.mouseLocation
        panelManager.showPanel(
            near: mouseLocation,
            text: text.trimmingCharacters(in: .whitespacesAndNewlines),
            translationService: translationService,
            settings: appSettings
        )
    }
}
