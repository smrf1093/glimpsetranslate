import AppKit
import SwiftUI

@MainActor
final class PanelManager {
    private var panel: TranslationPanel?
    private var clickMonitor: Any?

    func showPanel(near point: NSPoint, text: String, translationService: TranslationService, settings: AppSettings) {
        dismissPanel()

        let view = TranslationView(
            sourceText: text,
            translationService: translationService,
            settings: settings,
            onDismiss: { [weak self] in self?.dismissPanel() }
        )

        let panel = TranslationPanel(contentView: view)
        let panelSize = NSSize(width: 340, height: 220)

        // Find the screen containing the mouse cursor
        let screen = NSScreen.screens.first { NSMouseInRect(point, $0.frame, false) }
            ?? NSScreen.main
        let screenFrame = screen?.visibleFrame ?? .zero

        // Position below and slightly right of cursor
        var origin = NSPoint(
            x: point.x + 8,
            y: point.y - panelSize.height - 8
        )

        // Clamp to screen bounds
        origin.x = min(origin.x, screenFrame.maxX - panelSize.width)
        origin.x = max(origin.x, screenFrame.minX)
        origin.y = max(origin.y, screenFrame.minY)
        origin.y = min(origin.y, screenFrame.maxY - panelSize.height)

        panel.setFrame(NSRect(origin: origin, size: panelSize), display: true)
        panel.makeKeyAndOrderFront(nil)
        self.panel = panel

        // Dismiss on click outside
        clickMonitor = NSEvent.addGlobalMonitorForEvents(matching: [.leftMouseDown, .rightMouseDown]) {
            [weak self] _ in
            guard let self, let panel = self.panel else { return }
            if !panel.frame.contains(NSEvent.mouseLocation) {
                self.dismissPanel()
            }
        }
    }

    func dismissPanel() {
        panel?.close()
        panel = nil
        if let monitor = clickMonitor {
            NSEvent.removeMonitor(monitor)
            clickMonitor = nil
        }
    }
}
