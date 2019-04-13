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
    let sentences: [Sentence]?
}

struct Sentence: Codable {
    let id: Int
    let start: Int
    let end: Int
    let text: String
}
