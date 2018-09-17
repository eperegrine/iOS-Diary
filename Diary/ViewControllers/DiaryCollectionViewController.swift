//
//  ViewController.swift
//  Diary
//
//  Created by Emily Peregrine on 14/09/2018.
//  Copyright © 2018 Emily Peregrine. All rights reserved.
//

import UIKit

fileprivate let reuseIdentifier = "DiaryEntryCell"

class DiaryCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var entryCollectionView: UICollectionView!
    
    let entries: [DiaryEntry] = [
        DiaryEntry(at: Date(), title: "Lorem", content: UTILS.lorem),
        DiaryEntry(at: Date(), title: "Lorem2", content: UTILS.lorem),
        DiaryEntry(at: Date(), title: "Lorem3", content: UTILS.lorem),
        DiaryEntry(at: Date(), title: "Lorem4", content: UTILS.lorem),
        DiaryEntry(at: Date(), title: "Lorem5", content: UTILS.lorem),
        DiaryEntry(at: Date(), title: "Lorem6", content: UTILS.lorem),
        DiaryEntry(at: Date(), title: "Lorem7", content: UTILS.lorem),
        DiaryEntry(at: Date(), title: "Lorem8", content: UTILS.lorem),
        DiaryEntry(at: Date(), title: "Lorem9", content: UTILS.lorem),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        entryCollectionView.delegate = self
        entryCollectionView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        vc.setDiary(to: entries[indexPath.item])
        return vc
    }
    
}

