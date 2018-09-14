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
}
