//
//  Book.swift
//  ReadingList
//
//  Created by Alex Rhodes on 8/20/19.
//  Copyright © 2019 Alex Rhodes. All rights reserved.
//

import Foundation

struct Book: Equatable, Codable {
    var title: String
    var reasonToRead: String
    var hasBeenRead: Bool
    
    init(title: String, reasonToRead: String, hasBeenRead: Bool = false) {
        self.title = title
        self.hasBeenRead = hasBeenRead
        self.reasonToRead = reasonToRead
    }
}
