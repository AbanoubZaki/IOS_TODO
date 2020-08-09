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
        self.model.addNewTodo(todo: todo) { message, todos in
            if message == "success" {
                //call back success
            } else {
                //call back failed
                print ("Error in loading data")
            }
        }
    }
    
    func deleteTodo(todo: TodoItem) {
        model.removeTodo(todo: todo)
    }

}
