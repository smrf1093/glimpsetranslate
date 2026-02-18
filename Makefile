.PHONY: build run clean bundle dmg

APP_NAME = GlimpseTranslate
BUILD_DIR = .build/release
APP_BUNDLE = $(APP_NAME).app
DMG_NAME = $(APP_NAME).dmg

# Build release binary
build:
	swift build -c release

# Assemble .app bundle and run
run: build bundle
	open $(APP_BUNDLE)

# Assemble a macOS .app bundle from the SPM binary
bundle: build
	@rm -rf $(APP_BUNDLE)
	@mkdir -p $(APP_BUNDLE)/Contents/MacOS
	@mkdir -p $(APP_BUNDLE)/Contents/Resources
	@cp $(BUILD_DIR)/$(APP_NAME) $(APP_BUNDLE)/Contents/MacOS/$(APP_NAME)
	@cp Resources/Info.plist $(APP_BUNDLE)/Contents/Info.plist
	@echo "APPL????" > $(APP_BUNDLE)/Contents/PkgInfo
	@echo "Built $(APP_BUNDLE)"

# Create a DMG installer image
dmg: bundle
	@rm -f $(DMG_NAME)
	@mkdir -p dmg_staging
	@cp -R $(APP_BUNDLE) dmg_staging/
	@ln -s /Applications dmg_staging/Applications
	hdiutil create -volname "Glimpse Translate" \
		-srcfolder dmg_staging \
		-ov -format UDZO \
		$(DMG_NAME)
	@rm -rf dmg_staging
	@echo "Created $(DMG_NAME)"

# Clean build artifacts
clean:
	swift package clean
	rm -rf $(APP_BUNDLE)
	rm -rf $(DMG_NAME)
	rm -rf dmg_staging
	rm -rf .build/
