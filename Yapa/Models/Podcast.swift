//
//  Podcast.swift
//  Yapa
//
//  Created by Daniel Moreh on 4/12/19.
//  Copyright © 2019 Daniel Moreh. All rights reserved.
//

import Foundation

struct Podcast: Codable {
    let id: Int
    let name: String
    let description: String
    let author: String
    let imageURL: URL
    let episodes: [Episode]

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
        case description = "description"
        case author = "author"
        case imageURL = "image_url"
        case episodes = "episodes"
    }
}
