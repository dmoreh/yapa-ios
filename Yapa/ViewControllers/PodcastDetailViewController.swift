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

    var podcast: Podcast!

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
    }
}

extension PodcastDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.podcast.episodes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: EpisodeTableViewCell.self), for: indexPath)
        (cell as? EpisodeTableViewCell)?.episode = self.podcast.episodes[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
}

extension PodcastDetailViewController: UITableViewDelegate {

}
