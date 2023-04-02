//
//  Created by Artem Novichkov on 05.05.2021.
//

import SwiftUI
import Shortcut

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

        let shortcuts = try Shortcuts.makeShortcuts(url: shortcutsURL)
        guard let shortcut = shortcuts.shortcuts.randomElement() else {
            throw Error.noShortcuts
        }

        let shortcutView = ShortcutView(shortcut: shortcut)
        let frame = CGRect(x: 0, y: 0, width: 442, height: 100)
        guard let data = shortcutView.makeImageData(frame: frame) else {
            throw Error.noImageData
        }

        let imageURL = currentDirectoryURL.appendingPathComponent("image.jpg")
        try data.write(to: imageURL)
    }

    // MARK: - Private
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
