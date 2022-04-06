//
//  ToDoItemModel.swift
//  ToDoList
//
//  Created by Xiaolue Peng on 5/8/20.
//  Copyright © 2020 Xiaolue Peng. All rights reserved.
//

import Foundation
import RealmSwift

class TodoItemModel: Object {
    @objc dynamic var title = ""
    @objc dynamic var detail = ""
    @objc dynamic var date: Date?
}
