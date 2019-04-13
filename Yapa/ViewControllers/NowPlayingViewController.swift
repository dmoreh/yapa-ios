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
    var timer: Timer?

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
        DispatchQueue.global().async {
            self.setupAudioPlayer()
            DispatchQueue.main.async {
                self.updateTime()
            }
        }
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

    @objc private func updateTime() {
        guard let audioPlayer = self.audioPlayer else { return }

        self.currentTimeLabel.text = self.formattedString(timeInterval: audioPlayer.currentTime)
        self.timeRemainingLabel.text = "-" + self.formattedString(timeInterval: audioPlayer.duration - audioPlayer.currentTime)
    }

    private func formattedString(timeInterval: TimeInterval) -> String {
        let totalSeconds = Int(timeInterval)
        let hours = totalSeconds / 60 / 60
        let minutes = totalSeconds / 60 % 60
        let seconds = totalSeconds % 60

        if hours == 0 {
            return String(format:"%02i:%02i", minutes, seconds)
        }
        return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
    }

    @IBAction func sliderValueChanged() {
    }

    @IBAction func playPauseButtonPressed() {
        guard let audioPlayer = self.audioPlayer else { return }
        if audioPlayer.isPlaying {
            audioPlayer.pause()
            self.timer?.invalidate()
        } else {
            audioPlayer.play()
            self.timer = Timer.scheduledTimer(timeInterval: 0.3,
                                              target: self,
                                              selector: #selector(updateTime),
                                              userInfo: nil,
                                              repeats: true)
        }
    }

    @IBAction func backButtonPressed() {
    }

    @IBAction func forwardButtonPressed() {
    }

    @IBAction func transcriptButtonPressed() {
    }
}
