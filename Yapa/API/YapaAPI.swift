//
//  YapaAPI.swift
//  Yapa
//
//  Created by Daniel Moreh on 4/12/19.
//  Copyright © 2019 Daniel Moreh. All rights reserved.
//

import Foundation
import Alamofire

struct YapaAPI {
    static let baseURL = "https://yapa-app.herokuapp.com/"

    static func getPodcasts(_ completion: (([Podcast]) -> Void)?) {
        Alamofire.request(self.baseURL + "podcasts",
                          method: .get,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: nil)
            .validate()
            .responseJSON { response in
                guard let data = response.data else { return }
                do {
                    let podcastResponse = try JSONDecoder().decode(PodcastResponse.self, from: data)
                    completion?(podcastResponse.podcasts)
                } catch {
                    print(error)
                }
        }
    }
}

struct PodcastResponse: Codable {
    let podcasts: [Podcast]
}
