#!/bin/zsh
# Builds Collect.app, installs it to /Applications and relaunches it.
set -e
cd "$(dirname "$0")"
APP=Collect.app
rm -rf $APP
mkdir -p $APP/Contents/MacOS $APP/Contents/Resources
# Universal binary: Apple Silicon + Intel Macs.
for arch in arm64 x86_64; do
  swiftc -parse-as-library -swift-version 5 -O -target $arch-apple-macos13 main.swift -o /tmp/Collect-$arch
done
lipo -create /tmp/Collect-arm64 /tmp/Collect-x86_64 -output $APP/Contents/MacOS/Collect
rm /tmp/Collect-arm64 /tmp/Collect-x86_64
cat > $APP/Contents/Info.plist <<PLIST
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0"><dict>
  <key>CFBundleName</key><string>Collect</string>
  <key>CFBundleIdentifier</key><string>com.danielryan.collect</string>
  <key>CFBundleExecutable</key><string>Collect</string>
  <key>CFBundlePackageType</key><string>APPL</string>
  <key>CFBundleShortVersionString</key><string>1.0</string>
  <key>LSMinimumSystemVersion</key><string>13.0</string>
  <key>LSUIElement</key><true/>
</dict></plist>
PLIST
# Sign with the same local certificate every time so macOS keeps Input Monitoring across rebuilds.
# (Falls back to ad-hoc signing on a Mac without it; then the permission must be re-added after each build.)
if security find-certificate -c "Daniel Ryan Local Signing" >/dev/null 2>&1; then
  codesign --force --sign "Daniel Ryan Local Signing" $APP
else
  codesign --force --sign - $APP
fi
echo "Built $APP"

# Install: keep only one copy on this Mac.
pkill -x Collect || true
sleep 1
rm -rf /Applications/$APP
mv $APP /Applications/
open /Applications/$APP
echo "Installed to /Applications"
