//
//  TodoListPresenter.swift
//  TODO
//
//  Created by Blink22 on 7/27/20.
//  Copyright © 2020 Blink22. All rights reserved.
//

import Foundation
import SwiftUI
import Combine

class TodoListPresenter: ObservableObject {
    private let interactor: TodoListInteractor
    private var router: TodoListRouter
        
    init() {
        self.interactor = TodoListInteractor()
        self.router = TodoListRouter()
    }

    func openNewTodoView(viewController: UIViewController) {
        router.makeNewTodoView(viewController: viewController)
    }
    
    func openTodoDetailsView(viewController: UIViewController, for todo: TodoItem, index: IndexPath) {
        router.makeTodoDetailsView(viewController: viewController, for: todo, index: index)
    }
    
    func addNewTodo(todo: TodoItem) {
        interactor.addNewTodo(todo: todo)
    }
    
    func deleteTodo(todo: TodoItem) {
      interactor.deleteTodo(todo: todo)
    }

}
