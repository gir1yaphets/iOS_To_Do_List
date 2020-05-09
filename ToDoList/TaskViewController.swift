//
//  TaskViewController.swift
//  ToDoList
//
//  Created by Xiaolue Peng on 5/7/20.
//  Copyright © 2020 Xiaolue Peng. All rights reserved.
//

import UIKit

class TaskViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    var task: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        label.text = task
    }

}
