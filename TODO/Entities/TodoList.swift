//
//  TodoList.swift
//  TODO
//
//  Created by Blink22 on 7/27/20.
//  Copyright © 2020 Blink22. All rights reserved.
//

import Foundation
import UIKit

class TodoList {
    @Published var todos: [TodoItem] = []
    
    private static var instance = TodoList()
    
    private init() {
        load()
    }
    
    class func getInstance() -> TodoList {
        return instance
    }
    
    func load() {
        todos.append(TodoItem(name: "todo1", description: "description1"))
        todos.append(TodoItem(name: "todo2", description: "description2"))
        todos.append(TodoItem(name: "todo3", description: "description3"))
        todos.append(TodoItem(name: "todo4", description: "description4"))
    }
    
    func save() {
    }
    
    func getCount() -> Int {
        return todos.count
    }
    
    func addNewTodo(todo: TodoItem) {
        todos.insert(todo, at: 0)
    }
    
    
    func removeTodo(todo: TodoItem) {
        print(todo.id)
        todos.removeAll {$0.id == todo.id}
    }
    
    func todo(at indexPath: IndexPath) -> TodoItem {
      todos[indexPath.row]
    }
    
//    func append(todo: TodoItem, to tableView: UITableView) {
//      todos.insert(todo, at: 0)
//      tableView.insertRows(at: [IndexPath(row: todos.count-1, section: 0)], with: .automatic)
//    }
}
