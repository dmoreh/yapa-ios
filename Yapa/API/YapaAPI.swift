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
    static var requestId = 0

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
        self.requestId += 1
        Alamofire.request(self.baseURL + "search",
                          method: .get,
                          parameters: ["podcast_id": podcastId, "query": query, "request_id": self.requestId],
                          encoding: URLEncoding.default,
                          headers: nil)
            .validate()
            .responseJSON { response in
                guard let data = response.data else { return }
                do {
                    let searchResponse = try JSONDecoder().decode(SearchResponse.self, from: data)
                    guard searchResponse.requestId == self.requestId else { return }
                    completion?(searchResponse.results)
                } catch {
                    print(error)
                }
        }
    }

    static func searchEpisode(episodeId: Int, query: String, _ completion: (([SearchResult]) -> Void)?) {
        self.requestId += 1
        Alamofire.request(self.baseURL + "search",
                          method: .get,
                          parameters: ["episode_id": episodeId, "query": query, "request_id": self.requestId],
                          encoding: URLEncoding.default,
                          headers: nil)
            .validate()
            .responseJSON { response in
                guard let data = response.data else { return }
                do {
                    let searchResponse = try JSONDecoder().decode(SearchResponse.self, from: data)
                    guard searchResponse.requestId == self.requestId else { return }
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
    let requestId: Int

    enum CodingKeys: String, CodingKey {
        case results = "results"
        case requestId = "request_id"
    }
}

struct SearchResult: Codable {
    let episodeId: Int
    let sentenceIds: [Int]

    enum CodingKeys: String, CodingKey {
        case episodeId = "episode_id"
        case sentenceIds = "sentence_ids"
    }
}
