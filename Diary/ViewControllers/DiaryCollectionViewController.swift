//
//  ViewController.swift
//  Diary
//
//  Created by Emily Peregrine on 14/09/2018.
//  Copyright © 2018 Emily Peregrine. All rights reserved.
//

import UIKit

fileprivate let reuseIdentifier = "DiaryEntryCell"
fileprivate let detailSegueIdentifier = "EntryDetailSelect"

class DiaryCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var entryCollectionView: UICollectionView!
    
    var entries: [DiaryEntry] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        entries = getSampleData()
        // Do any additional setup after loading the view, typically from a nib.
        entryCollectionView.delegate = self
        entryCollectionView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == detailSegueIdentifier) {
            guard let selectedEntryCell = sender as? DiaryEntryCollectionViewCell else {
                fatalError("Unexpected sender: \(sender ?? "nil")")
            }
            guard let detailViewController = segue.destination as? DiaryViewController else {
                fatalError("UnexpectedDestination: \(segue.destination)")
            }
            guard let selectedEntry = selectedEntryCell.entry else {
                fatalError("Selected cell has no diary")
            }
            
            detailViewController.currentEntry = selectedEntry
            
        } else {
            print("UNKOWN SEGUE")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("Hello!!!!")
        entries = loadData()
        entryCollectionView.reloadData()
    }
    //MARK: UICollectionViewDeletegate Methods
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected item", entries[indexPath.item])
    }
    
    //MARK: UICollectionViewDataSource Protocol Methods
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return entries.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let vc = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? DiaryEntryCollectionViewCell else {
            fatalError("The deques cell is not an instance of diary entry view cell")
        }
        vc.entry = entries[indexPath.item]
        return vc
    }
    
    //MARK: Data
    func getSampleData() -> [DiaryEntry] {
        return [
            DiaryEntry(at: Date(), title: "Lorem", content: UTILS.lorem),
            DiaryEntry(at: Date(), title: nil, content: UTILS.lorem),
            DiaryEntry(at: Date(), title: "Lorem3", content: UTILS.lorem)
        ]
    }
    
    func loadData() -> [DiaryEntry] {
        if let loadedEntries = NSKeyedUnarchiver.unarchiveObject(withFile: DiaryEntry.ArchiveURL.path) as? [DiaryEntry] {
            var retEntries = getSampleData()
            retEntries.append(contentsOf: loadedEntries)
            return retEntries
        }
        return getSampleData()
    }
}

