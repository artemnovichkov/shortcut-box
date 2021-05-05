//
//  Created by Artem Novichkov on 05.05.2021.
//

import Foundation

enum Error: Swift.Error {

    case wrongArguments
    case noShortcuts
    case noData
    case noGistToken
    case noGithubToken
    case wrongURL(String)
}

extension Error: CustomStringConvertible {

    var description: String {
        switch self {
            case .wrongArguments:
                return "The are no path to shortcuts. Example: shortcut.swift xcode.json"
            case .noShortcuts:
                return "There are no shortcuts"
            case .noData:
            return "Fail to create data representation"
            case .noGistToken:
                return "There are no gist token"
            case .noGithubToken:
                return "There are no Github token"
            case .wrongURL(let string):
                return "Wrong URL: " + string
        }
    }
}
