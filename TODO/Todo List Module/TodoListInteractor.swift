//
//  TodoListInteractor.swift
//  TODO
//
//  Created by Blink22 on 7/27/20.
//  Copyright © 2020 Blink22. All rights reserved.
//

import Foundation

class TodoListInteractor {
    var model = TodoList.getInstance()
    
    func addNewTodo(todo: TodoItem) {
        model.addNewTodo(todo: todo)
    }
    
    func deleteTodo(todo: TodoItem) {
        model.removeTodo(todo: todo)
    }

}
