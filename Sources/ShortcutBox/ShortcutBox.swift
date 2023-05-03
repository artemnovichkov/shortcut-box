//
//  Created by Artem Novichkov on 05.05.2021.
//

import SwiftUI
import Shortcut
import ArgumentParser

@main
struct ShortcutBox: ParsableCommand {

    enum Error: Swift.Error {

        case noShortcuts
        case noImageData
    }

    static let configuration = CommandConfiguration(abstract: "Generate a shortcut image.")

    @Option(name: [.short, .long], help: "An input file in JSON format.")
    var inputFile: String

    @Option(name: [.short, .long], help: "A name for generated image.")
    var outputFile: String

    @MainActor
    mutating func run() throws {
        let currentDirectoryURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
        let shortcutsURL = currentDirectoryURL.appendingPathComponent(inputFile)

        let shortcuts = try Shortcuts.makeShortcuts(url: shortcutsURL)
        guard let shortcut = shortcuts.shortcuts.randomElement() else {
            throw Error.noShortcuts
        }

        let shortcutView = ShortcutView(shortcut: shortcut)
        let size = CGSize(width: 442, height: 100)
        guard let data = shortcutView.makeImageData(size: size) else {
            throw Error.noImageData
        }

        let imageURL = currentDirectoryURL.appendingPathComponent(outputFile)
        try data.write(to: imageURL)
    }
}

extension ShortcutBox.Error: CustomStringConvertible {

    var description: String {
        switch self {
        case .noShortcuts:
            return "There are no shortcuts."
        case .noImageData:
            return "Failed to generate image data."
        }
    }
}
