//
//  Created by Artem Novichkov on 05.05.2021.
//

import Foundation

enum Error: Swift.Error {

    case wrongArguments
    case noShortcuts
    case noImageData
}

extension Error: CustomStringConvertible {

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
