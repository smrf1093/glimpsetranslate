import SwiftUI

@main
struct GlimpseTranslateApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var appDelegate

    var body: some Scene {
        MenuBarExtra("Glimpse Translate", systemImage: "character.book.closed") {
            MenuBarView()
                .environmentObject(appDelegate.appSettings)
                .environmentObject(appDelegate.translationService)
        }
        .menuBarExtraStyle(.window)

        Settings {
            SettingsView()
                .environmentObject(appDelegate.appSettings)
                .environmentObject(appDelegate.translationService)
        }
    }
}
