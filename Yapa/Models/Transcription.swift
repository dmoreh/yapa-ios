//
//  Transcription.swift
//  Yapa
//
//  Created by Daniel Moreh on 4/12/19.
//  Copyright © 2019 Daniel Moreh. All rights reserved.
//

import Foundation

struct Transcription: Codable {
    let id: Int
    let episodeId: Int
    let sentences: [Sentence]!

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case episodeId = "episode_id"
        case sentences = "sentences"
    }
}

struct Sentence: Codable {
    let id: Int
    let start: Int
    let end: Int
    let text: String

    var startSeconds: TimeInterval {
        return Double(self.start) / 1000
    }

    var endSeconds: TimeInterval {
        return Double(self.end) / 1000
    }
}
