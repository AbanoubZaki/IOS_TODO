//
//  TodoList.swift
//  TODO
//
//  Created by Blink22 on 7/27/20.
//  Copyright © 2020 Blink22. All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase

class TodoList {
    @Published var todos: [TodoItem] = []
    
    private static var instance = TodoList()
    
    private var ref = Database.database().reference()

    private init() {
        load()
    }
    
    class func getInstance() -> TodoList {
        return instance
    }
    
    func load() {
        DispatchQueue.global().async {
            self.ref.child("todos").observeSingleEvent(of: .value){ (snapshot) in
               for child in snapshot.children.allObjects as! [DataSnapshot]{
                   
                   let id = child.key
                   let todosRef = self.ref.child("todos").child(id)
                   
                   todosRef.observeSingleEvent(of: .value, with: { (todoSnapshot) in
                       let todo = todoSnapshot.value as? NSDictionary
                       let name = todo!["name"] as? String
                       let description = todo!["description"] as? String
                       self.todos.append(TodoItem(name: name!, description: description!, id: id))
                   })

               }
            }
        }
    }
    
    func getCount() -> Int {
        return todos.count
    }
    
    func addNewTodo(todo: TodoItem) {
        self.ref.child("todos").child(todo.id).updateChildValues(["name": todo.name,"description": todo.description])

        todos.insert(todo, at: 0)
    }
    
    
    func removeTodo(todo: TodoItem) {
        ref.child("todos").child(todo.id).removeValue()
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
