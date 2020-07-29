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
    private let router = TodoListRouter()
    
    @Published var todos: [TodoItem] = []
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        self.interactor = TodoListInteractor()
        interactor.model.$todos
        .assign(to: \.todos, on: self)
        .store(in: &cancellables)
    }

    func openNewTodoView(viewController: UIViewController) {
        router.makeNewTodoView(viewController: viewController)
    }
    
    func openTodoDetailsView(viewController: UIViewController, for todo: TodoItem) {
        router.makeTodoDetailsView(viewController: viewController, for: todo)
    }
    
    func addNewTodo(todo: TodoItem) {
        interactor.addNewTodo(todo: todo)
    }
    
    func deleteTodo(todo: TodoItem) {
      interactor.deleteTodo(todo: todo)
    }

}
