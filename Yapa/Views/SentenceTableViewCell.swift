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
            self.timeLabel.text = "\(sentence.startSeconds)"
            self.contentLabel.text = sentence.text
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
    }
}
