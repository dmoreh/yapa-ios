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
    let podcastId: Int
    let title: String?
    let publicationDate: String
    let showNotes: String
    let audioURL: URL
    let transcription: Transcription?
    let strippedSubtitle: String?

    var audioFileURL: URL {
        let filename = "podcast-\(self.podcastId)-episode-\(self.id)"
        let path = Bundle.main.path(forResource: filename, ofType: "mp3")!
        return URL(fileURLWithPath: path)
    }

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case podcastId = "podcast_id"
        case title = "title"
        case publicationDate = "publication_date"
        case showNotes = "show_notes"
        case audioURL = "audio_url"
        case transcription = "transcription"
        case strippedSubtitle = "stripped_subtitle"
    }
}
