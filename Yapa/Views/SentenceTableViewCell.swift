//
//  SentenceTableViewCell.swift
//  Yapa
//
//  Created by Daniel Moreh on 4/13/19.
//  Copyright © 2019 Daniel Moreh. All rights reserved.
//

import UIKit

class SentenceTableViewCell: UITableViewCell {
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!

    var sentence: Sentence! {
        didSet {
            self.timeLabel.text = self.formattedString(timeInterval: sentence.startSeconds)
            self.contentLabel.text = sentence.text
        }
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

    override func setSelected(_ selected: Bool, animated: Bool) {
    }
}
