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
    var audioPlayer: AVAudioPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
//        self.playLocalFile()

    }

    func playUsingAVAudioPlayer(url: URL) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print(error)
        }
    }

    func playLocalFile() {
        guard let filePath = Bundle.main.path(forResource: "freaks", ofType: "mp3") else {
            print("File does not exist in the bundle.")
            return
        }

        let url = URL(fileURLWithPath: filePath)

        playUsingAVAudioPlayer(url: url)
    }

}

