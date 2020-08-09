//
//  TodoDetailsPresenter.swift
//  TODO
//
//  Created by Blink22 on 7/29/20.
//  Copyright © 2020 Blink22. All rights reserved.
//

import UIKit

class TodoDetailsPresenter: ObservableObject {
    private weak var view: TodoDetailsViewController?
    private var interactor: TodoDetailsInteractor
    private var router: TodoDetailsRouter
    
    init(view: TodoDetailsViewController, interactor: TodoDetailsInteractor, router: TodoDetailsRouter) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension TodoDetailsPresenter {
    func close() {
        view?.close()
    }
    
    func editTodo(for todo: TodoItem, index: IndexPath) {
        interactor.editTodo(for: todo, index: index, presenter: self)
    }
    
    func todoEditedSuccessfully() {
        view?.close()
    }
    
    func todoEditingFailed() {
//        view?.newTodoAddingFailed()
    }
}
