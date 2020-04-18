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

    let name: String
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
    case noShortcuts
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
    let arguments = CommandLine.arguments

    guard arguments.count >= 2 else {
        throw Error.wrongArguments
    }

    var shortcutsURL = URL(fileURLWithPath: FileManager.default.currentDirectoryPath)
    shortcutsURL.appendPathComponent(arguments[1])

    let data = try Data(contentsOf: shortcutsURL)
    let shortcuts = try JSONDecoder().decode(Shortcuts.self, from: data)
    guard let shortcut = shortcuts.shortcuts.randomElement() else {
        throw Error.noShortcuts
    }

    let file = File(content: shortcut.description)
    let gist = Gist(description: "👨‍💻 New \(shortcuts.name) shortcut every day",
                    files: ["shortcut.md": file])

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
        if let response = response as? HTTPURLResponse {
            exit((200...299) ~= response.statusCode ? EXIT_SUCCESS : EXIT_FAILURE)
        }
        exit(error == nil ? EXIT_SUCCESS : EXIT_FAILURE)
    }
    task.resume()
    RunLoop.main.run()
}
catch {
    print(error)
    exit(EXIT_FAILURE)
}
