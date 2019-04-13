//
//  PodcastViewController.swift
//  Yapa
//
//  Created by Daniel Moreh on 4/12/19.
//  Copyright © 2019 Daniel Moreh. All rights reserved.
//

import UIKit

class PodcastViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    var podcasts: [Podcast] = [] {
        didSet {
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        YapaAPI.getPodcasts { podcasts in
            self.podcasts = podcasts
        }
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let podcastDetailViewController = segue.destination as? PodcastDetailViewController,
            let indexPath = tableView.indexPathForSelectedRow
            else { return }
        podcastDetailViewController.podcast = self.podcasts[indexPath.row]
    }
}

extension PodcastViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.podcasts.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: PodcastTableViewCell.self), for: indexPath)

        (cell as? PodcastTableViewCell)?.podcast = self.podcasts[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 88
    }
}

extension PodcastViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let podcast = self.podcasts[indexPath.row]
        let podcastDetailViewController = PodcastDetailViewController.initFromStoryboard(podcast: podcast)
        self.navigationController?.pushViewController(podcastDetailViewController, animated: true)
    }
}
