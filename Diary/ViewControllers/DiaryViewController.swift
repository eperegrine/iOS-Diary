//
//  DiaryViewController.swift
//  Diary
//
//  Created by Emily Peregrine on 14/09/2018.
//  Copyright © 2018 Emily Peregrine. All rights reserved.
//

import UIKit

class DiaryViewController: UIViewController {

    //MARK: UI Properties
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentView: UITextView!
    
    //MARK: Instance Variables
    var currentEntry: DiaryEntry = DiaryEntry(at: Date(), title: "A Trip to London", content: UTILS.lorem)
    
    //MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        applyEntryToView()
        navigationItem.title = currentEntry.title ?? currentEntry.gbDate
    }
    
    //MARK: Utility Methods
    func applyEntryToView(entry: DiaryEntry) {
        currentEntry = entry
        applyEntryToView()
    }
    
    func applyEntryToView() {
        dateLabel.text = currentEntry.gbDate
        titleLabel.text = currentEntry.title ?? ""
        contentView.text = currentEntry.content
    }
}
