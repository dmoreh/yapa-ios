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
    var filteredSentences: [Sentence]!
    var firstSentence: Sentence?

    lazy var searchBar = UISearchBar(frame: .zero)

    weak var delegate: TranscriptionDelegate!

    static func initFromStoryboard(transcription: Transcription?, currentSentence: Sentence?) -> TranscriptViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: TranscriptViewController.self)) as! TranscriptViewController
        viewController.transcription = transcription
        viewController.firstSentence = currentSentence
        return viewController
    }

    private func highlightSentence(_ sentence: Sentence) {
        guard let row = self.filteredSentences.firstIndex(where: { $0.id == sentence.id }) else {
            if let selectedRow = self.tableView.indexPathForSelectedRow {
                self.tableView.deselectRow(at: selectedRow, animated: true)
            }
            return
        }
        let indexPath = IndexPath(row: row, section: 0)
        self.tableView.selectRow(at: indexPath, animated: true, scrollPosition: .none)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.searchBar.searchBarStyle = .prominent
        self.searchBar.placeholder = "Search"
        self.searchBar.delegate = self
        self.navigationItem.titleView = self.searchBar
        self.filteredSentences = self.transcription.sentences

        if let firstSentence = self.firstSentence {
            let firstSentenceIndexPath = IndexPath(row: firstSentence.id, section: 0)
            self.tableView.scrollToRow(at: firstSentenceIndexPath, at: .middle, animated: false)
        }
    }
}

extension TranscriptViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredSentences.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: SentenceTableViewCell.self), for: indexPath)
        (cell as? SentenceTableViewCell)?.sentence = self.filteredSentences[indexPath.row]
        return cell
    }
}

extension TranscriptViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.didSelectSentence(sentence: self.filteredSentences[indexPath.row])
    }
}

extension TranscriptViewController: NowPlayingDelegate {
    func didChangeCurrentSentence(_ sentence: Sentence?) {
        guard let sentence = sentence else { return }
        self.highlightSentence(sentence)
    }
}

extension TranscriptViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            self.filteredSentences = self.transcription.sentences
            self.tableView.reloadData()
            return
        }

        YapaAPI.searchEpisode(episodeId: self.transcription.episodeId, query: searchText) { results in
            guard let sentenceIds = results.first?.sentenceIds else { return }
            self.filteredSentences = self.transcription.sentences.filter { sentenceIds.contains($0.id) }
            self.tableView.reloadData()
        }
    }}
