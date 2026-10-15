# Collect

A tiny Mac menu bar app for copying several things while you read, then pasting them all at once. Turn it on, press ⌘C on each line you want to keep, and one ⌘V pastes the whole pile.

<img src="docs/images/dropdown.png" alt="The Collect dropdown, opened from the number-in-a-circle icon in the menu bar" width="375">

Works on macOS 13 (Ventura) or newer, on both Apple Silicon and Intel Macs.

## How to use it

- Press **⌃⌥C** (Control + Option + C), or click the **circle icon** in the menu bar and flip the switch, to start collecting. The circle shows **0**.
- **Copy as you read.** Each ⌘C adds to the pile and the number goes up.
- **Paste with ⌘V.** Everything you collected pastes at once, with a blank line between each piece. The pile then resets to 0.
- **⌘C with nothing selected** (for example, on an empty part of the page) clears the pile.
- **Click the circle** to see the list. Copy or remove a single item, clear everything, or open the **floating panel** to keep the list on screen while you read.
- An **empty grey circle** means collecting is off and ⌘C works normally.

### Settings

Click the gear in the dropdown:

- **Clear after pasting** and **⌘C with nothing selected clears**: both on by default.
- **Format**: Plain (default), Quote (`> line`), or Numbered.
- **Ignore repeats**: copying the same thing twice only adds it once.
- **Pulse icon on copy**, **Show “Added” bubble**, and **Open at login**.

## Permissions

To notice ⌘V and ⌘C, Collect needs **Input Monitoring**. It only looks for those two shortcuts. It doesn't record what you type and sends nothing anywhere. Without the permission, collecting still works, but the pile won't clear by itself.

Turn it on in **System Settings → Privacy & Security → Input Monitoring**. The dropdown shows a reminder with an **Open Settings** button until you do. If macOS quits Collect when you switch it on, open it again.

Collect never collects passwords that password managers mark as private, and it ignores copied images and files.

## Build it yourself

You need the Xcode Command Line Tools (`xcode-select --install`).

```bash
./build.sh        # builds and installs to /Applications
```

The whole app is one file: [`main.swift`](main.swift).

Each build is signed ad-hoc unless your keychain has a code-signing certificate named in `build.sh`. With ad-hoc signing, macOS treats every rebuild as a new app, so you'll need to switch Collect off and on again in Input Monitoring after rebuilding. A self-signed code-signing certificate avoids this.

## License

[MIT](LICENSE)
