//
//  Created by Artem Novichkov on 05.05.2021.
//

import Foundation

public struct Shortcuts: Decodable {

    let name: String
    let shortcuts: [Shortcut]
}

public struct Shortcut: Decodable {

    public let key: String
    public let command: String
    
    public init(key: String, command: String) {
        self.key = key
        self.command = command
    }
}
