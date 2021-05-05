//
//  Created by Artem Novichkov on 05.05.2021.
//

import Foundation

struct Shortcut: Decodable {

    let key: String
    let command: String
}

extension Shortcut: CustomStringConvertible {

    var description: String {
        key + " — " + command
    }
}
