//
//  EntryViewController.swift
//  ToDoList
//
//  Created by Xiaolue Peng on 5/7/20.
//  Copyright © 2020 Xiaolue Peng. All rights reserved.
//

import UIKit
import RealmSwift

class EntryViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    
    private let realm = try! Realm()
    
    var completionHandler: (() -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveTask))
        textField.delegate = self
        
        datePicker.setDate(Date(), animated: true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveTask()
        
        return true
    }
    
    @objc func saveTask() {
        guard let title = textField.text else {return}
        
        realm.beginWrite()
        
        let model = TodoItemModel()
        model.title = title
        model.date = datePicker.date
        
        realm.add(model)
        try! realm.commitWrite()
        
        completionHandler?()
        
        navigationController?.popViewController(animated: true)
    }
}
