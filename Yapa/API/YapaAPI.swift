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

    static func searchPodcast(podcastId: Int, query: String, _ completion: (([SearchResult]) -> Void)?) {
        Alamofire.request(self.baseURL + "search",
                          method: .get,
                          parameters: ["podcast_id": podcastId, "query": query],
                          encoding: URLEncoding.default,
                          headers: nil)
            .validate()
            .responseJSON { response in
                guard let data = response.data else { return }
                do {
                    let searchResponse = try JSONDecoder().decode(SearchResponse.self, from: data)
                    completion?(searchResponse.results)
                } catch {
                    print(error)
                }
        }

    }
}

struct PodcastResponse: Codable {
    let podcasts: [Podcast]
}

struct SearchResponse: Codable {
    let results: [SearchResult]
}

struct SearchResult: Codable {
    let episodeId: Int
    let sentenceIds: [Int]

    enum CodingKeys: String, CodingKey {
        case episodeId = "episode_id"
        case sentenceIds = "sentence_ids"
    }
}
