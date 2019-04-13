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
    @IBOutlet weak var transcriptButton: UIButton!

    var podcast: Podcast!
    var episode: Episode!
    var audioPlayer: AVAudioPlayer?
    var timer: Timer?

    var currentSentence: Sentence? {
        guard let sentences = self.episode.transcription?.sentences,
            let currentTime = self.audioPlayer?.currentTime
            else { return nil }

        for sentence in sentences {
            if sentence.startSeconds <= currentTime && currentTime <= sentence.endSeconds {
                return sentence
            }
        }

        return nil
    }

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

        self.transcriptButton.isHidden = self.episode.transcription?.sentences == nil
    }

    private func setupAudioPlayer() {
        do {
            self.audioPlayer = try AVAudioPlayer(contentsOf: self.episode.audioFileURL)
            self.audioPlayer?.prepareToPlay()
        } catch {
            print(error)
        }
    }

    @objc private func updateTime() {
        guard let audioPlayer = self.audioPlayer else { return }

        self.currentTimeLabel.text = self.formattedString(timeInterval: audioPlayer.currentTime)
        self.timeRemainingLabel.text = "-" + self.formattedString(timeInterval: audioPlayer.duration - audioPlayer.currentTime)

        let progressPercent = audioPlayer.currentTime / audioPlayer.duration
        self.slider.value = Float(progressPercent)
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
        guard let audioPlayer = self.audioPlayer else { return }
        audioPlayer.currentTime = audioPlayer.duration * Double(self.slider.value)
    }

    @IBAction func playPauseButtonPressed() {
        guard let audioPlayer = self.audioPlayer else { return }
        if audioPlayer.isPlaying {
            audioPlayer.pause()
            self.playPauseButton.setImage(UIImage(named: "play"), for: .normal)
            self.timer?.invalidate()
        } else {
            audioPlayer.play()
            self.playPauseButton.setImage(UIImage(named: "pause"), for: .normal)
            self.timer = Timer.scheduledTimer(timeInterval: 0.3,
                                              target: self,
                                              selector: #selector(updateTime),
                                              userInfo: nil,
                                              repeats: true)
        }
    }

    @IBAction func backButtonPressed() {
        guard let currentSentence = self.currentSentence else { return }
        self.seekToSentence(id: currentSentence.id - 1)
    }

    @IBAction func forwardButtonPressed() {
        guard let currentSentence = self.currentSentence else { return }
        self.seekToSentence(id: currentSentence.id + 1)
    }

    @IBAction func transcriptButtonPressed() {
        let transcriptViewController = TranscriptViewController.initFromStoryboard(transcription: self.episode.transcription)
        transcriptViewController.delegate = self
        self.navigationController?.pushViewController(transcriptViewController, animated: true)
    }

    private func seekToSentence(_ sentence: Sentence) {
        self.audioPlayer?.currentTime = sentence.startSeconds
        self.audioPlayer?.play()
        self.updateTime()
    }

    private func seekToSentence(id: Int) {
        guard let sentence = self.episode.transcription?.sentences.first(where: { $0.id == id }) else { return }
        self.seekToSentence(sentence)
    }
}

extension NowPlayingViewController: TranscriptionDelegate {
    func didSelectSentence(sentence: Sentence) {
        self.seekToSentence(sentence)
    }
}
