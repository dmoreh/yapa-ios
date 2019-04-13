//
//  TranscriptViewController.swift
//  Yapa
//
//  Created by Daniel Moreh on 4/13/19.
//  Copyright © 2019 Daniel Moreh. All rights reserved.
//

import UIKit

protocol TranscriptionDelegate: class {
    func didSelectSentence(sentence: Sentence)
}

class TranscriptViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    var transcription: Transcription!

    weak var delegate: TranscriptionDelegate!

    static func initFromStoryboard(transcription: Transcription?) -> TranscriptViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: TranscriptViewController.self)) as! TranscriptViewController
        viewController.transcription = transcription
        return viewController
    }

    private func highlightSentence(_ sentence: Sentence) {
        let indexPath = IndexPath(row: sentence.id, section: 0)
        self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension TranscriptViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.transcription.sentences?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SentenceTableViewCell.self), for: indexPath)
        (cell as? SentenceTableViewCell)?.sentence = self.transcription.sentences?[indexPath.row]
        return cell
    }
}

extension TranscriptViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.didSelectSentence(sentence: self.transcription.sentences[indexPath.row])
    }
}

extension TranscriptViewController: NowPlayingDelegate {
    func didChangeCurrentSentence(_ sentence: Sentence?) {
        guard let sentence = sentence else { return }
        self.highlightSentence(sentence)
    }
}
