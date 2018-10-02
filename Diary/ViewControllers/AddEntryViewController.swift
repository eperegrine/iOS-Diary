//
//  AddEntryViewController.swift
//  Diary
//
//  Created by Emily Peregrine on 17/09/2018.
//  Copyright © 2018 Emily Peregrine. All rights reserved.
//

import UIKit

class AddEntryViewController: UIViewController, UITextFieldDelegate, UITextViewDelegate {

    //MARK: Properties
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var DateLabel: UILabel!
    @IBOutlet weak var TitleTextField: UITextField!
    @IBOutlet weak var ContentTextView: UITextView!
    @IBOutlet weak var contentViewBottomConstraint: NSLayoutConstraint!
    
    var origBottomConstraint: CGFloat?
    
    //MARK: Setup
    override func viewDidLoad() {
        super.viewDidLoad()
        TitleTextField.delegate = self
        ContentTextView.delegate = self
        DateLabel.text = DiaryEntry.formatDate(from: Date())
        
        origBottomConstraint = contentViewBottomConstraint.constant
        
        TitleTextField.inputAccessoryView = setupToolbar(actionTitle: "Next", actionStyle: .plain, action: #selector(focusContentEditor))
        ContentTextView.inputAccessoryView = setupToolbar(actionTitle: "Done", actionStyle: .done, action: #selector(doneButtonAction))
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:UIResponder.keyboardWillShowNotification, object: nil);
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:UIResponder.keyboardWillHideNotification, object: nil);
    }
    
    func setupToolbar(actionTitle: String, actionStyle: UIBarButtonItem.Style, action: Selector) -> UIToolbar {
        let toolbar:UIToolbar = UIToolbar(frame: CGRect(x: 0, y: 0,  width: self.view.frame.size.width, height: 30))
        //create left side empty space so that done button set on right side
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBtn: UIBarButtonItem = UIBarButtonItem(title: actionTitle, style: actionStyle, target: self, action: action)
        toolbar.setItems([flexSpace, doneBtn], animated: false)
        toolbar.sizeToFit()
        
        return toolbar
    }
    
    @objc func doneButtonAction() {
        self.view.endEditing(true)
    }
    
    @objc func focusContentEditor() {
        TitleTextField.resignFirstResponder()
        ContentTextView.becomeFirstResponder()
    }
    
    //MARK: Save
    
    func getEntry() -> DiaryEntry {
        return DiaryEntry(at: Date(), title: "TEST_TILE", content: "TEST_CONTENT")
    }
    
    func saveToFileSystem() {
        var newEntries: [DiaryEntry] = []
        //Load the saved entries if they exist
        if let entries = NSKeyedUnarchiver.unarchiveObject(withFile: DiaryEntry.ArchiveURL.path) as? [DiaryEntry] {
            newEntries = entries
        }
        newEntries.append(getEntry())
        
        let successfulSave = NSKeyedArchiver.archiveRootObject(newEntries, toFile: DiaryEntry.ArchiveURL.path)
        if successfulSave {
            print("Successfully saved entries")
        } else {
            print("Failed to save entries")
        }
    }
    
    @IBAction func Save(_ sender: UIBarButtonItem) {
        print("Saving...")
        saveToFileSystem()
        Cancel(sender)
    }
    
    
    // MARK: - Navigation
    @IBAction func Cancel(_ sender: Any) {
        if (ContentTextView.isFirstResponder || TitleTextField.isFirstResponder) {
            ContentTextView.resignFirstResponder()
            TitleTextField.resignFirstResponder()
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
   
    //MARK: UITextFieldDelegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        focusContentEditor()
        return true
    }
    
    //MARK: Keyboard Events
    @objc func keyboardWillShow(sender: NSNotification) {
        let info = sender.userInfo!
        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        contentViewBottomConstraint.constant = keyboardFrame.height + 8
    }
    
    @objc func keyboardWillHide(sender: NSNotification) {
        contentViewBottomConstraint.constant = origBottomConstraint ?? 8
    }
}
