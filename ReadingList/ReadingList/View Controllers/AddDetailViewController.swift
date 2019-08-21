//
//  AddDetailViewController.swift
//  ReadingList
//
//  Created by Alex Rhodes on 8/20/19.
//  Copyright © 2019 Alex Rhodes. All rights reserved.
//

import UIKit

class AddDetailViewController: UIViewController {
    
    var bookController: BookController?
    
    var book: Book?

    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var reasonToReadTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let book = book {
        bookTitleTextField.text = book.title
        reasonToReadTextView.text = book.reasonToRead
    }
    }
    

    
    @IBAction func saveButtonTapped(_ sender: UIBarButtonItem) {
        guard let title = bookTitleTextField.text, !title.isEmpty,
            let reason = reasonToReadTextView.text, !reason.isEmpty else {return}
       bookController?.createBook(title, reasonToRead: reason, hasBeenRead: false)
        bookController?.saveToPersistentStore()
        navigationController?.popViewController(animated: true)
    }
}
