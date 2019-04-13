//
//  NowPlayingViewController.swift
//  Yapa
//
//  Created by Daniel Moreh on 4/12/19.
//  Copyright © 2019 Daniel Moreh. All rights reserved.
//

import UIKit
import AVKit

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
    var audioPlayer: AVAudioPlayer?

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
        self.setupAudioPlayer()
    }

    private func setupAudioPlayer() {
        let path = Bundle.main.path(forResource: "freaks", ofType: "mp3")!
        let url = URL(fileURLWithPath: path)

        do {
            self.audioPlayer = try AVAudioPlayer(contentsOf: url)
            self.audioPlayer?.prepareToPlay()
        } catch {
            print(error)
        }
    }

    @IBAction func sliderValueChanged() {
    }

    @IBAction func playPauseButtonPressed() {
        guard let audioPlayer = self.audioPlayer else { return }
        if audioPlayer.isPlaying {
            audioPlayer.pause()
        } else {
            audioPlayer.play()
        }
    }

    @IBAction func backButtonPressed() {
    }

    @IBAction func forwardButtonPressed() {
    }

    @IBAction func transcriptButtonPressed() {
    }
}
