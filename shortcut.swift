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

    case noGistToken
    case noGithubToken
    case wrongURL(String)
}

extension Error: CustomStringConvertible {

    var description: String {
        switch self {
            case .noGistToken:
                return "There are no gist token"
            case .noGithubToken:
                return "There are no Github token"
            case .wrongURL(let string):
                return "Wrong URL: " + string
        }
    }
}

var arguments = CommandLine.arguments

var url = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
do {
    let data = try Data(contentsOf: url)
    let shortcuts = try JSONDecoder().decode(Shortcuts.self, from: data)
    let shortcut = shortcuts.shortcuts.randomElement()!

    let file = File(content: shortcut.description)
    let gist = Gist(description: "Updated by https://github.com/artemnovichkov/shortcut-box",
                    files: ["👨‍💻 New Xcode shortcut every day": file])

    guard let gistToken = ProcessInfo.processInfo.environment["GIST_TOKEN"] else {
        throw Error.noGistToken
    }

    let gistURLString = "https://api.github.com/gists/" + gistToken
    guard let url = URL(string: gistURLString) else {
        throw Error.wrongURL(gistURLString)
    }
    var request = URLRequest(url: url)

    guard let githubToken = ProcessInfo.processInfo.environment["GITHUB_TOKEN"] else {
        throw Error.noGithubToken
    }

    request.allHTTPHeaderFields = ["Authorization": "token " + githubToken]
    request.httpMethod = "PATCH"
    request.httpBody = try JSONEncoder().encode(gist)
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        print(data, response, error)
        exit(error == nil ? EXIT_SUCCESS : EXIT_FAILURE)
    }
    task.resume()
    RunLoop.main.run()
}
catch {
    print(error)
}
