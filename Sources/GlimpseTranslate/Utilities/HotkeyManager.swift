import AppKit
import HotKey

@MainActor
final class HotkeyManager {
    private var hotKey: HotKey?
    private let handler: @MainActor () -> Void

    init(handler: @escaping @MainActor () -> Void) {
        self.handler = handler
        registerHotkey()
    }

    private func registerHotkey() {
        // Cmd + Shift + D
        hotKey = HotKey(key: .d, modifiers: [.command, .shift])
        hotKey?.keyDownHandler = { [weak self] in
            Task { @MainActor in
                self?.handler()
            }
        }
    }

    deinit {
        hotKey = nil
    }
}
