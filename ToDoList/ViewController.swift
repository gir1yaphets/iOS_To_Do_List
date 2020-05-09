//
//  ViewController.swift
//  ToDoList
//
//  Created by Xiaolue Peng on 5/6/20.
//  Copyright © 2020 Xiaolue Peng. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var tasks = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        loadUserSetting()
        
    }
    
    @available(iOS 13.0, *)
    @IBAction func didTapAdd(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "entry") as! EntryViewController
        vc.title = "New Task"
        vc.update = {
            DispatchQueue.main.async {
                self.updateTask()
            }
        }
        navigationController?.pushViewController(vc, animated: false)
    }
    
    func initView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        updateTask()
    }
    
    func updateTask() {
        tasks.removeAll()
        guard let count = UserDefaults().value(forKey: "count") as? Int else {
            return
        }
        
        for n in 0..<count {
            if let task = UserDefaults().value(forKey: "task_\(n+1)") as? String {
                tasks.append(task)
            }
        }

        tableView.reloadData()
    }
    
    func loadUserSetting() {
        if !UserDefaults().bool(forKey: "setup") {
            UserDefaults().set(true, forKey: "setup")
            UserDefaults().set(true, forKey: "count")
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row]
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "task") as! TaskViewController
        vc.title = "Task"
        vc.task = tasks[indexPath.row]
        navigationController?.pushViewController(vc, animated: false)
    }
    
}

