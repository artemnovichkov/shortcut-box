//
//  Created by Artem Novichkov on 05.05.2021.
//

import SwiftUI

func makeShortcuts(path: String) throws -> Shortcuts {
    var shortcutsURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
    shortcutsURL.appendPathComponent(path)

    let data = try Data(contentsOf: shortcutsURL)
    return try JSONDecoder().decode(Shortcuts.self, from: data)
}

func makeImageData(shortcut: Shortcut) -> Data? {
    let view = ShortcutView(shortcut: shortcut)
    let hostingView = NSHostingView(rootView: view)
    hostingView.frame = CGRect(x: 0, y: 0, width: 500, height: 100)
    return rasterize(hostingView)
}

func rasterize(_ view: NSView) -> Data? {
    guard let bitmapRepresentation = view.bitmapImageRepForCachingDisplay(in: view.bounds) else {
        return nil
    }
    bitmapRepresentation.size = view.bounds.size
    view.cacheDisplay(in: view.bounds, to: bitmapRepresentation)
    return bitmapRepresentation.representation(using: .jpeg, properties: [:])
}

do {
    let arguments = CommandLine.arguments

    guard arguments.count == 2 else {
        throw Error.wrongArguments
    }
    
    let shortcuts = try makeShortcuts(path: arguments[1])
    guard let shortcut = shortcuts.shortcuts.randomElement() else {
        throw Error.noShortcuts
    }
    
    guard let data = makeImageData(shortcut: shortcut) else {
        throw Error.noShortcuts
    }
    
    let url = URL(fileURLWithPath: FileManager.default.currentDirectoryPath + "/image.jpg")
    try data.write(to: url)
}
catch {
    print(error)
    exit(EXIT_FAILURE)
}
