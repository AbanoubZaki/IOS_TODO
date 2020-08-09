//
//  NewTodoPresenter.swift
//  TODO
//
//  Created by Blink22 on 7/27/20.
//  Copyright © 2020 Blink22. All rights reserved.
//

import UIKit

class NewTodoPresenter: ObservableObject {
    private weak var view: NewTodoViewController?
    private var interactor: NewTodoInteractor
    private var router: NewTodoRouter
    
    init(view: NewTodoViewController, interactor: NewTodoInteractor, router: NewTodoRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension NewTodoPresenter {
    func close() {
        view?.close()
    }
    
    func addNewTodo(todo: TodoItem, image: UIImage?) {
        interactor.addNewTodo(todo: todo, image: image, presenter: self)
    }
    
    func newTodoAddedSuccessfully() {
        view?.close()
    }
    
    func newTodoAddingFailed() {
        view?.newTodoAddingFailed()
    }
}
