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

    var searchTerm: String?

    var sentence: Sentence! {
        didSet {
            self.timeLabel.text = self.formattedString(timeInterval: sentence.startSeconds)
            self.contentLabel.text = sentence.text

            if let searchTerm = self.searchTerm, let range = sentence.text.lowercased().range(of: searchTerm.lowercased()) {
                let attributedText = NSMutableAttributedString(string: sentence.text)
                let nsRange = NSMakeRange(range.lowerBound.encodedOffset, range.upperBound.encodedOffset - range.lowerBound.encodedOffset)
                attributedText.addAttribute(NSAttributedString.Key.font, value: UIFont.boldSystemFont(ofSize: self.contentLabel.font.pointSize), range: nsRange)
                attributedText.addAttribute(NSAttributedString.Key.backgroundColor, value: UIColor.lightOrange, range: nsRange)

                self.contentLabel.attributedText = attributedText
            }
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
        self.backgroundColor = selected ? .lightOrange : .white
    }
}
