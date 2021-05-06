//
//  Created by Artem Novichkov on 05.05.2021.
//

import Foundation

struct Shortcuts: Decodable {

    let name: String
    let shortcuts: [Shortcut]
}

struct Shortcut: Decodable {

    let key: String
    let command: String
}
