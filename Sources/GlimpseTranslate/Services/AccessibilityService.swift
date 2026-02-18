import AppKit
import ApplicationServices

@MainActor
final class AccessibilityService {
    func requestPermissionIfNeeded() {
        let options = [kAXTrustedCheckOptionPrompt.takeRetainedValue(): true] as CFDictionary
        let trusted = AXIsProcessTrustedWithOptions(options)
        if !trusted {
            print("[GlimpseTranslate] Accessibility permission not yet granted. A system prompt should appear.")
        }
    }

    var isTrusted: Bool {
        AXIsProcessTrusted()
    }

    func getSelectedText() -> String? {
        let systemWide = AXUIElementCreateSystemWide()

        var focusedElement: AnyObject?
        let focusedError = AXUIElementCopyAttributeValue(
            systemWide,
            kAXFocusedUIElementAttribute as CFString,
            &focusedElement
        )

        guard focusedError == .success else { return nil }

        // swiftlint:disable:next force_cast
        let element = focusedElement as! AXUIElement

        var selectedTextValue: AnyObject?
        let textError = AXUIElementCopyAttributeValue(
            element,
            kAXSelectedTextAttribute as CFString,
            &selectedTextValue
        )

        guard textError == .success,
              let text = selectedTextValue as? String,
              !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return nil
        }

        return text.trimmingCharacters(in: .whitespacesAndNewlines)
    }
}
