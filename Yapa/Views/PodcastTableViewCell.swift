//
//  PodcastTableViewCell.swift
//  Yapa
//
//  Created by Daniel Moreh on 4/12/19.
//  Copyright © 2019 Daniel Moreh. All rights reserved.
//

import UIKit
import AlamofireImage

class PodcastTableViewCell: UITableViewCell {
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subtitleLabel: UILabel!
    
    var podcast: Podcast! {
        didSet {
            self.coverImageView.af_setImage(withURL: self.podcast.imageURL)
            self.titleLabel.text = self.podcast.name
            self.subtitleLabel.text = self.podcast.author
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
