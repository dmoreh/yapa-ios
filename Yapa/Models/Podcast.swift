//
//  Podcast.swift
//  Yapa
//
//  Created by Daniel Moreh on 4/12/19.
//  Copyright © 2019 Daniel Moreh. All rights reserved.
//

import Foundation

struct Podcast: Codable {
    let name: String
    let description: String
    let author: String
    let imageUrl: URL
    let episodes: [Episode]
}
