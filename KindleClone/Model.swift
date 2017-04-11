//
//  Model.swift
//  KindleClone
//
//  Created by Thai Cao Ngoc on 10/4/17.
//  Copyright © 2017 Thai Cao Ngoc. All rights reserved.
//

import UIKit

class Book {
    let coverImageUrl: String
    let title: String
    let author: String
    let pages: [String]
    
    init(title: String, by author: String, coverImageUrl: String, content pages: [String]) {
        self.title = title
        self.author = author
        self.coverImageUrl = coverImageUrl
        self.pages = pages
    }

}
