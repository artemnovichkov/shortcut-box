//
//  Created by Artem Novichkov on 05.05.2021.
//

import Foundation

public struct Shortcuts: Decodable {

    public let name: String
    public let shortcuts: [Shortcut]

    public static func makeShortcuts(url: URL) throws -> Shortcuts {
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(Shortcuts.self, from: data)
    }
}

public struct Shortcut: Decodable {

    public let key: String
    public let command: String
    
    public init(key: String, command: String) {
        self.key = key
        self.command = command
    }
}
