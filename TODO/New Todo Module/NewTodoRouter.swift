//
//  NewTodoRouter.swift
//  TODO
//
//  Created by Blink22 on 8/6/20.
//  Copyright © 2020 Blink22. All rights reserved.
//

import UIKit

class NewTodoRouter {
    
    internal weak var delegate: TodoListViewController?
    
    func load (viewController: TodoListViewController) {
        delegate = viewController
        let main = UIStoryboard(name: "Main", bundle: nil)
        let addNewTodo = main.instantiateViewController(withIdentifier: "addNewTodo")
        addNewTodo.modalPresentationStyle = .fullScreen

        viewController.present(addNewTodo, animated: true, completion: nil)
    }
}
