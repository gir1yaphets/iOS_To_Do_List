//
//  EntryViewController.swift
//  ToDoList
//
//  Created by Xiaolue Peng on 5/7/20.
//  Copyright © 2020 Xiaolue Peng. All rights reserved.
//

import UIKit

class EntryViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    var update: (()->Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Save", style: .done, target: self, action: #selector(saveTask))
        textField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        saveTask()
        
        return true
    }
    
    @objc func saveTask() {
        guard let text = textField.text else {return}
        
        guard let count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }
        
        UserDefaults().set(count + 1, forKey: "count")
        UserDefaults().set(text, forKey: "task_\(count + 1)")
        
        update?()
        
        navigationController?.popViewController(animated: true)
    }
}
