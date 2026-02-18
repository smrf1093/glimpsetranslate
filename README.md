# Glimpse Translate

A lightweight macOS menu bar app that provides instant inline translation for any selected text, system-wide. Select a word or phrase in any application, press **Cmd+Shift+D**, and a floating translation popup appears right next to your cursor.

Think of it as Apple's built-in "Look Up" dictionary — but for translation, with support for 28+ languages.

[![Latest Release](https://img.shields.io/github/v/release/AnarManafov/GlimpseTranslate)](https://github.com/AnarManafov/GlimpseTranslate/releases/latest)
[![Download DMG](https://img.shields.io/github/downloads/AnarManafov/GlimpseTranslate/total)](https://github.com/AnarManafov/GlimpseTranslate/releases/latest)
![macOS](https://img.shields.io/badge/macOS-14.0%2B-blue)
![Swift](https://img.shields.io/badge/Swift-5.9%2B-orange)
![License](https://img.shields.io/badge/License-MIT-green)

---

## Why Glimpse Translate?

### The Problem with Apple Dictionary

Apple's built-in dictionary and "Look Up" feature (triggered by Force Touch or Ctrl+Cmd+D) is a great tool, but it has significant limitations:

- **Limited language support**: Apple Dictionary primarily covers English, Chinese, Japanese, Korean, French, German, Spanish, Italian, Dutch, and Portuguese. Languages like **Persian (Farsi)**, Turkish, Hindi, Arabic, Vietnamese, Thai, and many others are either unsupported or have extremely limited coverage.
- **No translation**: Apple's Look Up is a *dictionary*, not a *translator*. It gives you definitions within a single language, not translations between languages.
- **Phrase translation**: Apple Dictionary works best with single words. It cannot translate sentences, phrases, or paragraphs.
- **No provider choice**: You're locked into Apple's dictionary sources. There's no way to use Google Translate, or any other translation service.
- **Offline only**: While offline access is nice, it means the dictionaries are static and may lack modern vocabulary, slang, or domain-specific terms.

### What Glimpse Translate Offers

- **28+ languages** including Persian (Farsi), Arabic, Hindi, Turkish, Thai, Vietnamese, and more
- **Real translation** between any language pair, not just dictionary definitions
- **Auto-detection** of the source language — just select text and translate
- **Works with words, phrases, and sentences**
- **Swappable providers** — use the free MyMemory API out of the box, or plug in your Google Cloud Translation API key
- **System-wide** — works in any app: Safari, Chrome, VS Code, TextEdit, Notes, Terminal, PDFs, and more
- **Non-intrusive** — the floating panel doesn't steal focus from your current app
- **Open source** — inspect, modify, and extend to your needs

---

## Features

- **Global hotkey**: Press `Cmd+Shift+D` with any text selected to instantly translate
- **Services menu**: Right-click selected text -> Services -> "Translate with Glimpse"
- **Floating popup**: Frosted-glass panel appears near your cursor, styled like native macOS UI
- **Auto-detect source language**: No need to specify what language the text is in
- **Quick language picker**: Change target language from the menu bar dropdown
- **Copy translation**: One-click copy of translated text to clipboard
- **Multiple providers**: MyMemory (free, no API key) and Google Cloud Translation (optional)
- **Menu bar only**: Runs as a lightweight status bar utility — no Dock icon, no window clutter
- **Privacy-conscious**: No telemetry, no analytics, no data collection. Translation requests go directly to the API provider you choose.

---

## Supported Languages

| Language | Code | Language | Code |
|----------|------|----------|------|
| Arabic | ar | Korean | ko |
| Chinese (Simplified) | zh | Malay | ms |
| Czech | cs | Norwegian | no |
| Danish | da | Persian (Farsi) | fa |
| Dutch | nl | Polish | pl |
| English | en | Portuguese | pt |
| Finnish | fi | Romanian | ro |
| French | fr | Russian | ru |
| German | de | Spanish | es |
| Greek | el | Swedish | sv |
| Hebrew | he | Thai | th |
| Hindi | hi | Turkish | tr |
| Indonesian | id | Ukrainian | uk |
| Italian | it | Vietnamese | vi |
| Japanese | ja | | |

The MyMemory API supports additional languages beyond this list. These are the languages included in the built-in picker.

---

## Supported macOS Versions

| macOS Version | Supported |
|---------------|-----------|
| macOS 15 Sequoia | Yes |
| macOS 14 Sonoma | Yes (minimum) |
| macOS 13 Ventura and earlier | No |

Runs on both **Apple Silicon** (M1/M2/M3/M4) and **Intel** Macs.

---

## Installation

### Download (Recommended)

1. Go to the [**Latest Release**](https://github.com/AnarManafov/GlimpseTranslate/releases/latest)
2. Download **GlimpseTranslate.dmg**
3. Open the DMG and drag **Glimpse Translate** to your **Applications** folder
4. Launch from Applications

> **Important:** The app is not signed with an Apple Developer certificate, so macOS will block it on first launch. To open it:
> 1. Right-click (or Control-click) the app in Applications
> 2. Select **Open** from the context menu
> 3. Click **Open** in the dialog that appears
> 4. You only need to do this once — subsequent launches work normally

### Build from Source

#### Prerequisites

- **macOS 14.0 (Sonoma)** or later
- **Swift 5.9+** (included with Xcode or Command Line Tools)
- **Xcode Command Line Tools**: Install with `xcode-select --install`

```bash
# Clone the repository
git clone https://github.com/AnarManafov/GlimpseTranslate.git
cd GlimpseTranslate

# Build and run
make run
```

This will:
1. Compile the project in release mode
2. Assemble a proper `.app` bundle
3. Open the app

#### Manual Build

If you prefer to build step by step:

```bash
# Build
swift build -c release

# Assemble .app bundle
make bundle

# Launch
open GlimpseTranslate.app
```

#### Create DMG Locally

```bash
make dmg
```

### First Launch

On first launch, macOS will prompt you to grant **Accessibility permission**. This is required so the app can read selected text from other applications.

1. A system dialog will appear asking to grant Accessibility access
2. Go to **System Settings -> Privacy & Security -> Accessibility**
3. Enable **Glimpse Translate** in the list
4. You may need to relaunch the app after granting permission

> **Note**: Without Accessibility permission, the app falls back to reading from the clipboard instead of directly reading selected text.

---

## Usage

### Method 1: Global Hotkey (Recommended)

1. Select any text in any application
2. Press **Cmd+Shift+D**
3. A floating translation panel appears near your cursor
4. Press **Escape** or click outside the panel to dismiss

### Method 2: Services Menu

1. Select any text in any application
2. Right-click the selection
3. Choose **Services -> Translate with Glimpse**
4. The translation panel appears

### Changing Target Language

- Click the **Glimpse Translate icon** in the menu bar (book icon)
- Use the "Translate to" dropdown to pick your target language
- All subsequent translations will use the new target language

### Settings

- Click the menu bar icon -> **Settings...** (or press **Cmd+,**)
- **General tab**: Target language, display preferences
- **Provider tab**: Switch between MyMemory (free) and Google Translate (requires API key)

---

## Translation Providers

### MyMemory (Default)

- **Free** — no API key required
- **Auto-detection** of source language
- **Limit**: 5,000 characters/day (anonymous), 50,000 characters/day (with free email registration at [mymemory.translated.net](https://mymemory.translated.net/))
- Good quality for common language pairs
- Best for personal, casual use

### Google Cloud Translation (Optional)

- Requires a [Google Cloud](https://console.cloud.google.com/) account and API key
- **Free tier**: 500,000 characters/month
- Higher translation quality, especially for complex sentences
- Better support for rare language pairs
- To set up:
  1. Create a project in [Google Cloud Console](https://console.cloud.google.com/)
  2. Enable the **Cloud Translation API**
  3. Create an API key under **APIs & Services -> Credentials**
  4. Paste the key in Glimpse Translate Settings -> Provider tab

### Adding More Providers

The app uses a protocol-based provider architecture. To add a new provider (e.g., DeepL, LibreTranslate):

1. Create a new struct conforming to `TranslationProvider` in `Sources/GlimpseTranslate/Services/`
2. Add a case to `TranslationProviderType`
3. Register it in `TranslationService.init()`

See `MyMemoryProvider.swift` as a reference implementation.

---

## Project Structure

```
GlimpseTranslate/
├── Package.swift                          # Swift Package Manager manifest
├── Makefile                               # Build automation (build, bundle, run, clean)
├── Resources/
│   └── Info.plist                         # App metadata, LSUIElement, NSServices
├── Sources/GlimpseTranslate/
│   ├── GlimpseTranslateApp.swift          # @main entry point, MenuBarExtra
│   ├── AppDelegate.swift                  # Hotkey, Services, Accessibility coordinator
│   ├── Views/
│   │   ├── TranslationPanel.swift         # NSPanel subclass (floating, non-activating)
│   │   ├── TranslationView.swift          # SwiftUI translation popup content
│   │   ├── MenuBarView.swift              # Menu bar dropdown UI
│   │   └── SettingsView.swift             # Preferences window (General + Provider)
│   ├── Services/
│   │   ├── TranslationService.swift       # Provider protocol + service manager
│   │   ├── MyMemoryProvider.swift         # Free MyMemory API integration
│   │   ├── GoogleTranslateProvider.swift  # Google Cloud Translation API
│   │   └── AccessibilityService.swift     # macOS Accessibility API for text extraction
│   ├── Utilities/
│   │   ├── HotkeyManager.swift            # Global Cmd+Shift+D registration
│   │   ├── PanelManager.swift             # Panel positioning + lifecycle
│   │   └── LanguageCodes.swift            # ISO 639-1 language mappings
│   └── Models/
│       ├── TranslationResult.swift        # Translation response model + errors
│       └── AppSettings.swift              # @AppStorage-backed preferences
```

---

## Architecture

### Design Decisions

| Decision | Choice | Rationale |
|----------|--------|-----------|
| **UI Framework** | SwiftUI + AppKit | SwiftUI for views, AppKit for NSPanel and system integration |
| **Panel type** | NSPanel (not NSPopover) | NSPopover can't reliably float over other apps |
| **Hotkey** | [soffes/HotKey](https://github.com/soffes/HotKey) (Carbon) | Properly consumes the keystroke; NSEvent monitors can't |
| **Text capture** | Accessibility API | System-wide access to selected text without clipboard pollution |
| **Default provider** | MyMemory | Free, no setup, auto-detect, works out of the box |
| **App Sandbox** | Disabled | Required for Accessibility API and global hotkey |
| **Dock presence** | Hidden (LSUIElement) | Menu bar utility — no need for a Dock icon |

### Key Technical Details

- **Non-activating panel**: The translation popup uses `NSPanel` with `.nonactivatingPanel` style mask, meaning it never steals focus from your current application. Your text selection stays intact.
- **Frosted glass effect**: Uses `NSVisualEffectView` with `.hudWindow` material for a native macOS look.
- **Multi-monitor support**: Panel positioning accounts for the screen where the cursor is, not just the main display.
- **Swift Concurrency**: All UI code is `@MainActor`-isolated. Translation providers are `Sendable` structs for safe async usage.

---

## Troubleshooting

### The hotkey doesn't work
- Ensure the app is running (check for the book icon in the menu bar)
- Check if another app has claimed the Cmd+Shift+D shortcut
- Restart the app after granting Accessibility permission

### Translation panel doesn't appear
- Make sure text is actually selected (highlighted) before pressing the hotkey
- Check that Accessibility permission is granted in System Settings -> Privacy & Security -> Accessibility
- Try the clipboard fallback: copy text first (Cmd+C), then press the hotkey

### "Translation quota exceeded" error
- MyMemory's free tier allows 5,000 characters/day for anonymous users
- Wait until the next day, or register a free account at [mymemory.translated.net](https://mymemory.translated.net/) for 50,000 chars/day
- Alternatively, switch to Google Cloud Translation in Settings

### Services menu item doesn't appear
- macOS caches the Services menu. Try logging out and back in.
- Ensure the app has been launched at least once.

---

## Roadmap

- [ ] Hotkey customization (user-configurable shortcut)
- [ ] Translation history panel
- [ ] Launch at login option
- [ ] DeepL and LibreTranslate provider support
- [ ] Apple Translation framework integration (on-device, private, macOS 15+)
- [ ] Text-to-speech for translated text
- [ ] Dark/light theme matching

---

## Contributing

Contributions are welcome! Here's how to get started:

1. Fork the repository
2. Create a feature branch: `git checkout -b feature/my-feature`
3. Make your changes
4. Build and test: `make run`
5. Commit: `git commit -am 'Add my feature'`
6. Push: `git push origin feature/my-feature`
7. Open a Pull Request

### Adding a New Translation Provider

The provider system is designed for easy extension:

```swift
struct MyProvider: TranslationProvider {
    let name = "My Provider"
    let requiresAPIKey = false

    func translate(text: String, from: String?, to: String) async throws -> TranslationResult {
        // Your API call here
    }
}
```

---

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

---

## Acknowledgments

- [soffes/HotKey](https://github.com/soffes/HotKey) — Global hotkey registration for macOS
- [MyMemory](https://mymemory.translated.net/) — Free translation API
- [Google Cloud Translation](https://cloud.google.com/translate) — Official translation API
- Inspired by Apple's built-in Look Up feature and the need for broader language support
