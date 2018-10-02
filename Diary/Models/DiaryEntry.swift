//
//  DiaryEntry.swift
//  Diary
//
//  Created by Emily Peregrine on 14/09/2018.
//  Copyright © 2018 Emily Peregrine. All rights reserved.
//

import Foundation

class DiaryEntry: NSObject, NSCoding {
    struct PropertyKey {
        static let date = "date"
        static let title = "title"
        static let content = "content"
    }
    
    var date: Date = Date()
    var title: String?
    var content: String
    
    //MARK: Archiving Paths
    static let DocumentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.appendingPathComponent("entries")
    
    static var dateFormatter: DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yyyy"
        return df
    }
    
    static func formatDate(from date: Date) -> String {
        return dateFormatter.string(from: date)
    }
    
    var gbDate: String {
        return DiaryEntry.formatDate(from: self.date)
    }
    
    init(at date: Date, title: String?, content: String) {
        self.date = date
        self.title = title
        self.content = content
    }
    
    //MARK: NSCoding
    func encode(with aCoder: NSCoder) {
        aCoder.encode(date, forKey: PropertyKey.date)
        aCoder.encode(title, forKey: PropertyKey.title)
        aCoder.encode(content, forKey: PropertyKey.content)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        guard let date = aDecoder.decodeObject(forKey: PropertyKey.date) as? Date else {
            fatalError("Unable to resolve date for diary entry")
        }
        
        guard let content = aDecoder.decodeObject(forKey: PropertyKey.content) as? String else {
            fatalError("Unable to resolve content for diary entry")
        }
        
        let title = aDecoder.decodeObject(forKey: PropertyKey.title) as? String
        
        self.init(at: date, title: title, content: content)
    }
    
    //MARK: String encoding
    convenience init(withString str: String) {
        let splitStr = str.split(separator: "§")
        if (splitStr.count != 3) {
            fatalError("Inavlid DiaryEntry intialiser string")
        } else {
            let dateStr = String(splitStr[0])
            let titleStr = String(splitStr[1])
            let contentStr = String(splitStr[2])
            let date = DiaryEntry.dateFormatter.date(from: dateStr)!
            self.init(at: date, title: titleStr, content: contentStr)
        }
    }
    
    func encodeToString() -> String {
        var result = ""
        result += DiaryEntry.dateFormatter.string(from: self.date) + "§"
        result += self.title ?? "" + "§"
        result += content
        return result
    }
}
