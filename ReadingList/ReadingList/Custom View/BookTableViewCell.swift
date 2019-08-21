//
//  BookTableViewCell.swift
//  ReadingList
//
//  Created by Alex Rhodes on 8/20/19.
//  Copyright © 2019 Alex Rhodes. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    @IBOutlet weak var bookTitleLabel: UILabel!
    @IBOutlet weak var hasBeenReadButton: UIButton!
    
    var bookController: BookController?
    
    var book: Book? {
        didSet {
           setViews()
        }
    }
    
    func setViews() {
        
         hasBeenReadButton.setBackgroundImage(UIImage(named: "unchecked"), for: .normal)
        
        guard let book = book else {return}
        
        bookTitleLabel.text = book.title
    }
    
    @IBAction func hasBeenReadButtonTapped(_ sender: UIButton) {
        let cell = self
        bookController?.toggleHasBeenRead(for: cell)
    }
}
