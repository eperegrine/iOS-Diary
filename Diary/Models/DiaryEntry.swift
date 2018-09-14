//
//  DiaryEntry.swift
//  Diary
//
//  Created by Emily Peregrine on 14/09/2018.
//  Copyright © 2018 Emily Peregrine. All rights reserved.
//

import Foundation

class DiaryEntry: Codable {
    var date: Date = Date()
    var title: String?
    var content: String
    
    var gbDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: self.date)
    }
    
    init(at date: Date, title: String?, content: String) {
        self.date = date
        self.title = title
        self.content = content
    }
}
