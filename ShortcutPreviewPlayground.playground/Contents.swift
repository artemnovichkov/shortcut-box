import SwiftUI
import PlaygroundSupport

let shortcut = Shortcut(key: "⌃ + ⌘ + E", command: "Edit all in scope")
let view = ShortcutView(shortcut: shortcut)
PlaygroundPage.current.setLiveView(view)
