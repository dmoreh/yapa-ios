//
//  Episode.swift
//  Yapa
//
//  Created by Daniel Moreh on 4/12/19.
//  Copyright © 2019 Daniel Moreh. All rights reserved.
//

import Foundation

struct Episode: Codable {
    let id: Int
    let title: String?
    let publicationDate: String
    let showNotes: String
    let audioURL: URL
    let transcript: Transcript?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case publicationDate = "publication_date"
        case showNotes = "show_notes"
        case audioURL = "audio_url"
        case transcript = "transcription"
    }
}
