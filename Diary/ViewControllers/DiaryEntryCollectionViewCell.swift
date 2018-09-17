//
//  DiaryEntryCollectionViewCell.swift
//  Diary
//
//  Created by Emily Peregrine on 14/09/2018.
//  Copyright © 2018 Emily Peregrine. All rights reserved.
//

import UIKit

class DiaryEntryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var TitleLabel: UILabel!

    private var diary: DiaryEntry?
    
    func setDiary(to diary: DiaryEntry) {
        self.diary = diary
        
        DateLabel.text = diary.gbDate
        TitleLabel.text = diary.title
    }
    
}
