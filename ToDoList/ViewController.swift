//
//  ViewController.swift
//  ToDoList
//
//  Created by Xiaolue Peng on 5/6/20.
//  Copyright © 2020 Xiaolue Peng. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private let realm = try! Realm()
    
    private var tasks = [TodoItemModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initView()
        refreshData()
    }
    
    @available(iOS 13.0, *)
    @IBAction func didTapAdd(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "entry") as! EntryViewController
        vc.title = "New Task"
        vc.completionHandler = {
            DispatchQueue.main.async {
                autoreleasepool {
                    self.refreshData()
                }
            }
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func refreshData() {
        tasks = realm.objects(TodoItemModel.self).map({ $0 })
        tableView.reloadData()
    }
    
    func initView() {
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row].title
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "task") as! TaskViewController
        vc.title = "Task"
        vc.item = tasks[indexPath.row]
        
        vc.deletionHandler = {
            DispatchQueue.main.async{[weak self] in
                self?.refreshData()
            }
        }
        navigationController?.pushViewController(vc, animated: true)
    }
    
}

