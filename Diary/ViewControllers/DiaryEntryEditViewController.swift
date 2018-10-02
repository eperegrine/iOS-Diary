//
//  DiaryEntryEditViewController.swift
//  Diary
//
//  Created by Emily Peregrine on 02/10/2018.
//  Copyright © 2018 Emily Peregrine. All rights reserved.
//

import UIKit

class DiaryEntryEditViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var DateInputField: UITextField!
    @IBOutlet weak var TitleInputField: UITextField!
    @IBOutlet weak var ContentTextView: UITextView!
    
    var entry: DiaryEntry?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let a = [1, 2, 3]
        print(a.lastIndex)
        
        DateInputField.inputView = UIDatePicker()
        
        if let entry = entry {
            DateInputField.text = entry.gbDate
        }
        
    }
}
