//
//  TaskViewController.swift
//  ToDoList
//
//  Created by Xiaolue Peng on 5/7/20.
//  Copyright © 2020 Xiaolue Peng. All rights reserved.
//

import UIKit
import RealmSwift

class TaskViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!

    private let realm = try! Realm()
    
    static let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        return dateFormatter
    }()
    
    var deletionHandler: (() -> Void)?
    
    var item: TodoItemModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleteTask))
        
        if let currItem = item {
            titleLabel.text = currItem.title
            dateLabel.text = Self.dateFormatter.string(from: currItem.date!)
        }
    }

    @objc func deleteTask() {
        guard let deleteItem = item else {
            return
        }
        
        realm.beginWrite()
        realm.delete(deleteItem)
        try! realm.commitWrite()
        
        deletionHandler?()
        navigationController?.popViewController(animated: true)
    }
}
