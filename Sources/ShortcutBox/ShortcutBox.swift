//
//  Created by Artem Novichkov on 05.05.2021.
//

import SwiftUI

@main
struct ShortcutBox {

    enum Error: Swift.Error {

        case wrongArguments
        case noShortcuts
        case noImageData
    }

    static func main() throws {
        let arguments = CommandLine.arguments

        guard arguments.count == 2 else {
            throw Error.wrongArguments
        }

        let currentDirectoryURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
        let shortcutsURL = currentDirectoryURL.appendingPathComponent(arguments[1])

        let shortcuts = try makeShortcuts(url: shortcutsURL)
        guard let shortcut = shortcuts.shortcuts.randomElement() else {
            throw Error.noShortcuts
        }

        guard let data = makeImageData(shortcut: shortcut) else {
            throw Error.noImageData
        }

        let imageURL = currentDirectoryURL.appendingPathComponent("image.jpg")
        try data.write(to: imageURL)
    }

    // MARK: - Private

    private static func makeShortcuts(url: URL) throws -> Shortcuts {
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(Shortcuts.self, from: data)
    }

    private static func makeImageData(shortcut: Shortcut) -> Data? {
        let view = ShortcutView(shortcut: shortcut)
        let hostingView = NSHostingView(rootView: view)
        hostingView.frame = CGRect(x: 0, y: 0, width: 442, height: 100)
        return rasterize(hostingView)
    }

    private static func rasterize(_ view: NSView) -> Data? {
        guard let bitmapRepresentation = view.bitmapImageRepForCachingDisplay(in: view.bounds) else {
            return nil
        }
        bitmapRepresentation.size = view.bounds.size
        view.cacheDisplay(in: view.bounds, to: bitmapRepresentation)
        return bitmapRepresentation.representation(using: .jpeg, properties: [:])
    }
}

extension ShortcutBox.Error: CustomStringConvertible {

    var description: String {
        switch self {
            case .wrongArguments:
                return "The are no path to shortcuts. Example: swift run ShortcutBox xcode.json."
            case .noShortcuts:
                return "There are no shortcuts."
        case .noImageData:
            return "Failed to generate image data."
        }
    }
}
