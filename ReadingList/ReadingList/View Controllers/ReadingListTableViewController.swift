//
//  RadingListTableViewController.swift
//  ReadingList
//
//  Created by Alex Rhodes on 8/20/19.
//  Copyright © 2019 Alex Rhodes. All rights reserved.
//

import UIKit

class ReadingListTableViewController: UITableViewController {
    
    var bookController = BookController()
    

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tableView.reloadData()
        bookController.loadFromPersistentStore()
    }
    
    
    // MARK: - Table view data source
    
    private func bookFor(indexPath: IndexPath) -> Book {
        if indexPath.section == 0 {
            return bookController.readBooks[indexPath.row]
        } else {
            return bookController.unreadBooks[indexPath.row]
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            guard bookController.readBooks.count > 0 else {return nil}
            return "Read Books"
            
        } else {
            guard bookController.unreadBooks.count > 0 else {return nil}
            return "Unread Books"
            
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return bookController.readBooks.count
        } else {
            return bookController.unreadBooks.count
        }
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "BookCell", for: indexPath) as? BookTableViewCell else {return UITableViewCell()}
        
        cell.book = bookFor(indexPath: indexPath)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        switch indexPath.section {
        case 0:
            if editingStyle == UITableViewCell.EditingStyle.delete {
                bookController.books.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
                bookController.saveToPersistentStore()}
        case 1:
            if editingStyle == UITableViewCell.EditingStyle.delete {
                bookController.books.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
                bookController.saveToPersistentStore()}
        default:
            return
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddBookSegue" {
            guard let destinationVC = segue.destination as? AddDetailViewController else {return}
            destinationVC.bookController = bookController
        } else if segue.identifier == "BookDetailSegue" {
            guard let destinationVC = segue.destination as? AddDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else {return}
            destinationVC.bookController = bookController
            destinationVC.book = bookController.books[indexPath.row]
        }
    }

}
