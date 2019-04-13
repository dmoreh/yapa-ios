//
//  PodcastDetailViewController.swift
//  Yapa
//
//  Created by Daniel Moreh on 4/12/19.
//  Copyright © 2019 Daniel Moreh. All rights reserved.
//

import UIKit

class PodcastDetailViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!

    lazy var searchBar = UISearchBar(frame: .zero)

    var podcast: Podcast!
    var filteredEpisodes: [Episode]!

    static func initFromStoryboard(podcast: Podcast) -> PodcastDetailViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: PodcastDetailViewController.self)) as! PodcastDetailViewController
        viewController.podcast = podcast
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.coverImageView.af_setImage(withURL: self.podcast.imageURL)
        self.titleLabel.text = self.podcast.name
        self.subtitleLabel.text = self.podcast.author

        self.searchBar.placeholder = "Search"
        self.searchBar.delegate = self
        self.navigationItem.titleView = self.searchBar
        self.filteredEpisodes = self.podcast.episodes
    }
}

extension PodcastDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredEpisodes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: EpisodeTableViewCell.self), for: indexPath)
        (cell as? EpisodeTableViewCell)?.episode = self.filteredEpisodes[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
}

extension PodcastDetailViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episode = self.podcast.episodes[indexPath.row]
        let nowPlayingViewController = NowPlayingViewController.initFromStoryboard(podcast: self.podcast, episode: episode)
        self.navigationController?.pushViewController(nowPlayingViewController, animated: true)
    }
}

extension PodcastDetailViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            self.filteredEpisodes = self.podcast.episodes
            self.tableView.reloadData()
            return
        }

        YapaAPI.searchPodcast(podcastId: self.podcast.id, query: searchText) { results in
            let episodeIds = results.map { $0.episodeId }
            self.filteredEpisodes = self.podcast.episodes.filter { episodeIds.contains($0.id) }
            self.tableView.reloadData()
        }
    }
}
