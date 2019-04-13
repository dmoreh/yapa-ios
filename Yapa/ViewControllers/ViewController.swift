//
//  ViewController.swift
//  Yapa
//
//  Created by Daniel Moreh on 4/10/19.
//  Copyright © 2019 Daniel Moreh. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController {
    var player: AVPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        self.playLocalFile(fileName: "freaks")
        YapaAPI.getPodcasts { podcasts in
            print("success?")
            print("podcasts = \(podcasts)")
        }
    }

    @IBAction func playButtonPressed() {
        guard let status = self.player?.timeControlStatus else { return }
        switch status {
        case .paused:
            self.player?.play()
        case .playing:
            self.player?.pause()
        default:
            print("Unknown status reached in playButtonPressed")
        }
    }

    func play(url: URL) {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback)
            self.player = AVPlayer(url: url)
            self.player?.play()
        } catch {
            print(error)
        }
    }

    func playLocalFile(fileName: String) {
        guard let filePath = Bundle.main.path(forResource: fileName, ofType: "mp3") else {
            print("File does not exist in the bundle.")
            return
        }

        let url = URL(fileURLWithPath: filePath)

        self.play(url: url)
    }
}
