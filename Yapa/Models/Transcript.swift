//
//  Transcript.swift
//  Yapa
//
//  Created by Daniel Moreh on 4/12/19.
//  Copyright © 2019 Daniel Moreh. All rights reserved.
//

import Foundation

struct Transcript: Codable {
    let id: Int
    let sentences: [Sentence]?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case sentences = "transcription"
    }
}

struct Sentence: Codable {
    let start: Int
    let end: Int
    let text: String
}
