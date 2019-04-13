//
//  Episode.swift
//  Yapa
//
//  Created by Daniel Moreh on 4/12/19.
//  Copyright © 2019 Daniel Moreh. All rights reserved.
//

import Foundation

struct Episode: Codable {
    let title: String
    let publicationDate: String
    let showNotes: String
    let audioUrl: URL
    let transcript: [Transcript]
}
