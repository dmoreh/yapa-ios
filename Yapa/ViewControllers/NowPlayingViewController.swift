//
//  NowPlayingViewController.swift
//  Yapa
//
//  Created by Daniel Moreh on 4/12/19.
//  Copyright © 2019 Daniel Moreh. All rights reserved.
//

import UIKit

class NowPlayingViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var slider: UISlider!
    @IBOutlet weak var currentTimeLabel: UILabel!
    @IBOutlet weak var timeRemainingLabel: UILabel!
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var forwardButton: UIButton!

    var podcast: Podcast!

    var episode: Episode!

    static func initFromStoryboard(podcast: Podcast, episode: Episode) -> NowPlayingViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: NowPlayingViewController.self)) as! NowPlayingViewController
        viewController.podcast = podcast
        viewController.episode = episode
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.imageView.af_setImage(withURL: self.podcast.imageURL)
    }

    @IBAction func sliderValueChanged() {
    }

    @IBAction func playPauseButtonPressed() {
    }

    @IBAction func backButtonPressed() {
    }

    @IBAction func forwardButtonPressed() {
    }

    @IBAction func transcriptButtonPressed() {
    }
}
