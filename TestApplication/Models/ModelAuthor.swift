//
//  ModelAuthor.swift
//  TestApplication
//
//  Created by JARVIS on 02.11.2020.
//

import Foundation

// MARK: - Authors
struct Authors: Codable {
    let uri: String
    let author: [Author]?

    enum CodingKeys: String, CodingKey {
        case uri = "@uri"
        case author
    }
}

// MARK: - Author
struct Author: Codable, Identifiable {
    var id: String {
        authorid ?? uri
    }
    let uri: String
    let approved, authordisplay, authorfirst, authorfirstlc: String?
    let authorid, authorlast, authorlastfirst, authorlastlc: String?
    let titles: Titles?
    let lastinitial: String?
    let photocredit, photodate, spotlight: String?
    let works: Works?

    enum CodingKeys: String, CodingKey {
        case uri = "@uri"
        case approved, authordisplay, authorfirst, authorfirstlc, authorid, authorlast, authorlastfirst, authorlastlc, titles, lastinitial, photocredit, photodate, spotlight, works
    }
}

// MARK: - Titles
struct Titles: Codable {
    let isbn: [Isbn]
}

// MARK: - Isbn
struct Isbn: Codable {
    let contributortype: String?
    let empty: String?

    enum CodingKeys: String, CodingKey {
        case contributortype = "@contributortype"
        case empty = "$"
    }
}

enum Contributortype: String, Codable {
    case a = "A"
    case the4A = "4 A"
    case u = "U"
}


// MARK: - WorksClass
struct Works: Codable {
    let works: WorksUnion
}

enum WorksUnion: Codable {
    case string(String)
    case stringArray([String])

    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([String].self) {
            self = .stringArray(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        throw DecodingError.typeMismatch(WorksUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for WorksUnion"))
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let x):
            try container.encode(x)
        case .stringArray(let x):
            try container.encode(x)
        }
    }
}
