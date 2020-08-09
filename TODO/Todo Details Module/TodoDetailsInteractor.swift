//
//  TodoDetailsInteractor.swift
//  TODO
//
//  Created by Blink22 on 7/30/20.
//  Copyright © 2020 Blink22. All rights reserved.
//

import UIKit
import FirebaseStorage

class TodoDetailsInteractor {
    
    private var model: TodoList!
    private var newTodo: TodoItem!
    private weak var presenter: TodoDetailsPresenter?
    
    init() {
        self.model = TodoList.getInstance()
    }
    
    func editTodo(for todo: TodoItem, index: IndexPath, presenter: TodoDetailsPresenter) {
        self.presenter = presenter
        print("entered the back code for saving a todo")
        model.editTodo(at: index, newName: todo.name, newDescription: todo.description) { message, todos in
            if message == "success" {
                print ("Todo updated successfully")
                self.presenter?.todoEditedSuccessfully()
            } else {
                print ("Error in updating todo")
                self.presenter?.todoEditingFailed()
            }
        }
    }
    
}
