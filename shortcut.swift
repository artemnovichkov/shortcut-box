#!/usr/bin/swift

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

struct Shortcuts: Decodable {

    let shortcuts: [Shortcut]
}

struct Gist: Encodable {

    let description: String
    let files: [String: File]
}

struct File: Encodable {

    let content: String
}

enum Error: Swift.Error {

    case wrongArguments
    case noGistToken
    case noGithubToken
    case wrongURL(String)
}

extension Error: CustomStringConvertible {

    var description: String {
        switch self {
            case .wrongArguments:
                return "Add a path to shortcuts"
            case .noGistToken:
                return "There are no gist token"
            case .noGithubToken:
                return "There are no Github token"
            case .wrongURL(let string):
                return "Wrong URL: " + string
        }
    }
}

do {
    print(ProcessInfo.processInfo.environment)
    let arguments = CommandLine.arguments

    guard arguments.count >= 2 else {
        throw Error.wrongArguments
    }

    var shortcutsURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
    shortcutsURL.appendPathComponent(arguments[1])

    let data = try Data(contentsOf: shortcutsURL)
    let shortcuts = try JSONDecoder().decode(Shortcuts.self, from: data)
    let shortcut = shortcuts.shortcuts.randomElement()!

    let file = File(content: shortcut.description)
    let gist = Gist(description: "Updated by https://github.com/artemnovichkov/shortcut-box",
                    files: ["👨‍💻 New Xcode shortcut every day": file])

    guard let gistToken = ProcessInfo.processInfo.environment["GIST_TOKEN"] else {
        throw Error.noGistToken
    }

    let gistURLString = "https://api.github.com/gists/" + gistToken
    guard let gistURL = URL(string: gistURLString) else {
        throw Error.wrongURL(gistURLString)
    }
    var pathGistRequest = URLRequest(url: gistURL)

    guard let githubToken = ProcessInfo.processInfo.environment["GH_TOKEN"] else {
        throw Error.noGithubToken
    }

    pathGistRequest.allHTTPHeaderFields = ["Authorization": "token " + githubToken]
    pathGistRequest.httpMethod = "PATCH"
    pathGistRequest.httpBody = try JSONEncoder().encode(gist)
    let task = URLSession.shared.dataTask(with: pathGistRequest) { data, response, error in
        print(data, response, error)
        exit(error == nil ? EXIT_SUCCESS : EXIT_FAILURE)
    }
    task.resume()
    RunLoop.main.run()
}
catch {
    print(error)
    exit(EXIT_FAILURE)
}
